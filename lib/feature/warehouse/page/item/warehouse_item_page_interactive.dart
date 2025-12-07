part of 'warehouse_item_page.dart';

enum EnumWarehouseItemPageInteractive {
  tapSomeWidget,
}

extension WarehouseItemPageUserEventExtension on WarehouseItemPageController {
  void interactive(EnumWarehouseItemPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseItemPageInteractive.tapSomeWidget:
        break;
    }
  }
}
