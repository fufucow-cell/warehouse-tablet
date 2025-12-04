import 'package:json_annotation/json_annotation.dart';

part 'warehouse_category_request_model.g.dart';

@JsonSerializable()
class WarehouseCategoryRequestModel {
  @JsonKey(name: 'category_id')
  String? categoryId;
  @JsonKey(name: 'parent_id')
  String? parentId;
  @JsonKey(name: 'home_id')
  int? homeId;
  String? name;
  int? level;
  @JsonKey(name: 'user_name')
  String? userName;

  WarehouseCategoryRequestModel({
    this.categoryId,
    this.parentId,
    this.homeId,
    this.name,
    this.level,
    this.userName,
  });

  factory WarehouseCategoryRequestModel.fromJson(Map<String, dynamic> json) {
    return _$WarehouseCategoryRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WarehouseCategoryRequestModelToJson(this);
}
