part of 'warehouse_item_page.dart';

enum EnumWarehouseItemPageInteractive {
  tapSomeWidget,
  tapFilterExpand,
  tapRoomFilter,
  tapCabinetFilter,
  tapCategoryFilter,
  tapEditButton,
  tapChangeButton,
  tapInfoButton,
  tapRecordButton,
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
      case EnumWarehouseItemPageInteractive.tapEditButton:
        if (data is Item) {
          routerHandle(EnumWarehouseItemPageRoute.showEditDialog, data: data);
        }
        break;
      case EnumWarehouseItemPageInteractive.tapChangeButton:
        if (data is Item) {
          routerHandle(EnumWarehouseItemPageRoute.showChangeDialog, data: data);
        }
        break;
      case EnumWarehouseItemPageInteractive.tapInfoButton:
        if (data is Item) {
          routerHandle(EnumWarehouseItemPageRoute.showInfoDialog, data: data);
        }
        break;
      case EnumWarehouseItemPageInteractive.tapRecordButton:
        if (data is Item) {
          routerHandle(EnumWarehouseItemPageRoute.showRecordDialog, data: data);
        }
        break;
    }
  }
}
