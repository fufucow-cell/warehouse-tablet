part of 'dialog_item_history_widget_controller.dart';

enum EnumDialogItemHistoryWidgetInteractive {
  tapDialogConfirmButton,
}

extension DialogItemHistoryWidgetUserEventExtension on DialogItemHistoryWidgetController {
  void interactive(
    EnumDialogItemHistoryWidgetInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumDialogItemHistoryWidgetInteractive.tapDialogConfirmButton:
        _routerHandle(
          EnumDialogItemHistoryWidgetRoute.showDialogInfo,
          data,
        );
    }
  }
}
