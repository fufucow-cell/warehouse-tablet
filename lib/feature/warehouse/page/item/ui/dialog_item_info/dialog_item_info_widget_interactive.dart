part of 'dialog_item_info_widget_controller.dart';

enum EnumDialogItemInfoWidgetInteractive {
  tapRecordButton,
}

/// DialogItemInfoWidget 用户事件处理扩展
extension DialogItemInfoWidgetUserEventExtension
    on DialogItemInfoWidgetController {
  void interactive(
    EnumDialogItemInfoWidgetInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumDialogItemInfoWidgetInteractive.tapRecordButton:
        routerHandle(
          EnumDialogItemInfoWidgetRoute.showDialogItemHistory,
          data: data,
        );
    }
  }
}
