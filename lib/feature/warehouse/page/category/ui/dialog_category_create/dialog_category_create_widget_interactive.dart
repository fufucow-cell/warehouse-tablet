part of 'dialog_category_create_widget_controller.dart';

enum EnumDialogCategoryCreateWidgetInteractive {
  tapParentCategory,
  tapDropdownButton,
  tapDialogCancelButton,
  tapDialogConfirmButton,
}

/// DialogCategoryCreateWidget 用户事件处理扩展
extension DialogCategoryCreateWidgetUserEventExtension on DialogCategoryCreateWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogCategoryCreateWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogCategoryCreateWidgetInteractive.tapParentCategory:
        if (data is String) {
          _changeSelectedParentCategory(data);
        }
      case EnumDialogCategoryCreateWidgetInteractive.tapDialogCancelButton:
        _routerHandle(EnumDialogCategoryCreateWidgetRoute.tapDialogFooterButton, data);
      case EnumDialogCategoryCreateWidgetInteractive.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          _setLoadingStatus(false);
          _routerHandle(EnumDialogCategoryCreateWidgetRoute.tapDialogFooterButton, data);
        }
      default:
        break;
    }
  }
}
