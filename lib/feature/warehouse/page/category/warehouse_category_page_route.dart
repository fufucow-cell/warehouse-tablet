part of 'warehouse_category_page.dart';

enum EnumWarehouseCategoryPageRoute {
  showSomeDialog,
}

extension WarehouseCategoryPageRouteExtension
    on WarehouseCategoryPageController {
  void routerHandle(EnumWarehouseCategoryPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseCategoryPageRoute.showSomeDialog:
        break;
    }
  }
}
