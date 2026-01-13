part of 'warehouse_item_page_controller.dart';

enum EnumWarehouseItemPageInteractive {
  tapSomeWidget,
  tapFilterExpand,
  tapRoomFilter,
  tapCabinetFilter,
  tapCategoryFilter,
  tapClearSearch,
  tapItemNormalEdit,
  tapItemQuantityEdit,
  tapItemPositionEdit,
  tapItemInfo,
}

extension WarehouseItemPageUserEventExtension on WarehouseItemPageController {
  void interactive(EnumWarehouseItemPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseItemPageInteractive.tapSomeWidget:
        break;
      case EnumWarehouseItemPageInteractive.tapFilterExpand:
        _model.isFilterExpanded.value = !_model.isFilterExpanded.value;
      case EnumWarehouseItemPageInteractive.tapRoomFilter:
        if (data is int) {
          // 需按照順序執行以下步驟：
          _model.filterIndexForRooms.value = data;
          _model.filterIndexForCabinets.value = 0;
          _genFilterRuleForCabinet();
          _genAllFilterRuleAndItemForCategory();
        }
        break;
      case EnumWarehouseItemPageInteractive.tapCabinetFilter:
        if (data is int) {
          // 需按照順序執行以下步驟：
          _model.filterIndexForCabinets.value = data;
          _genAllFilterRuleAndItemForCategory();
        }
      case EnumWarehouseItemPageInteractive.tapCategoryFilter:
        if (data is int) {
          // 需按照順序執行以下步驟：
          _changeCategoryMultiCheckbox(data);
          _genVisibleItems();
        }
      case EnumWarehouseItemPageInteractive.tapItemNormalEdit:
        if (data is Item) {
          routerHandle(
            EnumWarehouseItemPageRoute.showDialogItemNormalEdit,
            data: data,
          );
        }
        break;
      case EnumWarehouseItemPageInteractive.tapItemQuantityEdit:
        if (data is Item) {
          routerHandle(
            EnumWarehouseItemPageRoute.showDialogItemQuantityEdit,
            data: data,
          );
        }
        break;
      case EnumWarehouseItemPageInteractive.tapItemPositionEdit:
        if (data is Item) {
          routerHandle(
            EnumWarehouseItemPageRoute.showDialogItemPositionEdit,
            data: data,
          );
        }
        break;
      case EnumWarehouseItemPageInteractive.tapItemInfo:
        if (data is Item) {
          routerHandle(
            EnumWarehouseItemPageRoute.showDialogItemInfo,
            data: data,
          );
        }
        break;
      case EnumWarehouseItemPageInteractive.tapClearSearch:
        _service.clearSearchCondition();
        _initData();
    }
  }
}
