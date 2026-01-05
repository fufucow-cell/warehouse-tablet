part of 'dialog_item_edit_quantity_widget_controller.dart';

enum EnumDialogItemEditQuantityWidgetRoute {
  closeDialog,
  showDuplicateCabinetNameSnackBar,
}

extension DialogItemEditQuantityWidgetRouteExtension on DialogItemEditQuantityWidgetController {
  void routerHandle(
    EnumDialogItemEditQuantityWidgetRoute type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumDialogItemEditQuantityWidgetRoute.closeDialog:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
        break;
      case EnumDialogItemEditQuantityWidgetRoute.showDuplicateCabinetNameSnackBar:
        if (data is String) {
          _service.showSnackBar(
            title: EnumLocale.commonError.tr,
            message: EnumLocale.warehouseDuplicateCabinetName.trArgs([data]),
          );
        }
    }
  }
}
