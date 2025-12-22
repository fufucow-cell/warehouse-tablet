import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_log_request_model.freezed.dart';
part 'warehouse_log_request_model.g.dart';

@freezed
class WarehouseRecordRequestModel with _$WarehouseRecordRequestModel {
  factory WarehouseRecordRequestModel({
    @JsonKey(name: 'log_id') String? logId,
    @JsonKey(name: 'household_id') String? homeId,
    @JsonKey(name: 'after_time') int? afterTime,
    @JsonKey(name: 'operate_type') int? operateType,
    @JsonKey(name: 'item_type') int? itemType,
    @JsonKey(name: 'log_type') int? logType,
  }) = _WarehouseRecordRequestModel;

  factory WarehouseRecordRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseRecordRequestModelFromJson(json);
}
