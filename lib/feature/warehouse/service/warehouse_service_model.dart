part of 'warehouse_service.dart';

class WarehouseServiceModel {
  String? userId;
  String? userName;
  String? accessToken;
  String? refreshToken;
  WarehouseNameIdModel? house;
  List<WarehouseNameIdModel> rooms = [];
  int? userRoleType;
  List<Room>? allRoomCabinetItems;
  List<Log>? allLogs;
}

class WarehouseNameIdModel {
  String? id;
  String? name;

  WarehouseNameIdModel({
    required this.id,
    required this.name,
  });
}
