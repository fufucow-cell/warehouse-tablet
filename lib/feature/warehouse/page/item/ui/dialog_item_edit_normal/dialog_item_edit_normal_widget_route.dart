part of 'dialog_item_edit_normal_widget_controller.dart';

enum EnumDialogItemEditNormalWidgetRoute {
  closeDialog,
  openCamera,
  openGallery,
  showDialogDeleteHint,
}

extension DialogItemEditNormalWidgetRouteExtension on DialogItemEditNormalWidgetController {
  Future<T?> _routerHandle<T>(
    EnumDialogItemEditNormalWidgetRoute type, {
    dynamic data,
  }) async {
    switch (type) {
      case EnumDialogItemEditNormalWidgetRoute.closeDialog:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
      case EnumDialogItemEditNormalWidgetRoute.openCamera:
        await _openCamera();
      case EnumDialogItemEditNormalWidgetRoute.openGallery:
        await _openGallery();
      case EnumDialogItemEditNormalWidgetRoute.showDialogDeleteHint:
        return await _service.showAlert<bool>(
          DialogMessageWidget(
            title: EnumLocale.commonReminder.tr,
            message: EnumLocale.deleteItemMessage.tr,
            onConfirm: () => true,
            onCancel: () => false,
          ),
        ) as T?;
    }

    return null;
  }
}
