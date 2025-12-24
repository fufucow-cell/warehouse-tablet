part of 'warehouse_main_page.dart';

enum EnumWarehouseMainPageInteractive {
  selectTabItem,
  tapSearch,
  tapCreate,
}

/// WarehouseMainPage 用户事件处理扩展
extension WarehouseMainPageUserEventExtension on WarehouseMainPageController {
  /// 处理用户事件
  void interactive(
    EnumWarehouseMainPageInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumWarehouseMainPageInteractive.selectTabItem:
        if (data is int && _model.isTabControllerReady.value && !tabController!.indexIsChanging) {
          final newItem = EnumWarehouseTabItem.values[data];
          _model.selectedItem.value = newItem;
        }
      case EnumWarehouseMainPageInteractive.tapSearch:
        routerHandle(EnumWarehouseMainPageRoute.showSearchDialog);
      case EnumWarehouseMainPageInteractive.tapCreate:
        routerHandle(EnumWarehouseMainPageRoute.showCreateItemDialog);
    }
  }
}
