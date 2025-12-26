part of 'dialog_item_edit_position_widget_controller.dart';

enum EnumDialogItemEditPositionWidgetRoute {
  tapDialogFooterButton,
}

extension DialogItemEditPositionWidgetRouteExtension on DialogItemEditPositionWidgetController {
  void _routerHandle(
    EnumDialogItemEditPositionWidgetRoute type,
    dynamic data,
  ) {
    switch (type) {
      case EnumDialogItemEditPositionWidgetRoute.tapDialogFooterButton:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
    }
  }
}
