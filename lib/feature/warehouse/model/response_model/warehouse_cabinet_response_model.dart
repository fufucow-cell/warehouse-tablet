import 'package:json_annotation/json_annotation.dart';

part 'warehouse_cabinet_response_model.g.dart';

@JsonSerializable()
class WarehouseCabinetResponseModel {
  String? id;
  @JsonKey(name: 'home_id')
  int? homeId;
  @JsonKey(name: 'room_id')
  int? roomId;
  String? name;
  String? description;

  WarehouseCabinetResponseModel({
    this.id,
    this.homeId,
    this.roomId,
    this.name,
    this.description,
  });

  factory WarehouseCabinetResponseModel.fromJson(Map<String, dynamic> json) {
    return _$WarehouseCabinetResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WarehouseCabinetResponseModelToJson(this);
}
