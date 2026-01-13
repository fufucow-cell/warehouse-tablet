import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_record_read_request_model.freezed.dart';
part 'warehouse_record_read_request_model.g.dart';

@freezed
class WarehouseRecordReadRequestModel with _$WarehouseRecordReadRequestModel {
  factory WarehouseRecordReadRequestModel({
    @JsonKey(name: 'log_id') String? logId,
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'item_id') String? itemId,
    @JsonKey(name: 'after_time') int? afterTime,
    @JsonKey(name: 'operate_type') int? operateType,
    @JsonKey(name: 'item_type') int? itemType,
    @JsonKey(name: 'log_type') int? logType,
  }) = _WarehouseRecordReadRequestModel;

  factory WarehouseRecordReadRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseRecordReadRequestModelFromJson(json);
}
