part of 'dialog_item_create_widget_controller.dart';

enum EnumDialogItemCreateWidgetInteractive {
  incrementQuantity,
  decrementQuantity,
  tapSmartAddButton,
  tapPhoto,
  replacePhoto,
  deletePhoto,
  tapCategoryLevel1,
  tapCategoryLevel2,
  tapCategoryLevel3,
  tapRoom,
  tapCabinet,
  tapDropdownButton,
  tapDialogCancelButton,
  tapDialogConfirmButton,
}

/// DialogItemCreateWidget 用户事件处理扩展
extension DialogItemCreateWidgetUserEventExtension on DialogItemCreateWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogItemCreateWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogItemCreateWidgetInteractive.incrementQuantity:
        final currentValue = int.tryParse(quantityController.text.trim()) ?? 0;
        _model.quantity.value = currentValue + 1;
        quantityController.text = _model.quantity.value.toString();
      case EnumDialogItemCreateWidgetInteractive.decrementQuantity:
        final currentValue = int.tryParse(quantityController.text.trim()) ?? 0;
        if (currentValue > 0) {
          _model.quantity.value = currentValue - 1;
          quantityController.text = _model.quantity.value.toString();
        }
      case EnumDialogItemCreateWidgetInteractive.tapSmartAddButton:
        _routerHandle(EnumDialogItemCreateWidgetRoute.openCamera);
      case EnumDialogItemCreateWidgetInteractive.tapPhoto:
      case EnumDialogItemCreateWidgetInteractive.replacePhoto:
        _routerHandle(EnumDialogItemCreateWidgetRoute.openGallery);
      case EnumDialogItemCreateWidgetInteractive.deletePhoto:
        _model.filePath.value = null;
      case EnumDialogItemCreateWidgetInteractive.tapRoom:
        if (data is String) {
          _changeSelectedRoom(data);
        }
      case EnumDialogItemCreateWidgetInteractive.tapCabinet:
        if (data is String) {
          _changeSelectedCabinet(data);
        }
      case EnumDialogItemCreateWidgetInteractive.tapCategoryLevel1:
        if (data is String) {
          _changeSelectedCategoryLevel1(data);
        }
      case EnumDialogItemCreateWidgetInteractive.tapCategoryLevel2:
        if (data is String) {
          _changeSelectedCategoryLevel2(data);
        }
      case EnumDialogItemCreateWidgetInteractive.tapCategoryLevel3:
        if (data is String) {
          _changeSelectedCategoryLevel3(data);
        }
      case EnumDialogItemCreateWidgetInteractive.tapDialogCancelButton:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
      case EnumDialogItemCreateWidgetInteractive.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          _setLoadingStatus(false);
          Navigator.of(data).pop();
        }
      default:
        break;
    }
  }
}
