part of 'dialog_item_create_widget_controller.dart';

enum EnumDialogItemCreateWidgetRoute {
  openCamera,
  openGallery,
}

extension DialogItemCreateWidgetRouteExtension on DialogItemCreateWidgetController {
  void _routerHandle(
    EnumDialogItemCreateWidgetRoute type,
  ) {
    switch (type) {
      case EnumDialogItemCreateWidgetRoute.openCamera:
        _openCamera();
      case EnumDialogItemCreateWidgetRoute.openGallery:
        _openGallery();
    }
  }
}
