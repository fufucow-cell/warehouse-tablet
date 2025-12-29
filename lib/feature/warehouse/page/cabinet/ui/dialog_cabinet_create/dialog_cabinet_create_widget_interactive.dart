part of 'dialog_cabinet_create_widget_controller.dart';

enum EnumDialogCabinetCreateWidgetInteractive {
  tapRoomButton,
  tapDialogCancelButton,
  tapDialogConfirmButton,
}

/// DialogCabinetCreateWidget 用户事件处理扩展
extension DialogCabinetCreateWidgetUserEventExtension
    on DialogCabinetCreateWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogCabinetCreateWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogCabinetCreateWidgetInteractive.tapRoomButton:
        if (data is String) {
          final room = getRoomByName(data);

          if (room != null) {
            _model.selectedRoom.value = room;
          }
        }
      case EnumDialogCabinetCreateWidgetInteractive.tapDialogCancelButton:
        _routerHandle(EnumDialogCabinetCreateWidgetRoute.closeDialog, data);
      case EnumDialogCabinetCreateWidgetInteractive.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          _routerHandle(EnumDialogCabinetCreateWidgetRoute.closeDialog, data);
        }
    }
  }
}
