import 'package:json_annotation/json_annotation.dart';

part 'warehouse_category_response_model.g.dart';

@JsonSerializable()
class WarehouseCategoryResponseModel {
  String? id;
  @JsonKey(name: 'home_id')
  int? homeId;
  String? name;
  @JsonKey(name: 'parent_id')
  String? parentId;
  int? level;
  WarehouseCategoryResponseModel? children;

  WarehouseCategoryResponseModel({
    this.id,
    this.homeId,
    this.name,
    this.parentId,
    this.level,
    this.children,
  });

  factory WarehouseCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return _$WarehouseCategoryResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WarehouseCategoryResponseModelToJson(this);
}
