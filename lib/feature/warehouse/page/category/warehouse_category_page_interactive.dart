part of 'warehouse_category_page.dart';

enum EnumWarehouseCategoryPageInteractive {
  tapSomeWidget,
}

extension WarehouseCategoryPageUserEventExtension
    on WarehouseCategoryPageController {
  void interactive(EnumWarehouseCategoryPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseCategoryPageInteractive.tapSomeWidget:
        break;
    }
  }
}
