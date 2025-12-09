import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/children.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/temp_router_util.dart';

/// 创建分类对话框
class DialogCreateCategory {
  /// 显示创建分类对话框
  static void show({
    required List<Category> categories,
    Function(String name, String? parentId)? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    final context = TempRouterUtil.getRootContext();
    if (context == null) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _CreateCategoryDialogWidget(
        categories: categories,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }
}

/// 创建分类对话框 Widget
class _CreateCategoryDialogWidget extends StatefulWidget {
  final List<Category> categories;
  final Function(String name, String? parentId)? onConfirm;
  final VoidCallback? onCancel;

  const _CreateCategoryDialogWidget({
    required this.categories,
    this.onConfirm,
    this.onCancel,
  });

  @override
  State<_CreateCategoryDialogWidget> createState() =>
      _CreateCategoryDialogWidgetState();
}

class _CreateCategoryDialogWidgetState
    extends State<_CreateCategoryDialogWidget> {
  final TextEditingController _level1NameController =
      TextEditingController();
  final TextEditingController _level2NameController =
      TextEditingController();
  final TextEditingController _level3NameController =
      TextEditingController();

  // 选中的分类
  Category? _selectedLevel1;
  Category? _selectedLevel2;
  Category? _selectedLevel3;

  @override
  void initState() {
    super.initState();
    // 默认选中 Level 1 的第一个既有分类
    final level1Categories = widget.categories
        .where((c) => c.level == 1)
        .toList();
    if (level1Categories.isNotEmpty) {
      _selectedLevel1 = level1Categories.first;
      _updateLevel2FromLevel1();
      _updateInputFields();
    }
  }

  @override
  void dispose() {
    _level1NameController.dispose();
    _level2NameController.dispose();
    _level3NameController.dispose();
    super.dispose();
  }

  /// 将 Children 转换为 Category
  Category? childrenToCategory(Children? children) {
    if (children == null) return null;
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
      // 选择的是"新增分類"，level2 和 level3 都重置
      _selectedLevel2 = null;
      _selectedLevel3 = null;
      return;
    }

    // 如果选择的是 level1 的既有分类，自动选到 level1 children 的第一项分类
    if (_selectedLevel1!.children != null) {
      _selectedLevel2 =
          childrenToCategory(_selectedLevel1!.children);
      _updateLevel3FromLevel2();
    } else {
      // children 为 null，显示"新增分類"并自动选中
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

    // 获取 level 2 的第一个子分类（level 3）
    if (_selectedLevel2!.children != null) {
      _selectedLevel3 =
          childrenToCategory(_selectedLevel2!.children);
    } else {
      _selectedLevel3 = null;
    }
  }

  /// 获取 Level 2 选项列表
  List<DropdownMenuItem<Category?>> _getLevel2Items() {
    final items = <DropdownMenuItem<Category?>>[
      DropdownMenuItem<Category?>(
        value: null,
        child: Text(EnumLocale.optionNewCategory.tr),
      ),
    ];

    // 如果选择了 level1 的既有分类且有 children，添加既有分类选项
    if (_selectedLevel1 != null &&
        _selectedLevel1!.children != null) {
      final level2Category =
          childrenToCategory(_selectedLevel1!.children);
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
      DropdownMenuItem<Category?>(
        value: null,
        child: Text(EnumLocale.optionNewCategory.tr),
      ),
    ];

    // 如果选择了 level2 的既有分类且有 children，添加既有分类选项
    if (_selectedLevel2 != null &&
        _selectedLevel2!.children != null) {
      final level3Category =
          childrenToCategory(_selectedLevel2!.children);
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

  /// 更新输入框状态和内容
  void _updateInputFields() {
    setState(() {
      // Level 1: 如果选择的是既有分类，显示名称；如果选择"新增分類"，保留用户输入或清空
      if (_selectedLevel1 != null) {
        _level1NameController.text =
            _selectedLevel1!.name ?? '';
      }
      // 当选择"新增分類"时，如果输入框内容匹配之前选择的既有分类名称，则清空
      // 否则保留用户已输入的内容

      // Level 2: 如果选择的是既有分类，显示名称；如果选择"新增分類"，保留用户输入或清空
      if (_selectedLevel2 != null) {
        _level2NameController.text =
            _selectedLevel2!.name ?? '';
      }

      // Level 3: 如果选择的是既有分类，显示名称；如果选择"新增分類"，保留用户输入或清空
      if (_selectedLevel3 != null) {
        _level3NameController.text =
            _selectedLevel3!.name ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 获取所有一级分类
    final level1Categories = widget.categories
        .where((c) => c.level == 1)
        .toList();

    final dialogInsetPadding =
        30.0.scale > 0 ? 30.0.scale : 30.0;
    return Dialog(
      insetPadding: EdgeInsets.all(dialogInsetPadding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth =
              MediaQuery.of(context).size.width;
          final scale600 = 600.0.scale;
          final scale60 = 60.0.scale;
          final scale40 = 40.0.scale;
          final scale8 = 8.0.scale;
          final dialogMaxWidth =
              scale600 > 0 ? scale600 : 600.0;
          final insetPaddingValue =
              scale60 > 0 ? scale60 : 60.0;
          final containerPaddingValue =
              scale40 > 0 ? scale40 : 40.0;
          final horizontalPaddingValue =
              scale8 > 0 ? scale8 : 8.0;
          final screenMinusPadding =
              screenWidth - (insetPaddingValue * 2);
          final dialogWidth =
              (dialogMaxWidth < screenMinusPadding)
                  ? dialogMaxWidth
                  : screenMinusPadding;
          final maxHeight =
              MediaQuery.of(context).size.height * 0.8;
          return Container(
            width: dialogWidth,
            padding: EdgeInsets.all(containerPaddingValue),
            constraints: BoxConstraints(
              maxWidth: dialogWidth,
              maxHeight: maxHeight,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  // Title 居中
                  Center(
                    child: Text(
                      EnumLocale.createCategoryTitle.tr,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // Level 1 下拉选单
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child:
                        DropdownButtonFormField<Category?>(
                      value: _selectedLevel1,
                      decoration: InputDecoration(
                        labelText:
                            EnumLocale.createLevel1.tr,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem<Category?>(
                          value: null,
                          child: Text(
                            EnumLocale.optionNewCategory.tr,
                          ),
                        ),
                        ...level1Categories.map((category) {
                          return DropdownMenuItem<
                              Category?>(
                            value: category,
                            child:
                                Text(category.name ?? ''),
                          );
                        }),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedLevel1 = value;
                          _updateLevel2FromLevel1();
                          _updateInputFields();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Level 1 输入框
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: TextField(
                      controller: _level1NameController,
                      enabled: _selectedLevel1 == null,
                      decoration: InputDecoration(
                        labelText: EnumLocale
                            .createCategoryNameLevel1.tr,
                        hintText: _selectedLevel1 == null
                            ? EnumLocale
                                .createCategoryNameHint.tr
                            : EnumLocale
                                .createCategorySelected.tr,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  // Level 2 下拉选单
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child:
                        DropdownButtonFormField<Category?>(
                      value: _selectedLevel2,
                      decoration: InputDecoration(
                        labelText:
                            EnumLocale.createLevel2.tr,
                        border: const OutlineInputBorder(),
                      ),
                      items: _getLevel2Items(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLevel2 = value;
                          _updateLevel3FromLevel2();
                          _updateInputFields();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Level 2 输入框
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: TextField(
                      controller: _level2NameController,
                      enabled: _selectedLevel2 == null &&
                          _selectedLevel1 != null,
                      decoration: InputDecoration(
                        labelText: EnumLocale
                            .createCategoryNameLevel2.tr,
                        hintText: _selectedLevel2 == null &&
                                _selectedLevel1 != null
                            ? EnumLocale
                                .createCategoryNameHint.tr
                            : (_selectedLevel2 != null
                                ? EnumLocale
                                    .createCategorySelected
                                    .tr
                                : EnumLocale
                                    .createCategorySelectLevel1First
                                    .tr),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  // Level 3 下拉选单
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child:
                        DropdownButtonFormField<Category?>(
                      value: _selectedLevel3,
                      decoration: InputDecoration(
                        labelText:
                            EnumLocale.createLevel3.tr,
                        border: const OutlineInputBorder(),
                      ),
                      items: _getLevel3Items(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLevel3 = value;
                          _updateInputFields();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Level 3 输入框
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: TextField(
                      controller: _level3NameController,
                      enabled: _selectedLevel3 == null &&
                          _selectedLevel2 != null,
                      decoration: InputDecoration(
                        labelText: EnumLocale
                            .createCategoryNameLevel3.tr,
                        hintText: _selectedLevel3 == null &&
                                _selectedLevel2 != null
                            ? EnumLocale
                                .createCategoryNameHint.tr
                            : (_selectedLevel3 != null
                                ? EnumLocale
                                    .createCategorySelected
                                    .tr
                                : EnumLocale
                                    .createCategorySelectLevel2First
                                    .tr),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onCancel?.call();
                          },
                          child: Text(
                            EnumLocale.commonCancel.tr,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        ElevatedButton(
                          onPressed: () {
                            String? name;
                            String? parentId;

                            // 确定要创建的分类级别和名称
                            if (_selectedLevel3 == null &&
                                _selectedLevel2 != null) {
                              // 创建 Level 3 分类
                              name = _level3NameController
                                  .text
                                  .trim();
                              if (name.isEmpty) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      EnumLocale
                                          .createCategoryInputLevel3Name
                                          .tr,
                                    ),
                                  ),
                                );
                                return;
                              }
                              parentId = _selectedLevel2!
                                  .categoryId;
                            } else if (_selectedLevel2 ==
                                    null &&
                                _selectedLevel1 != null) {
                              // 创建 Level 2 分类
                              name = _level2NameController
                                  .text
                                  .trim();
                              if (name.isEmpty) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      EnumLocale
                                          .createCategoryInputLevel2Name
                                          .tr,
                                    ),
                                  ),
                                );
                                return;
                              }
                              parentId = _selectedLevel1!
                                  .categoryId;
                            } else if (_selectedLevel1 ==
                                null) {
                              // 创建 Level 1 分类
                              name = _level1NameController
                                  .text
                                  .trim();
                              if (name.isEmpty) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      EnumLocale
                                          .createCategoryInputLevel1Name
                                          .tr,
                                    ),
                                  ),
                                );
                                return;
                              }
                              parentId = null;
                            } else {
                              // 选择了既有分类，不创建新分类
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    EnumLocale
                                        .createCategorySelectNewToCreate
                                        .tr,
                                  ),
                                ),
                              );
                              return;
                            }

                            Navigator.of(context).pop();
                            widget.onConfirm
                                ?.call(name, parentId);
                          },
                          child: Text(
                            EnumLocale.commonConfirm.tr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
