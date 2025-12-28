part of 'dialog_cabinet_delete_widget_controller.dart';

enum EnumDialogCabinetDeleteWidgetRoute {
  closeDialog,
}

extension DialogCabinetDeleteWidgetRouteExtension on DialogCabinetDeleteWidgetController {
  void _routerHandle(
    EnumDialogCabinetDeleteWidgetRoute type,
    dynamic data,
  ) {
    switch (type) {
      case EnumDialogCabinetDeleteWidgetRoute.closeDialog:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
    }
  }
}
