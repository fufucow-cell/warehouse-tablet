part of 'dialog_item_info_widget_controller.dart';

enum EnumDialogItemInfoWidgetRoute {
  showDialogItemHistory,
}

extension DialogItemInfoWidgetRouteExtension on DialogItemInfoWidgetController {
  void routerHandle(EnumDialogItemInfoWidgetRoute type, {dynamic data}) {
    switch (type) {
      case EnumDialogItemInfoWidgetRoute.showDialogItemHistory:
        if (data is BuildContext) {
          Navigator.of(data).pop();
          _service
              .showAlert(DialogItemHistoryWidget(item: _model.combineItem!));
        }
    }
  }
}
