part of 'dialog_item_info_widget_controller.dart';

enum EnumDialogItemInfoWidgetInteractive {
  tapRecordButton,
}

/// DialogItemInfoWidget 用户事件处理扩展
extension DialogItemInfoWidgetUserEventExtension on DialogItemInfoWidgetController {
  void interactive(
    EnumDialogItemInfoWidgetInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumDialogItemInfoWidgetInteractive.tapRecordButton:
        // TODO: 实现记录按钮点击逻辑
        break;
    }
  }
}
