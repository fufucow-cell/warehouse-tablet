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
  // 房間
  final allRoomCabinetItems = Rxn<List<Room>>();
  // 分類
  final allCategories = Rxn<List<Category>>();
  // 物品
  final allLowStockItems = Rxn<List<Item>>();
  List<Item>? allItems;
  Map<String, List<Item>>? allGroupItems;
  // 記錄
  List<ItemRecord>? allRecords;
}

class WarehouseNameIdModel {
  String? id;
  String? name;

  WarehouseNameIdModel({
    required this.id,
    required this.name,
  });
}
