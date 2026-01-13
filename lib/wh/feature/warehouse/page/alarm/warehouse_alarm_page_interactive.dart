part of 'warehouse_alarm_page_controller.dart';

enum EnumWarehouseAlarmPageInteractive {
  tapEdit,
  tapInfo,
}

extension WarehouseAlarmPageUserEventExtension on WarehouseAlarmPageController {
  void interactive(EnumWarehouseAlarmPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseAlarmPageInteractive.tapEdit:
        if (data is Item) {
          routerHandle(EnumWarehouseAlarmPageRoute.showEditDialog, data: data);
        }
      case EnumWarehouseAlarmPageInteractive.tapInfo:
        if (data is Item) {
          routerHandle(EnumWarehouseAlarmPageRoute.showInfoDialog, data: data);
        }
    }
  }
}
