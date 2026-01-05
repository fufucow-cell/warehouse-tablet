part of 'warehouse_service.dart';

class WarehouseServiceModel {
  String? userId;
  String? userName;
  String? accessToken;
  String? refreshToken;
  WarehouseNameIdModel? household;
  List<WarehouseNameIdModel> rooms = [];
  List<RoomCabinetInfo> roomCabinetInfos = [];
  int? userRoleType;
  BuildContext? rootContext;
  // 搜尋條件
  DialogItemSearchOutputModel? searchCondition;
  String? searchCabinetId;
  // 房間櫃位物品
  final allRoomCabinetItems = Rxn<List<Room>>();
  // 房間櫃位
  final allRoomCabinets = Rxn<List<Room>>();
  // 分類
  final allCategories = Rxn<List<Category>>();
  // 物品
  // Map<String, List<Item>>? allGroupItems; // 不同櫥櫃的相同物品分組
  List<Item>? allCombineItems; // 合併分散在不同櫥櫃的相同物品
  // final allLowStockItems = Rxn<List<Item>>(); // 所有低庫存物品
  // 記錄
  final allRecords = Rxn<List<ItemRecord>?>();
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

class ItemPositionModel {
  final String roomId;
  final String roomName;
  final List<ItemPositionCabinetModel> cabinets;

  ItemPositionModel({
    required this.roomId,
    required this.roomName,
    required this.cabinets,
  });
}

class ItemPositionCabinetModel {
  final String id;
  final String name;
  final int quantity;

  ItemPositionCabinetModel({
    required this.id,
    required this.name,
    required this.quantity,
  });
}

class RoomCabinetInfo {
  final String roomId;
  final String roomName;
  final int quantity;
  final List<CabinetInfo> cabinets;

  RoomCabinetInfo({
    required this.roomId,
    required this.roomName,
    required this.quantity,
    required this.cabinets,
  });
}

class CabinetInfo {
  final String cabinetId;
  final String cabinetName;
  final int quantity;

  CabinetInfo({
    required this.cabinetId,
    required this.cabinetName,
    required this.quantity,
  });
}
