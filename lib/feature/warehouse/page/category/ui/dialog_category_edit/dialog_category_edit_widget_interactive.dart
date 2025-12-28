part of 'dialog_category_edit_widget_controller.dart';

enum EnumDialogCategoryEditWidgetInteractive {
  tapLevel1Button,
  tapLevel2Button,
  tapDialogCancelButton,
  tapDialogConfirmButton,
  tapDeleteLevel1Button,
  tapDeleteLevel2Button,
}

/// DialogCategoryEditWidget 用户事件处理扩展
extension DialogCategoryEditWidgetUserEventExtension on DialogCategoryEditWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogCategoryEditWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogCategoryEditWidgetInteractive.tapLevel1Button:
        if (data is String) {
          final cat = _getLevel1CategoryByName(data);

          if (cat != null) {
            _model.selectedLevel1.value = cat;
            _model.selectedLevel2.value = null;
            _genHintText();
          }
        }
      case EnumDialogCategoryEditWidgetInteractive.tapLevel2Button:
        if (data is String) {
          final cat = _getLevel2CategoryByName(data);

          if (cat != null) {
            _model.selectedLevel2.value = cat;
            _genHintText();
          }
        }
      case EnumDialogCategoryEditWidgetInteractive.tapDialogCancelButton:
        _routerHandle(EnumDialogCategoryEditWidgetRoute.closeDialog, data);
      case EnumDialogCategoryEditWidgetInteractive.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          _routerHandle(EnumDialogCategoryEditWidgetRoute.closeDialog, data);
        }
      case EnumDialogCategoryEditWidgetInteractive.tapDeleteLevel1Button:
        _model.selectedLevel1.value = null;
        _model.selectedLevel2.value = null;
        _genHintText();
      case EnumDialogCategoryEditWidgetInteractive.tapDeleteLevel2Button:
        _model.selectedLevel2.value = null;
        _genHintText();
    }
  }
}
