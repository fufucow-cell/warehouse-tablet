part of 'smart_home_warehouse_page.dart';

enum EnumSmartHomeWarehousePageRoute {
  showSomeDialog,
}

extension SmartHomeWarehousePageRouteExtension
    on SmartHomeWarehousePageController {
  void routerHandle(EnumSmartHomeWarehousePageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeWarehousePageRoute.showSomeDialog:
        break;
    }
  }
}
