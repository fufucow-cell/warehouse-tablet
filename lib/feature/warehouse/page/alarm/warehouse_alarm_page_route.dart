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
        if (data is Item) {
          _service.showAlert(
            DialogItemInfo(
              DialogItemInfoModel(
                title: data.name,
                description: data.description,
                lowStockAlert: data.minStockAlert,
                category: _service.convertCategoriesName(data),
                rooms: _service.filterItemFromRooms(data),
              ),
            ),
          );
        }
    }
  }
}
