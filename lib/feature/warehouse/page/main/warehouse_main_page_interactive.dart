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
        if (data is int &&
            isTabControllerReady &&
            !tabController!.indexIsChanging) {
          final newItem = EnumWarehouseTabItem.values[data];
          _model.selectedItem.value = newItem;
        }
      case EnumWarehouseMainPageInteractive.tapSearch:
        // 根据当前选中的 tab 显示对应的搜索对话框
        final selectedItem = _model.selectedItem.value;
        if (selectedItem == EnumWarehouseTabItem.record) {
          routerHandle(
            EnumWarehouseMainPageRoute.showSearchLogDialog,
          );
        } else if (selectedItem ==
            EnumWarehouseTabItem.alarm) {
          routerHandle(
            EnumWarehouseMainPageRoute
                .showSearchAlarmDialog,
          );
        } else if (selectedItem ==
            EnumWarehouseTabItem.category) {
          routerHandle(
            EnumWarehouseMainPageRoute
                .showSearchCategoryDialog,
          );
        } else if (selectedItem ==
            EnumWarehouseTabItem.cabinet) {
          routerHandle(
            EnumWarehouseMainPageRoute
                .showSearchCabinetDialog,
          );
        } else if (selectedItem ==
            EnumWarehouseTabItem.item) {
          routerHandle(
            EnumWarehouseMainPageRoute.showSearchItemDialog,
          );
        }
        // TODO: 其他页面的搜索功能
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
