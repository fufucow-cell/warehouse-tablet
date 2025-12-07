part of 'warehouse_cabinet_page.dart';

enum EnumWarehouseCabinetPageRoute {
  showSomeDialog,
}

extension WarehouseCabinetPageRouteExtension on WarehouseCabinetPageController {
  void routerHandle(EnumWarehouseCabinetPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseCabinetPageRoute.showSomeDialog:
        break;
    }
  }
}
