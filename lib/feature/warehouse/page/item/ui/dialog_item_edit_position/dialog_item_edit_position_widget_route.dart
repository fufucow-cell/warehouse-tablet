part of 'dialog_item_edit_position_widget_controller.dart';

enum EnumDialogItemEditPositionWidgetRoute {
  tapDialogCancelButton,
  tapDialogConfirmButton,
}

extension DialogItemEditPositionWidgetRouteExtension
    on DialogItemEditPositionWidgetController {
  void _routerHandle(
    EnumDialogItemEditPositionWidgetRoute type,
    dynamic data,
  ) {
    switch (type) {
      case EnumDialogItemEditPositionWidgetRoute.tapDialogCancelButton:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
      case EnumDialogItemEditPositionWidgetRoute.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          Navigator.of(data).pop();
        }
    }
  }
}
