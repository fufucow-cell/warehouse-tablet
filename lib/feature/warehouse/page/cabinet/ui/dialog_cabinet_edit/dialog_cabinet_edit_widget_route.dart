part of 'dialog_cabinet_edit_widget_controller.dart';

enum EnumDialogCabinetEditWidgetRoute {
  closeDialog,
}

extension DialogCabinetEditWidgetRouteExtension on DialogCabinetEditWidgetController {
  void _routerHandle(
    EnumDialogCabinetEditWidgetRoute type,
    dynamic data,
  ) {
    switch (type) {
      case EnumDialogCabinetEditWidgetRoute.closeDialog:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
    }
  }
}
