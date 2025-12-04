import 'package:json_annotation/json_annotation.dart';

part 'warehouse_cabinet_request_model.g.dart';

@JsonSerializable()
class WarehouseCabinetRequestModel {
  @JsonKey(name: 'cabinet_id')
  String? cabinetId;
  @JsonKey(name: 'home_id')
  int? homeId;
  @JsonKey(name: 'room_id')
  int? roomId;
  String? name;
  String? description;
  @JsonKey(name: 'user_name')
  String? userName;

  WarehouseCabinetRequestModel({
    this.cabinetId,
    this.homeId,
    this.roomId,
    this.name,
    this.description,
    this.userName,
  });

  factory WarehouseCabinetRequestModel.fromJson(Map<String, dynamic> json) {
    return _$WarehouseCabinetRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WarehouseCabinetRequestModelToJson(this);
}
