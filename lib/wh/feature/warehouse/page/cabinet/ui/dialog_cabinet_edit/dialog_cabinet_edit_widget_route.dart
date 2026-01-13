part of 'dialog_cabinet_edit_widget_controller.dart';

enum EnumDialogCabinetEditWidgetRoute {
  closeDialog,
  showDialogDeleteHint,
}

extension DialogCabinetEditWidgetRouteExtension
    on DialogCabinetEditWidgetController {
  Future<T?> _routerHandle<T>(
    EnumDialogCabinetEditWidgetRoute type, {
    dynamic data,
  }) async {
    switch (type) {
      case EnumDialogCabinetEditWidgetRoute.closeDialog:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
        return null;
      case EnumDialogCabinetEditWidgetRoute.showDialogDeleteHint:
        if (data is String) {
          final result = await _service.showAlert<bool>(
            DialogMessageWidget(
              title: EnumLocale.commonReminder.tr,
              message: data,
              onConfirm: () => true,
              onCancel: () => false,
            ),
          );
          return result as T?;
        }
        return null;
    }
  }
}
