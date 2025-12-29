part of 'dialog_item_edit_position_widget_controller.dart';

enum EnumDialogItemEditPositionWidgetInteractive {
  tapUpdateRoom,
  tapUpdateCabinet,
  tapDropdownButton,
  tapIncrementQuantity,
  tapDecrementQuantity,
  tapDialogCancelButton,
  tapDialogConfirmButton,
}

/// DialogItemEditPositionWidget 用户事件处理扩展
extension DialogItemEditPositionWidgetUserEventExtension
    on DialogItemEditPositionWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogItemEditPositionWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogItemEditPositionWidgetInteractive.tapUpdateRoom:
        if (data is UpdatePositionModel) {
          updatePositionRoom(data);
        }
      case EnumDialogItemEditPositionWidgetInteractive.tapUpdateCabinet:
        if (data is UpdatePositionModel) {
          updatePositionCabinet(data);
        }
      case EnumDialogItemEditPositionWidgetInteractive.tapDialogCancelButton:
        _routerHandle(
            EnumDialogItemEditPositionWidgetRoute.tapDialogCancelButton, data);
      case EnumDialogItemEditPositionWidgetInteractive.tapDialogConfirmButton:
        _routerHandle(
            EnumDialogItemEditPositionWidgetRoute.tapDialogConfirmButton, data);
      case EnumDialogItemEditPositionWidgetInteractive.tapIncrementQuantity:
        if (data is TextEditingController) {
          final currentValue = int.tryParse(data.text.trim()) ?? 0;
          data.text = (currentValue + 1).toString();
        }
      case EnumDialogItemEditPositionWidgetInteractive.tapDecrementQuantity:
        if (data is TextEditingController) {
          final currentValue = int.tryParse(data.text.trim()) ?? 0;

          if (currentValue > 0) {
            data.text = (currentValue - 1).toString();
          }
        }
      default:
        break;
    }
  }
}
