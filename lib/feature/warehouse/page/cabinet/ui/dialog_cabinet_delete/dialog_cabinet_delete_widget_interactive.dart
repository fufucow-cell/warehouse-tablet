part of 'dialog_cabinet_delete_widget_controller.dart';

enum EnumDialogCabinetDeleteWidgetInteractive {
  tapDialogCancelButton,
  tapDialogConfirmButton,
}

/// DialogCabinetDeleteWidget 用户事件处理扩展
extension DialogCabinetDeleteWidgetUserEventExtension on DialogCabinetDeleteWidgetController {
  /// 处理用户事件
  void interactive(
    EnumDialogCabinetDeleteWidgetInteractive type, {
    dynamic data,
  }) {
    _service.dismissKeyboard();

    switch (type) {
      case EnumDialogCabinetDeleteWidgetInteractive.tapDialogCancelButton:
        _routerHandle(EnumDialogCabinetDeleteWidgetRoute.closeDialog, data);
      case EnumDialogCabinetDeleteWidgetInteractive.tapDialogConfirmButton:
        if (data is bool) {
          _setLoadingStatus(data);
        } else if (data is BuildContext) {
          _routerHandle(EnumDialogCabinetDeleteWidgetRoute.closeDialog, data);
        }
    }
  }
}
