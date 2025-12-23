part of 'warehouse_item_page.dart';

enum EnumWarehouseItemPageRoute {
  showInfoDialog,
}

extension WarehouseItemPageRouteExtension on WarehouseItemPageController {
  void routerHandle(EnumWarehouseItemPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseItemPageRoute.showInfoDialog:
        if (data is Item) {
          _service.show(
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
