part of 'dialog_item_normal_edit_widget_controller.dart';

enum EnumDialogItemNormalEditWidgetInteractive {
  tapPhoto,
  replacePhoto,
  deletePhoto,
  tapCategoryLevel1,
  tapCategoryLevel2,
  tapCategoryLevel3,
  tapDropdownButton,
  tapDialogCancelButton,
  tapDialogConfirmButton,
}

/// DialogItemNormalEditWidget 用户事件处理扩展
extension DialogItemNormalEditWidgetUserEventExtension on DialogItemNormalEditWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogItemNormalEditWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogItemNormalEditWidgetInteractive.tapPhoto:
      case EnumDialogItemNormalEditWidgetInteractive.replacePhoto:
        _routerHandle(EnumDialogItemNormalEditWidgetRoute.openGallery);
      case EnumDialogItemNormalEditWidgetInteractive.deletePhoto:
        _model.filePath.value = null;
        _model.photoUrl.value = null;
      case EnumDialogItemNormalEditWidgetInteractive.tapCategoryLevel1:
        if (data is String) {
          _changeSelectedCategoryLevel1(data);
        }
      case EnumDialogItemNormalEditWidgetInteractive.tapCategoryLevel2:
        if (data is String) {
          _changeSelectedCategoryLevel2(data);
        }
      case EnumDialogItemNormalEditWidgetInteractive.tapCategoryLevel3:
        if (data is String) {
          _changeSelectedCategoryLevel3(data);
        }
      case EnumDialogItemNormalEditWidgetInteractive.tapDialogCancelButton:
        if (data is BuildContext) {
          Navigator.of(data).pop();
        }
      case EnumDialogItemNormalEditWidgetInteractive.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          _setLoadingStatus(false);
          Navigator.of(data).pop();
        }
      default:
        break;
    }
  }
}
