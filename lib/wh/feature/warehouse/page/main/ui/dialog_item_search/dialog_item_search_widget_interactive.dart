part of 'dialog_item_search_widget_controller.dart';

enum EnumDialogItemSearchWidgetInteractive {
  tapCategoryLevel1,
  tapCategoryLevel2,
  tapCategoryLevel3,
  tapDropdownButton,
  tapDialogFooterButton,
}

/// DialogItemSearchWidget 用户事件处理扩展
extension DialogItemSearchWidgetUserEventExtension
    on DialogItemSearchWidgetController {
  void interactive(
    EnumDialogItemSearchWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogItemSearchWidgetInteractive.tapCategoryLevel1:
        if (data is Category) {
          _changeSelectedCategoryLevel1(data);
        } else if (data is String) {
          final category = _model.visibleCategoryLevel1.value
              .firstWhereOrNull((cat) => cat.name == data);
          _changeSelectedCategoryLevel1(category);
        } else {
          _changeSelectedCategoryLevel1(null);
        }
      case EnumDialogItemSearchWidgetInteractive.tapCategoryLevel2:
        if (data is Category) {
          _changeSelectedCategoryLevel2(data);
        } else if (data is String) {
          final category = _model.visibleCategoryLevel2.value
              .firstWhereOrNull((cat) => cat.name == data);
          _changeSelectedCategoryLevel2(category);
        } else {
          _changeSelectedCategoryLevel2(null);
        }
      case EnumDialogItemSearchWidgetInteractive.tapCategoryLevel3:
        if (data is Category) {
          _changeSelectedCategoryLevel3(data);
        } else if (data is String) {
          final category = _model.visibleCategoryLevel3.value
              .firstWhereOrNull((cat) => cat.name == data);
          _changeSelectedCategoryLevel3(category);
        } else {
          _changeSelectedCategoryLevel3(null);
        }
      case EnumDialogItemSearchWidgetInteractive.tapDialogFooterButton:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
      default:
        break;
    }
  }
}
