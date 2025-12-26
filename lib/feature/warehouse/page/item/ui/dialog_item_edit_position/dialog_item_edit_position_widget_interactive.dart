part of 'dialog_item_edit_position_widget_controller.dart';

enum EnumDialogItemEditPositionWidgetInteractive {
  tapDialogCancelButton,
  tapDialogConfirmButton,
}

/// DialogItemEditPositionWidget 用户事件处理扩展
extension DialogItemEditPositionWidgetUserEventExtension on DialogItemEditPositionWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogItemEditPositionWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogItemEditPositionWidgetInteractive.tapDialogCancelButton:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
      case EnumDialogItemEditPositionWidgetInteractive.tapDialogConfirmButton:
        // TODO: 实现确认逻辑
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
      default:
        break;
    }
  }
}
