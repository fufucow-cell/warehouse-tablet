import 'package:json_annotation/json_annotation.dart';

part 'warehouse_log_response_model.g.dart';

@JsonSerializable()
class WarehouseLogResponseModel {
  @JsonKey(name: 'log_id')
  String? logId;
  @JsonKey(name: 'home_id')
  int? homeId;
  @JsonKey(name: 'created_at')
  int? createdAt;
  @JsonKey(name: 'operate_type')
  int? operateType;
  @JsonKey(name: 'item_type')
  int? itemType;
  @JsonKey(name: 'modify_type')
  List<int>? modifyType;
  @JsonKey(name: 'user_name')
  String? userName;
  @JsonKey(name: 'log_type')
  int? logType;

  WarehouseLogResponseModel({
    this.logId,
    this.homeId,
    this.createdAt,
    this.operateType,
    this.itemType,
    this.modifyType,
    this.userName,
    this.logType,
  });

  factory WarehouseLogResponseModel.fromJson(Map<String, dynamic> json) {
    return _$WarehouseLogResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WarehouseLogResponseModelToJson(this);
}
