part of 'warehouse_item_page.dart';

enum EnumWarehouseItemPageInteractive {
  tapSomeWidget,
  tapFilterExpand,
  tapRoomFilter,
  tapCabinetFilter,
  tapCategoryFilter,
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
        break;
      case EnumWarehouseItemPageInteractive.tapCategoryFilter:
        if (data is int) {
          // 需按照順序執行以下步驟：
          _changeCategoryMultiCheckbox(data);
          _genVisibleItems();
        }
        break;
    }
  }
}
