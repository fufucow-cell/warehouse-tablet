import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/util/root_router_util.dart';

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
    final context = RootRouterUtil.instance.rootContext;
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
                  hintText: '請輸入分類名稱',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24.0.scale),
              // 階層選擇（按鈕組）
              Text(
                '階層',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8.0.scale),
              // 階層1、2、3 按鈕
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0.scale),
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
                          padding: EdgeInsets.symmetric(vertical: 12.0.scale),
                        ),
                        child: const Text('階層1'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.scale),
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
                          padding: EdgeInsets.symmetric(vertical: 12.0.scale),
                        ),
                        child: const Text('階層2'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0.scale),
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
                          padding: EdgeInsets.symmetric(vertical: 12.0.scale),
                        ),
                        child: const Text('階層3'),
                      ),
                    ),
                  ),
                ],
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
                        level: _selectedLevel,
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
    );
  }
}
