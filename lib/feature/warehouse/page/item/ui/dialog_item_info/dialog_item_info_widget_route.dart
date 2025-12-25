part of 'dialog_item_info_widget_controller.dart';

enum EnumDialogItemInfoWidgetRoute {
  switchMainPageTabItemIndex,
}

extension DialogItemInfoWidgetRouteExtension on DialogItemInfoWidgetController {
  void routerHandle(EnumDialogItemInfoWidgetRoute type, {dynamic data}) {
    switch (type) {
      case EnumDialogItemInfoWidgetRoute.switchMainPageTabItemIndex:
        if (data is BuildContext) {
          _service.changeMainPageSelectedTabItem(EnumWarehouseTabItem.record);
          Navigator.of(data).pop();
        }
    }
  }
}
