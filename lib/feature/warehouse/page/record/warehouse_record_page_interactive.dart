part of 'warehouse_record_page.dart';

enum EnumWarehouseRecordPageInteractive {
  tapSomeWidget,
}

extension WarehouseRecordPageUserEventExtension
    on WarehouseRecordPageController {
  void interactive(EnumWarehouseRecordPageInteractive type,
      {dynamic data}) {
    switch (type) {
      case EnumWarehouseRecordPageInteractive.tapSomeWidget:
        break;
    }
  }
}
