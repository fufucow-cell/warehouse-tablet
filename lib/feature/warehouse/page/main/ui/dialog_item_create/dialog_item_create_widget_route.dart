part of 'dialog_item_create_widget_controller.dart';

enum EnumDialogItemCreateWidgetRoute {
  openCamera,
  openGallery,
  tapDialogFooterButton,
}

extension DialogItemCreateWidgetRouteExtension
    on DialogItemCreateWidgetController {
  void _routerHandle(
    EnumDialogItemCreateWidgetRoute type,
    dynamic data,
  ) {
    switch (type) {
      case EnumDialogItemCreateWidgetRoute.openCamera:
        _openCamera();
      case EnumDialogItemCreateWidgetRoute.openGallery:
        _openGallery();
      case EnumDialogItemCreateWidgetRoute.tapDialogFooterButton:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
    }
  }
}
