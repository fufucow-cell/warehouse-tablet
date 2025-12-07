import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_log_request_model.freezed.dart';
part 'warehouse_log_request_model.g.dart';

@freezed
class WarehouseLogRequestModel with _$WarehouseLogRequestModel {
  factory WarehouseLogRequestModel({
    @JsonKey(name: 'log_id') String? logId,
    @JsonKey(name: 'home_id') String? homeId,
    @JsonKey(name: 'after_time') int? afterTime,
    @JsonKey(name: 'operate_type') int? operateType,
    @JsonKey(name: 'item_type') int? itemType,
    @JsonKey(name: 'log_type') int? logType,
  }) = _WarehouseLogRequestModel;

  factory WarehouseLogRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseLogRequestModelFromJson(json);
}
