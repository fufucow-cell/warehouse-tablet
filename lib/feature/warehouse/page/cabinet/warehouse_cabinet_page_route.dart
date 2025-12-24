part of 'warehouse_cabinet_page.dart';

enum EnumWarehouseCabinetPageRoute {
  showSomeDialog,
  showCreateCabinetDialog,
}

extension WarehouseCabinetPageRouteExtension on WarehouseCabinetPageController {
  void routerHandle(EnumWarehouseCabinetPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseCabinetPageRoute.showSomeDialog:
        break;
      case EnumWarehouseCabinetPageRoute.showCreateCabinetDialog:
        _showCreateCabinetDialog();
        break;
    }
  }

  Future<void> _showCreateCabinetDialog() async {
    try {
      final service = WarehouseService.instance;
      service.showAlert(const DialogCabinetCreate());
    } on Exception catch (e) {
      // 错误处理
      final context = Get.context;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(EnumLocale.warehouseErrorFetchData.trArgs([e.toString()])),
          ),
        );
      }
    }
  }
}
