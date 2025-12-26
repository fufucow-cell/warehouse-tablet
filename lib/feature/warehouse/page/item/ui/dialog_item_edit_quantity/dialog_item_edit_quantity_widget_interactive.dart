part of 'dialog_item_edit_quantity_widget_controller.dart';

enum EnumDialogItemEditQuantityWidgetInteractive {
  tapAddLocation,
  tapRemoveNewLocation,
  tapUpdateNewLocationRoom,
  tapUpdateNewLocationCabinet,
  tapUpdateNewLocationQuantity,
  tapDialogCancelButton,
  tapDialogConfirmButton,
}

/// DialogItemEditQuantityWidget 用户事件处理扩展
extension DialogItemEditQuantityWidgetUserEventExtension on DialogItemEditQuantityWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogItemEditQuantityWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogItemEditQuantityWidgetInteractive.tapAddLocation:
        addNewLocation();
      case EnumDialogItemEditQuantityWidgetInteractive.tapRemoveNewLocation:
        if (data is int) {
          removeNewLocation(data);
        }
      case EnumDialogItemEditQuantityWidgetInteractive.tapUpdateNewLocationRoom:
        if (data is Map && data['index'] is int && data['room'] is String?) {
          updateNewLocationRoom(data['index'] as int, data['room'] as String?);
        }
      case EnumDialogItemEditQuantityWidgetInteractive.tapUpdateNewLocationCabinet:
        if (data is Map && data['index'] is int && data['cabinet'] is String?) {
          updateNewLocationCabinet(data['index'] as int, data['cabinet'] as String?);
        }
      case EnumDialogItemEditQuantityWidgetInteractive.tapUpdateNewLocationQuantity:
        if (data is Map && data['index'] is int && data['quantity'] is int) {
          updateNewLocationQuantity(data['index'] as int, data['quantity'] as int);
        }
      case EnumDialogItemEditQuantityWidgetInteractive.tapDialogCancelButton:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
      case EnumDialogItemEditQuantityWidgetInteractive.tapDialogConfirmButton:
        // TODO: 实现确认逻辑
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
      default:
        break;
    }
  }
}
