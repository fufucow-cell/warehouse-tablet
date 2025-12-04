part of 'warehouse_main_page.dart';

enum EnumWarehouseMainPageInteractive {
  selectTabItem,
}

/// WarehouseMainPage 用户事件处理扩展
extension WarehouseMainPageUserEventExtension
    on WarehouseMainPageController {
  /// 处理用户事件
  void interactive(EnumWarehouseMainPageInteractive type,
      {dynamic data}) {
    switch (type) {
      case EnumWarehouseMainPageInteractive.selectTabItem:
        if (data is EnumWarehouseTabItem) {
          _model.selectedItem.value = data;
        }
        break;
    }
  }
}
