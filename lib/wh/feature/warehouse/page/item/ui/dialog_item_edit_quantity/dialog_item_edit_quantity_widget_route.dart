part of 'dialog_item_edit_quantity_widget_controller.dart';

enum EnumDialogItemEditQuantityWidgetRoute {
  closeDialog,
  showSnackBar,
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
      case EnumDialogItemEditQuantityWidgetRoute.showSnackBar:
        if (data is String) {
          _service.showSnackBar(
            title: EnumLocale.commonError.tr,
            message: data,
          );
        }
    }
  }
}
