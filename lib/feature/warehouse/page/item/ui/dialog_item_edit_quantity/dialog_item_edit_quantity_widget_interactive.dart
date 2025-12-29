part of 'dialog_item_edit_quantity_widget_controller.dart';

enum EnumDialogItemEditQuantityWidgetInteractive {
  tapAddNewPostion,
  tapDropdownButton,
  tapUpdateNewPositionRoom,
  tapUpdateNewPositionCabinet,
  tapDecrementQuantity,
  tapIncrementQuantity,
  tapDialogCancelButton,
  tapDialogConfirmButton,
}

/// DialogItemEditQuantityWidget 用户事件处理扩展
extension DialogItemEditQuantityWidgetUserEventExtension
    on DialogItemEditQuantityWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogItemEditQuantityWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogItemEditQuantityWidgetInteractive.tapAddNewPostion:
        genNewPosition();
      case EnumDialogItemEditQuantityWidgetInteractive.tapUpdateNewPositionRoom:
        if (data is UpdatePositionModel) {
          updateNewPositionRoom(data);
        }
      case EnumDialogItemEditQuantityWidgetInteractive
            .tapUpdateNewPositionCabinet:
        if (data is UpdatePositionModel) {
          updateNewPositionCabinet(data);
        }
      case EnumDialogItemEditQuantityWidgetInteractive.tapDialogCancelButton:
        _routerHandle(
            EnumDialogItemEditQuantityWidgetRoute.tapDialogCancelButton, data);
      case EnumDialogItemEditQuantityWidgetInteractive.tapDialogConfirmButton:
        _routerHandle(
            EnumDialogItemEditQuantityWidgetRoute.tapDialogConfirmButton, data);
      case EnumDialogItemEditQuantityWidgetInteractive.tapDecrementQuantity:
        if (data is TextEditingController) {
          final currentValue = int.tryParse(data.text.trim()) ?? 0;
          if (currentValue > 0) {
            data.text = (currentValue - 1).toString();
          }
        }
      case EnumDialogItemEditQuantityWidgetInteractive.tapIncrementQuantity:
        if (data is TextEditingController) {
          final currentValue = int.tryParse(data.text.trim()) ?? 0;
          data.text = (currentValue + 1).toString();
        }
      default:
        break;
    }
  }
}
