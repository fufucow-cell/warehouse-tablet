part of 'warehouse_item_page.dart';

class WarehouseItemPageModel {
  final allRoomCabinetItems = Rxn<List<Room>>();
  final allItemsForCategory = <Item>[];
  final visibleItems = Rx<List<Item>>([]);
  final filterRuleForRooms = <WarehouseNameIdModel>[];
  final filterRuleForCabinets = Rx<List<WarehouseNameIdModel>>([]);
  final filterRuleForCategories = Rx<List<WarehouseNameIdModel>>([]);
  final filterIndexForRooms = 0.obs;
  final filterIndexForCabinets = 0.obs;
  final filterIndexForCategories = Rx<Set<int>>({});
  final isFilterExpanded = false.obs;
}
