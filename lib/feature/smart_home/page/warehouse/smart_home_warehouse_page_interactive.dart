part of 'smart_home_warehouse_page.dart';

enum EnumSmartHomeWarehousePageInteractive {
  tapSomeWidget,
}

extension SmartHomeWarehousePageUserEventExtension
    on SmartHomeWarehousePageController {
  void interactive(EnumSmartHomeWarehousePageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeWarehousePageInteractive.tapSomeWidget:
        break;
    }
  }
}
