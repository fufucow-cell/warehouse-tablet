part of 'dialog_item_edit_position_widget_controller.dart';

enum EnumDialogItemEditPositionWidgetRoute {
  closeDialog,
  showErrorSnackBar,
}

extension DialogItemEditPositionWidgetRouteExtension
    on DialogItemEditPositionWidgetController {
  void _routerHandle(
    EnumDialogItemEditPositionWidgetRoute type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumDialogItemEditPositionWidgetRoute.closeDialog:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
      case EnumDialogItemEditPositionWidgetRoute.showErrorSnackBar:
        if (data is String) {
          _service.showSnackBar(
            title: EnumLocale.commonError.tr,
            message: data,
          );
        }
    }
  }
}
