part of 'warehouse_cabinet_page_controller.dart';

enum EnumWarehouseCabinetPageRoute {
  showCreateCabinetDialog,
  showEditCabinetDialog,
  showDeleteCabinetDialog,
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
        if (data is Cabinet) {
          final cabinetId = data.id ?? '';
          _service.showAlert(
            DialogCabinetEditWidget(
              cabinet: data,
              onConfirm: (outputModel) async {
                return await _updateCabinet(outputModel, cabinetId);
              },
            ),
          );
        }
      case EnumWarehouseCabinetPageRoute.showDeleteCabinetDialog:
        if (data is Cabinet) {
          _service.showAlert(
            DialogCabinetDeleteWidget(
              cabinet: data,
              onConfirm: (outputModel) async {
                return await _deleteCabinet(outputModel);
              },
            ),
          );
        }
    }
  }
}
