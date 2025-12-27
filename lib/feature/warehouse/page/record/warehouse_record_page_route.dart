part of 'warehouse_record_page_controller.dart';

enum EnumWarehouseRecordPageRoute {
  showSomeDialog,
}

extension WarehouseRecordPageRouteExtension on WarehouseRecordPageController {
  void routerHandle(EnumWarehouseRecordPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseRecordPageRoute.showSomeDialog:
        break;
    }
  }
}
