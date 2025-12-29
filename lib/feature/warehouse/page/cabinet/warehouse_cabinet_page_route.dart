part of 'warehouse_cabinet_page_controller.dart';

enum EnumWarehouseCabinetPageRoute {
  showCreateCabinetDialog,
  showEditCabinetDialog,
  changeMainPageTabItem,
}

extension WarehouseCabinetPageRouteExtension on WarehouseCabinetPageController {
  void routerHandle(EnumWarehouseCabinetPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseCabinetPageRoute.showCreateCabinetDialog:
        _service.showAlert(
          DialogCabinetCreateWidget(
            onConfirm: (outputModel) async {
              return await _createCabinet(outputModel);
            },
          ),
        );
      case EnumWarehouseCabinetPageRoute.showEditCabinetDialog:
        if (data is WarehouseNameIdModel) {
          _service.showAlert(
            DialogCabinetEditWidget(
              room: data,
              onConfirm: (outputModel) async {
                return await _updateCabinet(outputModel);
              },
            ),
          );
        }
      case EnumWarehouseCabinetPageRoute.changeMainPageTabItem:
        if (data is Cabinet) {
          _service.changeMainPageSelectedTabItem(EnumWarehouseTabItem.item, data: data.id);
        }
    }
  }
}
