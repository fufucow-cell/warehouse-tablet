import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/util/router_util.dart';

/// 全屏遮罩对话框
///
/// 显示一个全屏半透明遮罩，中间显示对话框内容
class CustDialog {
  final String title;
  final String description;
  final String confirmText;
  final VoidCallback? onConfirm;
  final String? cancelText;
  final VoidCallback? onCancel;
  final bool barrierDismissible;
  final Widget? icon;

  const CustDialog({
    this.title = 'title',
    this.description = 'description',
    this.confirmText = 'confirm',
    this.onConfirm,
    this.cancelText = 'cancel',
    this.onCancel,
    this.barrierDismissible = false,
    this.icon,
  });

  /// 信息类型对话框（固定只显示确认按钮）
  factory CustDialog.info({
    String title = '提示',
    String description = '',
    String confirmText = '確認',
    VoidCallback? onConfirm,
    bool barrierDismissible = false,
  }) {
    return CustDialog(
      title: title,
      description: description,
      confirmText: confirmText,
      onConfirm: onConfirm,
      cancelText: null, // info 类型不显示取消按钮
      onCancel: null,
      barrierDismissible: barrierDismissible,
      icon: Icon(
        Icons.info_outline,
        size: 48.0.scale,
        color: Colors.blue,
      ),
    );
  }

  /// 错误类型对话框（固定只显示确认按钮）
  factory CustDialog.error({
    String title = '錯誤',
    String description = '',
    String confirmText = '確認',
    VoidCallback? onConfirm,
    bool barrierDismissible = false,
  }) {
    return CustDialog(
      title: title,
      description: description,
      confirmText: confirmText,
      onConfirm: onConfirm,
      cancelText: null, // error 类型不显示取消按钮
      onCancel: null,
      barrierDismissible: barrierDismissible,
      icon: Icon(
        Icons.error_outline,
        size: 48.0.scale,
        color: Colors.red,
      ),
    );
  }

  /// 选项类型对话框（显示确认和取消按钮）
  factory CustDialog.option({
    String title = '提示',
    String description = '',
    String confirmText = '確認',
    VoidCallback? onConfirm,
    String cancelText = '取消',
    VoidCallback? onCancel,
    bool barrierDismissible = false,
  }) {
    return CustDialog(
      title: title,
      description: description,
      confirmText: confirmText,
      onConfirm: onConfirm,
      cancelText: cancelText,
      onCancel: onCancel,
      barrierDismissible: barrierDismissible,
      icon: Icon(
        Icons.help_outline,
        size: 48.0.scale,
        color: Colors.orange,
      ),
    );
  }

  /// 显示对话框
  void show() {
    final context = RouterUtil.instance.rootContext;
    if (context == null) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _CustDialogWidget(
        title: title,
        description: description,
        confirmText: confirmText,
        icon: icon,
        onConfirm: () {
          Navigator.of(context).pop();
          onConfirm?.call(); // 如果提供了自定义回调，执行它
        },
        cancelText: cancelText,
        onCancel: () {
          Navigator.of(context).pop();
          onCancel?.call(); // 如果提供了自定义回调，执行它
        },
      ),
    );
  }

  /// 关闭对话框
  static void close() {
    final context = RouterUtil.instance.rootContext;
    if (context != null && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}

/// 实际的对话框 UI Widget
class _CustDialogWidget extends StatelessWidget {
  final String title;
  final String description;
  final String confirmText;
  final VoidCallback onConfirm;
  final String? cancelText;
  final VoidCallback? onCancel;
  final Widget? icon;

  const _CustDialogWidget({
    required this.title,
    required this.description,
    required this.confirmText,
    required this.onConfirm,
    this.cancelText,
    this.onCancel,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: 32.0.scale),
          padding: EdgeInsets.all(24.0.scale),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                SizedBox(height: 16.0.scale),
              ],
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 16.0.scale),
              Text(
                description,
                style:
                    Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0.scale),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (cancelText != null)
                      OutlinedButton(
                        onPressed: onCancel,
                        child: Text(cancelText!),
                      ),
                    if (cancelText != null)
                      SizedBox(width: 12.0.scale),
                    ElevatedButton(
                      onPressed: onConfirm,
                      child: Text(confirmText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
