part of 'dialog_item_edit_quantity_widget_controller.dart';

enum EnumDialogItemEditQuantityWidgetRoute {
  tapDialogCancelButton,
  tapDialogConfirmButton,
}

extension DialogItemEditQuantityWidgetRouteExtension on DialogItemEditQuantityWidgetController {
  void _routerHandle(
    EnumDialogItemEditQuantityWidgetRoute type,
    dynamic data,
  ) {
    switch (type) {
      case EnumDialogItemEditQuantityWidgetRoute.tapDialogCancelButton:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
      case EnumDialogItemEditQuantityWidgetRoute.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          Navigator.of(data).pop();
        }
    }
  }
}
