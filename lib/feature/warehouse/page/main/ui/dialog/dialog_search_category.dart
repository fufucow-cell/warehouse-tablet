import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/temp_router_util.dart';

/// 分类搜索对话框
class DialogSearchCategory {
  /// 显示分类搜索对话框
  static void show({
    String? initialName,
    int? initialLevel,
    Function({
      String? name,
      int? level,
    })? onConfirm,
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
      builder: (context) => _SearchCategoryDialogWidget(
        initialName: initialName,
        initialLevel: initialLevel,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }
}

/// 分类搜索对话框 Widget
class _SearchCategoryDialogWidget extends StatefulWidget {
  final String? initialName;
  final int? initialLevel;
  final Function({
    String? name,
    int? level,
  })? onConfirm;
  final VoidCallback? onCancel;

  const _SearchCategoryDialogWidget({
    this.initialName,
    this.initialLevel,
    this.onConfirm,
    this.onCancel,
  });

  @override
  State<_SearchCategoryDialogWidget> createState() =>
      _SearchCategoryDialogWidgetState();
}

class _SearchCategoryDialogWidgetState
    extends State<_SearchCategoryDialogWidget> {
  final TextEditingController _nameController = TextEditingController();
  int? _selectedLevel;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName ?? '';
    _selectedLevel = widget.initialLevel;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dialogInsetPadding = 30.0.scale > 0 ? 30.0.scale : 30.0;
    return Dialog(
      insetPadding: EdgeInsets.all(dialogInsetPadding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final scale600 = 600.0.scale;
          final scale60 = 60.0.scale;
          final scale40 = 40.0.scale;
          final scale8 = 8.0.scale;
          final dialogMaxWidth = scale600 > 0 ? scale600 : 600.0;
          final insetPaddingValue = scale60 > 0 ? scale60 : 60.0;
          final containerPaddingValue = scale40 > 0 ? scale40 : 40.0;
          final horizontalPaddingValue = scale8 > 0 ? scale8 : 8.0;
          final screenMinusPadding = screenWidth - (insetPaddingValue * 2);
          final dialogWidth = (dialogMaxWidth < screenMinusPadding)
              ? dialogMaxWidth
              : screenMinusPadding;
          final maxHeight = MediaQuery.of(context).size.height * 0.8;
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title 居中
                  Center(
                    child: Text(
                      EnumLocale.searchTitle.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // 名稱輸入框
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: EnumLocale.searchName.tr,
                        hintText: EnumLocale.searchNameHintCategory.tr,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // 階層選擇（按鈕組）
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: Text(
                      EnumLocale.searchLevel.tr,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // 階層1、2、3 按鈕
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 8.0,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  // 如果点击的是已选中的按钮，则取消选择
                                  if (_selectedLevel == 1) {
                                    _selectedLevel = null;
                                  } else {
                                    _selectedLevel = 1;
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _selectedLevel == 1
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.surface,
                                foregroundColor: _selectedLevel == 1
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                              ),
                              child: Text(
                                EnumLocale.searchLevel1.tr,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  // 如果点击的是已选中的按钮，则取消选择
                                  if (_selectedLevel == 2) {
                                    _selectedLevel = null;
                                  } else {
                                    _selectedLevel = 2;
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _selectedLevel == 2
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.surface,
                                foregroundColor: _selectedLevel == 2
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                              ),
                              child: Text(
                                EnumLocale.searchLevel2.tr,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  // 如果点击的是已选中的按钮，则取消选择
                                  if (_selectedLevel == 3) {
                                    _selectedLevel = null;
                                  } else {
                                    _selectedLevel = 3;
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _selectedLevel == 3
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.surface,
                                foregroundColor: _selectedLevel == 3
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                              ),
                              child: Text(
                                EnumLocale.searchLevel3.tr,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                            Navigator.of(context).pop();
                            widget.onConfirm?.call(
                              name: _nameController.text.trim().isEmpty
                                  ? null
                                  : _nameController.text.trim(),
                              level: _selectedLevel,
                            );
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
