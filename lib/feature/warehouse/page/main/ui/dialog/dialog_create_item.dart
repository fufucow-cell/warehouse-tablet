import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_cabinet_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/children.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:flutter_smart_home_tablet/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/util/root_router_util.dart';

/// 创建物品对话框
class DialogCreateItem {
  /// 显示创建物品对话框
  static void show({
    required List<Category> categories,
    required List<Cabinet> cabinets,
    Function(
      String name,
      String? description,
      String? categoryId,
      int quantity,
      int? minStockAlert,
      String? roomId,
      String? cabinetId,
    )? onConfirm,
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
      builder: (context) => _CreateItemDialogWidget(
        categories: categories,
        cabinets: cabinets,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }
}

/// 创建物品对话框 Widget
class _CreateItemDialogWidget extends StatefulWidget {
  final List<Category> categories;
  final List<Cabinet> cabinets;
  final Function(
    String name,
    String? description,
    String? categoryId,
    int quantity,
    int? minStockAlert,
    String? roomId,
    String? cabinetId,
  )? onConfirm;
  final VoidCallback? onCancel;

  const _CreateItemDialogWidget({
    required this.categories,
    required this.cabinets,
    this.onConfirm,
    this.onCancel,
  });

  @override
  State<_CreateItemDialogWidget> createState() =>
      _CreateItemDialogWidgetState();
}

class _CreateItemDialogWidgetState
    extends State<_CreateItemDialogWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _minStockAlertController =
      TextEditingController();

  // 选中的分类
  Category? _selectedLevel1;
  Category? _selectedLevel2;
  Category? _selectedLevel3;

  // 选中的房间和橱柜
  String? _selectedRoomId;
  String? _selectedCabinetId;

  // 上传的图片
  String? _uploadedImagePath;

  @override
  void initState() {
    super.initState();
    // 默认选中第一个 level1 分类（如果有）
    final level1Categories =
        widget.categories.where((c) => c.level == 1).toList();
    if (level1Categories.isNotEmpty) {
      _selectedLevel1 = level1Categories.first;
      _updateLevel2FromLevel1();
    }
    // 房间默认为"未設定"，不预设选择
    // 这样用户可以选择未绑定房间的橱柜
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _minStockAlertController.dispose();
    super.dispose();
  }

  /// 将 Children 转换为 Category
  Category? childrenToCategory(Children? children) {
    if (children == null) {
      return null;
    }
    return Category(
      categoryId: children.categoryId,
      name: children.name,
      parentId: children.parentId,
      level: children.level,
      children: children.children is Map<String, dynamic>
          ? Children.fromJson(
              children.children as Map<String, dynamic>,
            )
          : null,
    );
  }

  /// 从 Level 1 更新 Level 2 选项
  void _updateLevel2FromLevel1() {
    if (_selectedLevel1 == null) {
      _selectedLevel2 = null;
      _selectedLevel3 = null;
      return;
    }

    if (_selectedLevel1!.children != null) {
      _selectedLevel2 = childrenToCategory(_selectedLevel1!.children);
      _updateLevel3FromLevel2();
    } else {
      _selectedLevel2 = null;
      _selectedLevel3 = null;
    }
  }

  /// 从 Level 2 更新 Level 3 选项
  void _updateLevel3FromLevel2() {
    if (_selectedLevel2 == null) {
      _selectedLevel3 = null;
      return;
    }

    if (_selectedLevel2!.children != null) {
      _selectedLevel3 = childrenToCategory(_selectedLevel2!.children);
    } else {
      _selectedLevel3 = null;
    }
  }

  /// 获取 Level 2 选项列表
  List<DropdownMenuItem<Category?>> _getLevel2Items() {
    final items = <DropdownMenuItem<Category?>>[
      const DropdownMenuItem<Category?>(
        value: null,
        child: Text('未設定'),
      ),
    ];

    if (_selectedLevel1 != null && _selectedLevel1!.children != null) {
      final level2Category = childrenToCategory(_selectedLevel1!.children);
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

  /// 获取 Level 3 选项列表
  List<DropdownMenuItem<Category?>> _getLevel3Items() {
    final items = <DropdownMenuItem<Category?>>[
      const DropdownMenuItem<Category?>(
        value: null,
        child: Text('未設定'),
      ),
    ];

    if (_selectedLevel2 != null && _selectedLevel2!.children != null) {
      final level3Category = childrenToCategory(_selectedLevel2!.children);
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

  /// 获取橱柜列表（根据选中的房间）
  List<DropdownMenuItem<String?>> _getCabinetItems() {
    final items = <DropdownMenuItem<String?>>[
      const DropdownMenuItem<String?>(
        value: null,
        child: Text('未設定'),
      ),
    ];

    // 根据选中的房间过滤橱柜
    List<Cabinet> filteredCabinets;
    if (_selectedRoomId != null) {
      // 如果选择了房间，显示该房间下的橱柜
      filteredCabinets = widget.cabinets
          .where((cabinet) => cabinet.roomId == _selectedRoomId)
          .toList();
    } else {
      // 如果房间选择"未設定"，显示未绑定房间的橱柜（room_id 为 null）
      filteredCabinets = widget.cabinets
          .where((cabinet) => cabinet.roomId == null)
          .toList();
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

  /// 获取选中的分类 ID
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

  /// 构建图片上传占位符
  Widget _buildImageUploadPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            '點擊上傳圖片',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final level1Categories =
        widget.categories.where((c) => c.level == 1).toList();
    final service = WarehouseService.instance;
    final rooms = service.rooms
        .map(
          (room) => WarehouseHomeRouterData(
            id: room.id ?? '',
            name: room.name ?? '',
          ),
        )
        .toList();

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
                    '新增物品',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(height: 24.0.scale),
                // 智能新增按钮
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: 实现智能新增功能（拍照识别物品）
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('智能新增'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                  ),
                ),
                SizedBox(height: 16.0.scale),
                // 图片上传区域
                GestureDetector(
                  onTap: () {
                    // TODO: 实现图片上传功能
                    // 可以选择从相册或拍照
                  },
                  child: Container(
                    height: 120.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _uploadedImagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              _uploadedImagePath!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildImageUploadPlaceholder();
                              },
                            ),
                          )
                        : _buildImageUploadPlaceholder(),
                  ),
                ),
                SizedBox(height: 16.0.scale),
                // 物品名称输入框
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: '物品名稱',
                    hintText: '請輸入物品名稱',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0.scale),
                // 描述输入框
                TextField(
                  controller: _descriptionController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: '描述',
                    hintText: '請輸入描述（選填）',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0.scale),
                // 數量输入框
                TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '數量',
                    hintText: '請輸入數量',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0.scale),
                // 最小庫存警报输入框
                TextField(
                  controller: _minStockAlertController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '最小庫存警报',
                    hintText: '請輸入最小庫存警报（選填）',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0.scale),
                // 階層1 下拉选单
                DropdownButtonFormField<Category?>(
                  value: _selectedLevel1,
                  decoration: const InputDecoration(
                    labelText: '階層1',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem<Category?>(
                      value: null,
                      child: Text('未設定'),
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
                // 階層2 下拉选单
                DropdownButtonFormField<Category?>(
                  value: _selectedLevel2,
                  decoration: const InputDecoration(
                    labelText: '階層2',
                    border: OutlineInputBorder(),
                  ),
                  items: _getLevel2Items(),
                  onChanged: _selectedLevel1 != null
                      ? (value) {
                          setState(() {
                            _selectedLevel2 = value;
                            _updateLevel3FromLevel2();
                          });
                        }
                      : null,
                ),
                SizedBox(height: 16.0.scale),
                // 階層3 下拉选单
                DropdownButtonFormField<Category?>(
                  value: _selectedLevel3,
                  decoration: const InputDecoration(
                    labelText: '階層3',
                    border: OutlineInputBorder(),
                  ),
                  items: _getLevel3Items(),
                  onChanged: _selectedLevel2 != null
                      ? (value) {
                          setState(() {
                            _selectedLevel3 = value;
                          });
                        }
                      : null,
                ),
                SizedBox(height: 16.0.scale),
                // 房间选择下拉选单
                DropdownButtonFormField<String?>(
                  value: _selectedRoomId,
                  decoration: const InputDecoration(
                    labelText: '房間',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
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
                // 橱柜选择下拉选单
                DropdownButtonFormField<String?>(
                  value: _selectedCabinetId,
                  decoration: const InputDecoration(
                    labelText: '櫥櫃',
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
                        final name = _nameController.text.trim();
                        if (name.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('請輸入物品名稱'),
                            ),
                          );
                          return;
                        }

                        final quantityText = _quantityController.text.trim();
                        if (quantityText.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('請輸入數量'),
                            ),
                          );
                          return;
                        }

                        final quantity = int.tryParse(quantityText);
                        if (quantity == null || quantity < 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('請輸入有效的數量'),
                            ),
                          );
                          return;
                        }

                        final description = _descriptionController.text.trim();
                        final minStockAlertText =
                            _minStockAlertController.text.trim();
                        final minStockAlert = minStockAlertText.isNotEmpty
                            ? int.tryParse(minStockAlertText)
                            : null;

                        Navigator.of(context).pop();
                        widget.onConfirm?.call(
                          name,
                          description.isEmpty ? null : description,
                          _getSelectedCategoryId(),
                          quantity,
                          minStockAlert,
                          _selectedRoomId,
                          _selectedCabinetId,
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
