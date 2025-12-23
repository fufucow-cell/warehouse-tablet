part of 'warehouse_service.dart';

class WarehouseServiceModel {
  String? userId;
  String? userName;
  String? accessToken;
  String? refreshToken;
  WarehouseNameIdModel? house;
  List<WarehouseNameIdModel> rooms = [];
  int? userRoleType;
  final allRoomCabinetItems = Rxn<List<Room>>();
  final allLowStockItems = Rxn<List<Item>>();
  List<Item>? allItems;
  Map<String, List<Item>>? allGroupItems;
  List<ItemRecord>? allRecords;
  List<Category>? allCategories;
  BuildContext? rootContext;
}

class WarehouseNameIdModel {
  String? id;
  String? name;

  WarehouseNameIdModel({
    required this.id,
    required this.name,
  });
}
