part of 'warehouse_main_page.dart';

enum EnumWarehouseMainPageInteractive {
  selectTabItem,
  tapSearch,
  tapCreate,
  tapEdit,
}

/// WarehouseMainPage 用户事件处理扩展
extension WarehouseMainPageUserEventExtension
    on WarehouseMainPageController {
  /// 处理用户事件
  void interactive(
    EnumWarehouseMainPageInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumWarehouseMainPageInteractive.selectTabItem:
        if (data is int && !tabController.indexIsChanging) {
          final newItem = EnumWarehouseTabItem.values[data];
          _model.selectedItem.value = newItem;
        }
      case EnumWarehouseMainPageInteractive.tapSearch:
        // TODO: 实现搜索功能
        break;
      case EnumWarehouseMainPageInteractive.tapCreate:
        // TODO: 实现新增功能
        break;
      case EnumWarehouseMainPageInteractive.tapEdit:
        // TODO: 实现编辑功能
        break;
    }
  }
}
