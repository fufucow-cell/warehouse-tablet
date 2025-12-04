part of 'warehouse_main_page.dart';

enum EnumWarehouseMainPageRoute {
  showSomeDialog,
}

extension WarehouseMainPageRouteExtension on WarehouseMainPageController {
  void routerHandle(EnumWarehouseMainPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseMainPageRoute.showSomeDialog:
        break;
    }
  }
}
