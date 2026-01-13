part of 'dialog_category_create_widget_controller.dart';

enum EnumDialogCategoryCreateWidgetRoute {
  closeDialog,
}

extension DialogCategoryCreateWidgetRouteExtension
    on DialogCategoryCreateWidgetController {
  void _routerHandle(
    EnumDialogCategoryCreateWidgetRoute type,
    dynamic data,
  ) {
    switch (type) {
      case EnumDialogCategoryCreateWidgetRoute.closeDialog:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
    }
  }
}
