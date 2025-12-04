import 'package:flutter_smart_home_tablet/feature/warehouse/model/response_model/warehouse_category_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'warehouse_item_response_model.g.dart';

@JsonSerializable()
class WarehouseItemResponseModel {
  String? id;
  @JsonKey(name: 'cabinet_id')
  String? cabinetId;
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
  WarehouseCategoryResponseModel? category;

  WarehouseItemResponseModel({
    this.id,
    this.cabinetId,
    this.roomId,
    this.homeId,
    this.name,
    this.description,
    this.quantity,
    this.minStockAlert,
    this.photo,
    this.category,
  });

  factory WarehouseItemResponseModel.fromJson(Map<String, dynamic> json) {
    return _$WarehouseItemResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WarehouseItemResponseModelToJson(this);
}
