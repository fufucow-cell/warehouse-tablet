part of 'warehouse_service.dart';

class WarehouseServiceModel {
  String? userId;
  String? userName;
  int? theme;
  String? accessToken;
  String? refreshToken;
  WarehouseHomeModel? house;
  List<WarehouseHomeModel> rooms = [];
  int? userRoleType;
}

class WarehouseHomeModel {
  String? id;
  String? name;

  WarehouseHomeModel({
    required this.id,
    required this.name,
  });
}
