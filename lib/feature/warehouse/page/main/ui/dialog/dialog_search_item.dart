import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_cabinet_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/children.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:flutter_smart_home_tablet/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/util/root_router_util.dart';

/// 物品搜索对话框
class DialogSearchItem {
  /// 显示物品搜索对话框
  static void show({
    required List<Category> categories,
    required List<Cabinet> cabinets,
    String? initialName,
    String? initialCategoryId,
    String? initialRoomId,
    String? initialCabinetId,
    Function({
      String? name,
      String? categoryId,
      String? roomId,
      String? cabinetId,
    })? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    final context = RootRouterUtil.instance.rootContext;
    if (context == null) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _SearchItemDialogWidget(
        categories: categories,
        cabinets: cabinets,
        initialName: initialName,
        initialCategoryId: initialCategoryId,
        initialRoomId: initialRoomId,
        initialCabinetId: initialCabinetId,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }
}

/// 物品搜索对话框 Widget
class _SearchItemDialogWidget extends StatefulWidget {
  final List<Category> categories;
  final List<Cabinet> cabinets;
  final String? initialName;
  final String? initialCategoryId;
  final String? initialRoomId;
  final String? initialCabinetId;
  final Function({
    String? name,
    String? categoryId,
    String? roomId,
    String? cabinetId,
  })? onConfirm;
  final VoidCallback? onCancel;

  const _SearchItemDialogWidget({
    required this.categories,
    required this.cabinets,
    this.initialName,
    this.initialCategoryId,
    this.initialRoomId,
    this.initialCabinetId,
    this.onConfirm,
    this.onCancel,
  });

  @override
  State<_SearchItemDialogWidget> createState() =>
      _SearchItemDialogWidgetState();
}

class _SearchItemDialogWidgetState extends State<_SearchItemDialogWidget> {
  final TextEditingController _nameController = TextEditingController();

  // 选中的分类（三级分类）
  Category? _selectedLevel1;
  Category? _selectedLevel2;
  Category? _selectedLevel3;

  // 选中的房间和橱柜
  String? _selectedRoomId;
  String? _selectedCabinetId;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName ?? '';
    _selectedRoomId = widget.initialRoomId;
    _selectedCabinetId = widget.initialCabinetId;

    // 根据 initialCategoryId 初始化分类选择
    if (widget.initialCategoryId != null) {
      _initializeCategoryFromId(widget.initialCategoryId!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // 根据分类 ID 初始化分类选择
  void _initializeCategoryFromId(String categoryId) {
    // 遍历所有分类找到匹配的分类
    for (final category in widget.categories) {
      if (category.categoryId == categoryId) {
        _selectedLevel1 = category;
        _updateLevel2FromLevel1();
        return;
      }

      // 检查子分类
      final level2 = _childrenToCategory(category.children);
      if (level2 != null && level2.categoryId == categoryId) {
        _selectedLevel1 = category;
        _selectedLevel2 = level2;
        _updateLevel3FromLevel2();
        return;
      }

      // 检查三级分类
      if (level2 != null && level2.children != null) {
        final level3 = _childrenToCategory(level2.children);
        if (level3 != null && level3.categoryId == categoryId) {
          _selectedLevel1 = category;
          _selectedLevel2 = level2;
          _selectedLevel3 = level3;
          return;
        }
      }
    }
  }

  // 将 Children 转换为 Category
  Category? _childrenToCategory(dynamic children) {
    if (children == null) return null;
    if (children is Children) {
      return Category(
        categoryId: children.categoryId,
        name: children.name,
        level: children.level,
        children: children.children is Map<String, dynamic>
            ? Children.fromJson(
                children.children as Map<String, dynamic>,
              )
            : null,
      );
    }
    return null;
  }

  // 从 Level 1 更新 Level 2 选项
  void _updateLevel2FromLevel1() {
    if (_selectedLevel1 == null) {
      _selectedLevel2 = null;
      _selectedLevel3 = null;
      return;
    }

    // 选择 Level 1 后，分类2 默认设为 null（全部），分类3 也重置
    _selectedLevel2 = null;
    _selectedLevel3 = null;
  }

  // 从 Level 2 更新 Level 3 选项
  void _updateLevel3FromLevel2() {
    if (_selectedLevel2 == null) {
      _selectedLevel3 = null;
      return;
    }

    // 选择 Level 2 后，分类3 默认设为 null（全部）
    _selectedLevel3 = null;
  }

  // 获取选中的分类 ID
  String? _getSelectedCategoryId() {
    if (_selectedLevel3 != null) {
      return _selectedLevel3!.categoryId;
    } else if (_selectedLevel2 != null) {
      return _selectedLevel2!.categoryId;
    } else if (_selectedLevel1 != null) {
      return _selectedLevel1!.categoryId;
    }
    return null;
  }

  // 获取 Level 2 选项列表
  List<DropdownMenuItem<Category?>> _getLevel2Items() {
    final items = <DropdownMenuItem<Category?>>[
      const DropdownMenuItem<Category?>(
        value: null,
        child: Text('全部'),
      ),
    ];

    // 如果选择了 Level 1 的既有分类且有 children，添加既有分类选项
    if (_selectedLevel1 != null && _selectedLevel1!.children != null) {
      final level2Category = _childrenToCategory(_selectedLevel1!.children);
      if (level2Category != null) {
        items.add(
          DropdownMenuItem<Category?>(
            value: level2Category,
            child: Text(level2Category.name ?? ''),
          ),
        );
      }
    }

    return items;
  }

  // 获取 Level 3 选项列表
  List<DropdownMenuItem<Category?>> _getLevel3Items() {
    final items = <DropdownMenuItem<Category?>>[
      const DropdownMenuItem<Category?>(
        value: null,
        child: Text('全部'),
      ),
    ];

    // 如果选择了 Level 2 的既有分类且有 children，添加既有分类选项
    if (_selectedLevel2 != null && _selectedLevel2!.children != null) {
      final level3Category = _childrenToCategory(_selectedLevel2!.children);
      if (level3Category != null) {
        items.add(
          DropdownMenuItem<Category?>(
            value: level3Category,
            child: Text(level3Category.name ?? ''),
          ),
        );
      }
    }

    return items;
  }

  // 获取橱柜列表（根据选中的房间）
  List<DropdownMenuItem<String?>> _getCabinetItems() {
    final items = <DropdownMenuItem<String?>>[
      const DropdownMenuItem<String?>(
        value: null,
        child: Text('全部'),
      ),
      // 未設定選項
      const DropdownMenuItem<String?>(
        value: '__UNSET__',
        child: Text('未設定'),
      ),
    ];

    List<Cabinet> filteredCabinets;
    if (_selectedRoomId != null && _selectedRoomId != '__UNSET__') {
      // 如果选择了房间，显示该房间下的橱柜
      filteredCabinets = widget.cabinets
          .where((cabinet) => cabinet.roomId == _selectedRoomId)
          .toList();
    } else if (_selectedRoomId == '__UNSET__') {
      // 如果选择了"未設定"，显示未绑定房间的橱柜
      filteredCabinets = widget.cabinets
          .where((cabinet) => cabinet.roomId == null)
          .toList();
    } else {
      // 显示所有橱柜
      filteredCabinets = widget.cabinets;
    }

    for (final cabinet in filteredCabinets) {
      if (cabinet.cabinetId != null && cabinet.name != null) {
        items.add(
          DropdownMenuItem<String?>(
            value: cabinet.cabinetId,
            child: Text(cabinet.name!),
          ),
        );
      }
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    // 获取房间数据
    final service = WarehouseService.instance;
    final rooms = service.rooms
        .map(
          (room) => WarehouseHomeRouterData(
            id: room.id ?? '',
            name: room.name ?? '',
          ),
        )
        .toList();

    // 获取所有一级分类
    final level1Categories =
        widget.categories.where((c) => c.level == 1).toList();

    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32.0.scale),
          padding: EdgeInsets.all(24.0.scale),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
          constraints: BoxConstraints(
            maxWidth: 600.0.scale,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title 居中
                Center(
                  child: Text(
                    '搜尋',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(height: 24.0.scale),
                // 名稱輸入框
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: '名稱',
                    hintText: '請輸入物品名稱',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0.scale),
                // 階層1 下拉選單
                DropdownButtonFormField<Category?>(
                  value: _selectedLevel1,
                  decoration: const InputDecoration(
                    labelText: '分類',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem<Category?>(
                      value: null,
                      child: Text('全部'),
                    ),
                    ...level1Categories.map((category) {
                      return DropdownMenuItem<Category?>(
                        value: category,
                        child: Text(category.name ?? ''),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedLevel1 = value;
                      _updateLevel2FromLevel1();
                    });
                  },
                ),
                SizedBox(height: 16.0.scale),
                // 階層2 下拉選單（仅在选择了 Level 1 时显示）
                if (_selectedLevel1 != null)
                  DropdownButtonFormField<Category?>(
                    value: _selectedLevel2,
                    decoration: const InputDecoration(
                      labelText: '分類（階層2）',
                      border: OutlineInputBorder(),
                    ),
                    items: _getLevel2Items(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLevel2 = value;
                        _updateLevel3FromLevel2();
                      });
                    },
                  ),
                if (_selectedLevel1 != null) SizedBox(height: 16.0.scale),
                // 階層3 下拉選單（仅在选择了 Level 2 时显示）
                if (_selectedLevel2 != null)
                  DropdownButtonFormField<Category?>(
                    value: _selectedLevel3,
                    decoration: const InputDecoration(
                      labelText: '分類（階層3）',
                      border: OutlineInputBorder(),
                    ),
                    items: _getLevel3Items(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLevel3 = value;
                      });
                    },
                  ),
                if (_selectedLevel2 != null) SizedBox(height: 16.0.scale),
                SizedBox(height: 16.0.scale),
                // 房間選擇下拉選單
                DropdownButtonFormField<String?>(
                  value: _selectedRoomId,
                  decoration: const InputDecoration(
                    labelText: '所屬房間',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('全部'),
                    ),
                    // 未設定選項
                    const DropdownMenuItem<String?>(
                      value: '__UNSET__',
                      child: Text('未設定'),
                    ),
                    ...rooms.map((room) {
                      return DropdownMenuItem<String?>(
                        value: room.id,
                        child: Text(room.name),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedRoomId = value;
                      _selectedCabinetId = null; // 切换房间时重置橱柜选择
                    });
                  },
                ),
                SizedBox(height: 16.0.scale),
                // 櫥櫃選擇下拉選單
                DropdownButtonFormField<String?>(
                  value: _selectedCabinetId,
                  decoration: const InputDecoration(
                    labelText: '所屬櫥櫃',
                    border: OutlineInputBorder(),
                  ),
                  items: _getCabinetItems(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCabinetId = value;
                    });
                  },
                ),
                SizedBox(height: 24.0.scale),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onCancel?.call();
                      },
                      child: const Text('取消'),
                    ),
                    SizedBox(width: 12.0.scale),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onConfirm?.call(
                          name: _nameController.text.trim().isEmpty
                              ? null
                              : _nameController.text.trim(),
                          categoryId: _getSelectedCategoryId(),
                          roomId: _selectedRoomId,
                          cabinetId: _selectedCabinetId,
                        );
                      },
                      child: const Text('確認'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
