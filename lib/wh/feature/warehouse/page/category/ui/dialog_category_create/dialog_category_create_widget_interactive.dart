part of 'dialog_category_create_widget_controller.dart';

enum EnumDialogCategoryCreateWidgetInteractive {
  tapLevel1Button,
  tapLevel2Button,
  tapDialogCancelButton,
  tapDialogConfirmButton,
  tapClearLevel1Button,
  tapClearLevel2Button,
}

/// DialogCategoryCreateWidget 用户事件处理扩展
extension DialogCategoryCreateWidgetUserEventExtension
    on DialogCategoryCreateWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogCategoryCreateWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogCategoryCreateWidgetInteractive.tapLevel1Button:
        if (data is String) {
          final cat = _getLevel1CategoryByName(data);

          if (cat != null) {
            _model.selectedLevel1.value = cat;
            _model.selectedLevel2.value = null;
            _genHintText();
          }
        }
      case EnumDialogCategoryCreateWidgetInteractive.tapLevel2Button:
        if (data is String) {
          final cat = _getLevel2CategoryByName(data);

          if (cat != null) {
            _model.selectedLevel2.value = cat;
            _genHintText();
          }
        }
      case EnumDialogCategoryCreateWidgetInteractive.tapDialogCancelButton:
        _routerHandle(EnumDialogCategoryCreateWidgetRoute.closeDialog, data);
      case EnumDialogCategoryCreateWidgetInteractive.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          _routerHandle(EnumDialogCategoryCreateWidgetRoute.closeDialog, data);
        }
      case EnumDialogCategoryCreateWidgetInteractive.tapClearLevel1Button:
        _model.selectedLevel1.value = null;
        _model.selectedLevel2.value = null;
        _genHintText();
      case EnumDialogCategoryCreateWidgetInteractive.tapClearLevel2Button:
        _model.selectedLevel2.value = null;
        _genHintText();
    }
  }
}
