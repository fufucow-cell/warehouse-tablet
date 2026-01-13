part of 'dialog_category_delete_widget_controller.dart';

enum EnumDialogCategoryDeleteWidgetInteractive {
  tapDialogCancelButton,
  tapDialogConfirmButton,
}

/// DialogCategoryDeleteWidget 用户事件处理扩展
extension DialogCategoryDeleteWidgetUserEventExtension
    on DialogCategoryDeleteWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogCategoryDeleteWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogCategoryDeleteWidgetInteractive.tapDialogCancelButton:
        _routerHandle(EnumDialogCategoryDeleteWidgetRoute.closeDialog, data);
      case EnumDialogCategoryDeleteWidgetInteractive.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          _routerHandle(EnumDialogCategoryDeleteWidgetRoute.closeDialog, data);
        }
    }
  }
}
