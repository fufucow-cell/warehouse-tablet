part of 'warehouse_alarm_page_controller.dart';

enum EnumWarehouseAlarmPageRoute {
  showEditDialog,
  showInfoDialog,
}

extension WarehouseAlarmPageRouteExtension on WarehouseAlarmPageController {
  void routerHandle(EnumWarehouseAlarmPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseAlarmPageRoute.showEditDialog:
        if (data is Item) {
          _service.showAlert(
            DialogItemEditQuantityWidget(
              itemId: data.id!,
              onConfirm: (outputModel) async {
                return await _updateItemQuantity(data, outputModel);
              },
            ),
          );
        }
      case EnumWarehouseAlarmPageRoute.showInfoDialog:
        if (data is Item && (data.id?.isNotEmpty ?? false)) {
          _service.showAlert(
            DialogItemInfoWidget(itemId: data.id!),
          );
        }
    }
  }
}
