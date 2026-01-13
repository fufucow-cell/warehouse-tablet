part of 'dialog_cabinet_create_widget_controller.dart';

enum EnumDialogCabinetCreateWidgetRoute {
  closeDialog,
}

extension DialogCabinetCreateWidgetRouteExtension
    on DialogCabinetCreateWidgetController {
  void _routerHandle(
    EnumDialogCabinetCreateWidgetRoute type,
    dynamic data,
  ) {
    switch (type) {
      case EnumDialogCabinetCreateWidgetRoute.closeDialog:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
    }
  }
}
