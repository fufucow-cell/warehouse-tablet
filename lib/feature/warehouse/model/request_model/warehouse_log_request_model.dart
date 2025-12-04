import 'package:json_annotation/json_annotation.dart';

part 'warehouse_log_request_model.g.dart';

@JsonSerializable()
class WarehouseLogRequestModel {
  @JsonKey(name: 'log_id')
  String? logId;
  @JsonKey(name: 'home_id')
  int? homeId;
  @JsonKey(name: 'user_name')
  String? userName;
  @JsonKey(name: 'created_at')
  int? createdAt;
  @JsonKey(name: 'operate_type')
  int? operateType;
  @JsonKey(name: 'item_type')
  int? itemType;
  @JsonKey(name: 'log_type')
  int? logType;

  WarehouseLogRequestModel({
    this.logId,
    this.homeId,
    this.userName,
    this.createdAt,
    this.operateType,
    this.itemType,
    this.logType,
  });

  factory WarehouseLogRequestModel.fromJson(Map<String, dynamic> json) {
    return _$WarehouseLogRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WarehouseLogRequestModelToJson(this);
}
