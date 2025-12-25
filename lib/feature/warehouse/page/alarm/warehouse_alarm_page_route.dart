part of 'warehouse_alarm_page.dart';

enum EnumWarehouseAlarmPageRoute {
  showEditDialog,
  showInfoDialog,
}

extension WarehouseAlarmPageRouteExtension on WarehouseAlarmPageController {
  void routerHandle(EnumWarehouseAlarmPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseAlarmPageRoute.showEditDialog:
        if (data is Item) {}
        break;
      case EnumWarehouseAlarmPageRoute.showInfoDialog:
        if (data is Item && (data.id?.isNotEmpty ?? false)) {
          _service.showAlert(
            DialogItemInfoWidget(data.id!),
          );
        }
    }
  }
}
