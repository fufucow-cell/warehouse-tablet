part of 'dialog_item_edit_normal_widget_controller.dart';

enum EnumDialogItemEditNormalWidgetInteractive {
  tapPhoto,
  replacePhoto,
  deletePhoto,
  tapCategoryLevel1,
  tapCategoryLevel2,
  tapCategoryLevel3,
  tapDropdownButton,
  tapDialogCancelButton,
  tapDialogConfirmButton,
  tapDialogDeleteButton,
}

/// DialogItemEditNormalWidget 用户事件处理扩展
extension DialogItemEditNormalWidgetUserEventExtension on DialogItemEditNormalWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogItemEditNormalWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogItemEditNormalWidgetInteractive.tapPhoto:
      case EnumDialogItemEditNormalWidgetInteractive.replacePhoto:
        _routerHandle(EnumDialogItemEditNormalWidgetRoute.openGallery);
      case EnumDialogItemEditNormalWidgetInteractive.deletePhoto:
        _model.filePath.value = null;
        _model.photoUrl.value = null;
      case EnumDialogItemEditNormalWidgetInteractive.tapCategoryLevel1:
        if (data is String) {
          _changeSelectedCategoryLevel1(data);
        }
      case EnumDialogItemEditNormalWidgetInteractive.tapCategoryLevel2:
        if (data is String) {
          _changeSelectedCategoryLevel2(data);
        }
      case EnumDialogItemEditNormalWidgetInteractive.tapCategoryLevel3:
        if (data is String) {
          _changeSelectedCategoryLevel3(data);
        }
      case EnumDialogItemEditNormalWidgetInteractive.tapDialogCancelButton:
        _routerHandle(
          EnumDialogItemEditNormalWidgetRoute.closeDialog,
          data: data,
        );
      case EnumDialogItemEditNormalWidgetInteractive.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          _setLoadingStatus(false);
          _routerHandle(
            EnumDialogItemEditNormalWidgetRoute.closeDialog,
            data: data,
          );
        }
      case EnumDialogItemEditNormalWidgetInteractive.tapDialogDeleteButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          _setLoadingStatus(false);
          _routerHandle(
            EnumDialogItemEditNormalWidgetRoute.closeDialog,
            data: data,
          );
        }
      default:
        break;
    }
  }
}
