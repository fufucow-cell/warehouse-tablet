part of 'warehouse_alarm_page.dart';

enum EnumWarehouseAlarmPageRoute {
  showSomeDialog,
}

extension WarehouseAlarmPageRouteExtension on WarehouseAlarmPageController {
  void routerHandle(EnumWarehouseAlarmPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseAlarmPageRoute.showSomeDialog:
        break;
    }
  }
}