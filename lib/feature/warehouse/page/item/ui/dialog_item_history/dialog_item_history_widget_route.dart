part of 'dialog_item_history_widget_controller.dart';

enum EnumDialogItemHistoryWidgetRoute {
  tapDialogConfirmButton,
}

extension DialogItemHistoryWidgetRouteExtension
    on DialogItemHistoryWidgetController {
  void _routerHandle(EnumDialogItemHistoryWidgetRoute type, dynamic data) {
    switch (type) {
      case EnumDialogItemHistoryWidgetRoute.tapDialogConfirmButton:
        if (data is BuildContext) {
          Navigator.of(data).pop();
          _service
              .showAlert(DialogItemInfoWidget(itemId: _model.combineItem!.id!));
        }
    }
  }
}
