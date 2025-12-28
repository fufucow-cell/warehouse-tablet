part of 'dialog_category_edit_widget_controller.dart';

enum EnumDialogCategoryEditWidgetRoute {
  closeDialog,
}

extension DialogCategoryEditWidgetRouteExtension on DialogCategoryEditWidgetController {
  void _routerHandle(
    EnumDialogCategoryEditWidgetRoute type,
    dynamic data,
  ) {
    switch (type) {
      case EnumDialogCategoryEditWidgetRoute.closeDialog:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
    }
  }
}
