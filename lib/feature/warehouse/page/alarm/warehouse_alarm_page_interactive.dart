part of 'warehouse_alarm_page.dart';

enum EnumWarehouseAlarmPageInteractive {
  tapSomeWidget,
}

extension WarehouseAlarmPageUserEventExtension
    on WarehouseAlarmPageController {
  void interactive(EnumWarehouseAlarmPageInteractive type,
      {dynamic data}) {
    switch (type) {
      case EnumWarehouseAlarmPageInteractive.tapSomeWidget:
        break;
    }
  }
}
