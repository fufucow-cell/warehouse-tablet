import 'package:json_annotation/json_annotation.dart';

part 'warehouse_item_request_model.g.dart';

@JsonSerializable()
class WarehouseItemRequestModel {
  @JsonKey(name: 'item_id')
  String? itemId;
  @JsonKey(name: 'cabinet_id')
  String? cabinetId;
  @JsonKey(name: 'category_id')
  String? categoryId;
  @JsonKey(name: 'room_id')
  int? roomId;
  @JsonKey(name: 'home_id')
  int? homeId;
  String? name;
  String? description;
  int? quantity;
  @JsonKey(name: 'min_stock_alert')
  int? minStockAlert;
  String? photo;
  @JsonKey(name: 'user_name')
  String? userName;

  WarehouseItemRequestModel({
    this.itemId,
    this.cabinetId,
    this.categoryId,
    this.roomId,
    this.homeId,
    this.name,
    this.description,
    this.quantity,
    this.minStockAlert,
    this.photo,
    this.userName,
  });

  factory WarehouseItemRequestModel.fromJson(Map<String, dynamic> json) {
    return _$WarehouseItemRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WarehouseItemRequestModelToJson(this);
}
