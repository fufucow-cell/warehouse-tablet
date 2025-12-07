part of 'warehouse_item_page.dart';

enum EnumWarehouseItemPageRoute {
  showSomeDialog,
}

extension WarehouseItemPageRouteExtension on WarehouseItemPageController {
  void routerHandle(EnumWarehouseItemPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseItemPageRoute.showSomeDialog:
        break;
    }
  }
}
