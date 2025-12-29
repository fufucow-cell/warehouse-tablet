part of 'dialog_cabinet_edit_widget_controller.dart';

enum EnumDialogCabinetEditWidgetInteractive {
  tapDialogCancelButton,
  tapDialogConfirmButton,
  tapRoomButton,
  tapDeleteButton,
  tapExpandButton,
}

/// DialogCabinetEditWidget 用户事件处理扩展
extension DialogCabinetEditWidgetUserEventExtension
    on DialogCabinetEditWidgetController {
  /// 处理用户事件
  Future<void> interactive(
    EnumDialogCabinetEditWidgetInteractive type, {
    dynamic data,
  }) async {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogCabinetEditWidgetInteractive.tapRoomButton:
        if (data is ChangeRoomModel) {
          _updateEditModels(data);
        }
      case EnumDialogCabinetEditWidgetInteractive.tapDialogCancelButton:
        unawaited(_routerHandle(EnumDialogCabinetEditWidgetRoute.closeDialog,
            data: data));
      case EnumDialogCabinetEditWidgetInteractive.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          unawaited(_routerHandle(EnumDialogCabinetEditWidgetRoute.closeDialog,
              data: data));
        }
      case EnumDialogCabinetEditWidgetInteractive.tapDeleteButton:
        if (data is EditModel) {
          data.isDelete = !data.isDelete;
          _updateEditModels(
              ChangeRoomModel(editModel: data, newRoomName: null));
        }
      case EnumDialogCabinetEditWidgetInteractive.tapExpandButton:
        if (data is EditModel) {
          data.isExpanded = !data.isExpanded;
          _updateEditModels(
              ChangeRoomModel(editModel: data, newRoomName: null));
        }
    }
  }
}
