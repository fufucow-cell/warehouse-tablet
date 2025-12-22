import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_record.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_record_response_model.freezed.dart';
part 'warehouse_record_response_model.g.dart';

@freezed
class WarehouseRecordResponseModel with _$WarehouseRecordResponseModel {
  factory WarehouseRecordResponseModel({
    int? code,
    String? message,
    List<ItemRecord>? data,
  }) = _WarehouseRecordResponseModel;

  factory WarehouseRecordResponseModel.fromJson(Map<String, dynamic> json) => _$WarehouseRecordResponseModelFromJson(json);
}
