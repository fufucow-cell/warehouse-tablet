part of 'warehouse_cabinet_page_controller.dart';

enum EnumWarehouseCabinetPageInteractive {
  tapCabinet,
  tapCreateCabinet,
  tapEditCabinet,
}

extension WarehouseCabinetPageUserEventExtension
    on WarehouseCabinetPageController {
  void interactive(EnumWarehouseCabinetPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseCabinetPageInteractive.tapCreateCabinet:
        routerHandle(EnumWarehouseCabinetPageRoute.showCreateCabinetDialog);
        break;
      case EnumWarehouseCabinetPageInteractive.tapEditCabinet:
        routerHandle(
          EnumWarehouseCabinetPageRoute.showEditCabinetDialog,
          data: data,
        );
      case EnumWarehouseCabinetPageInteractive.tapCabinet:
        routerHandle(
          EnumWarehouseCabinetPageRoute.changeMainPageTabItem,
          data: data,
        );
    }
  }
}
