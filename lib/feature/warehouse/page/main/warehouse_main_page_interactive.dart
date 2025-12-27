part of 'warehouse_main_page_controller.dart';

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
        if (data is int && _model.isTabControllerReady.value && tabController != null && !tabController!.indexIsChanging) {
          final newItem = EnumWarehouseTabItem.values[data];
          _service.changeMainPageSelectedTabItem(newItem);
        }
      case EnumWarehouseMainPageInteractive.tapSearch:
        routerHandle(EnumWarehouseMainPageRoute.showSearchDialog);
      case EnumWarehouseMainPageInteractive.tapCreate:
        routerHandle(EnumWarehouseMainPageRoute.showCreateItemDialog);
    }
  }
}
