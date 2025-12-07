part of 'warehouse_item_page.dart';

class WarehouseItemPageModel {
  List<Item>? items;
  List<Item>? allItems; // 保存所有原始物品数据
  final isEditMode = false.obs;
  String? filterName;
  String? filterCategoryId;
  String? filterRoomId;
  String? filterCabinetId;
}
