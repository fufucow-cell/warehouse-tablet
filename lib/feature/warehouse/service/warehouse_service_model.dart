part of 'warehouse_service.dart';

class WarehouseServiceModel {
  String? userId;
  String? userName;
  String? accessToken;
  String? refreshToken;
  WarehouseNameIdModel? household;
  List<WarehouseNameIdModel> rooms = [];
  int? userRoleType;
  BuildContext? rootContext;
  // 搜尋條件
  final searchCondition = Rxn<DialogItemSearchOutputModel>();
  // 房間
  final allRoomCabinetItems = Rxn<List<Room>>();
  // 分類
  final allCategories = Rxn<List<Category>>();
  // 物品
  Map<String, List<Item>>? allGroupItems; // 不同櫥櫃的相同物品分組
  List<Item>? allCombineItems; // 合併分散在不同櫥櫃的相同物品
  final allLowStockItems = Rxn<List<Item>>(); // 所有低庫存物品
  // 記錄
  List<ItemRecord>? allRecords;
  // Main Page Tab Item Index
  final mainPageSelectedTabItem = EnumWarehouseTabItem.item.obs;
}

class WarehouseNameIdModel {
  String? id;
  String? name;

  WarehouseNameIdModel({
    required this.id,
    required this.name,
  });
}
