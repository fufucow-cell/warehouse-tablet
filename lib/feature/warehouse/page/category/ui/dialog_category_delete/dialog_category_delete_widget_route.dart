part of 'dialog_category_delete_widget_controller.dart';

enum EnumDialogCategoryDeleteWidgetRoute {
  closeDialog,
}

extension DialogCategoryDeleteWidgetRouteExtension
    on DialogCategoryDeleteWidgetController {
  void _routerHandle(
    EnumDialogCategoryDeleteWidgetRoute type,
    dynamic data,
  ) {
    switch (type) {
      case EnumDialogCategoryDeleteWidgetRoute.closeDialog:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
    }
  }
}
