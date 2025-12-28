part of 'dialog_cabinet_edit_widget_controller.dart';

enum EnumDialogCabinetEditWidgetInteractive {
  tapRoomButton,
  tapDialogCancelButton,
  tapDialogConfirmButton,
  tapDeleteRoomButton,
}

/// DialogCabinetEditWidget 用户事件处理扩展
extension DialogCabinetEditWidgetUserEventExtension on DialogCabinetEditWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogCabinetEditWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogCabinetEditWidgetInteractive.tapRoomButton:
        if (data is String) {
          final roomId = getRoomIdByName(data);
          if (roomId != null) {
            _model.selectedRoomId.value = roomId;
          }
        }
      case EnumDialogCabinetEditWidgetInteractive.tapDialogCancelButton:
        _routerHandle(EnumDialogCabinetEditWidgetRoute.closeDialog, data);
      case EnumDialogCabinetEditWidgetInteractive.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          _routerHandle(EnumDialogCabinetEditWidgetRoute.closeDialog, data);
        }
      case EnumDialogCabinetEditWidgetInteractive.tapDeleteRoomButton:
        _model.selectedRoomId.value = null;
    }
  }
}
