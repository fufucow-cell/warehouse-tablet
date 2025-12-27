part of 'warehouse_cabinet_page_controller.dart';

enum EnumWarehouseCabinetPageInteractive {
  tapSomeWidget,
  tapCreateCabinet,
}

extension WarehouseCabinetPageUserEventExtension
    on WarehouseCabinetPageController {
  void interactive(EnumWarehouseCabinetPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseCabinetPageInteractive.tapSomeWidget:
        break;
      case EnumWarehouseCabinetPageInteractive.tapCreateCabinet:
        routerHandle(EnumWarehouseCabinetPageRoute.showCreateCabinetDialog);
        break;
    }
  }
}
