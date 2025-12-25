part of 'dialog_item_normal_edit_widget_controller.dart';

enum EnumDialogItemNormalEditWidgetRoute {
  openCamera,
  openGallery,
}

extension DialogItemNormalEditWidgetRouteExtension on DialogItemNormalEditWidgetController {
  void _routerHandle(
    EnumDialogItemNormalEditWidgetRoute type,
  ) {
    switch (type) {
      case EnumDialogItemNormalEditWidgetRoute.openCamera:
        _openCamera();
      case EnumDialogItemNormalEditWidgetRoute.openGallery:
        _openGallery();
    }
  }
}
