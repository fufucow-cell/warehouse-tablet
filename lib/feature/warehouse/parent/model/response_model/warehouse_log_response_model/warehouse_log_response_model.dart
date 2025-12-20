import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_log_response_model/log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_log_response_model.freezed.dart';
part 'warehouse_log_response_model.g.dart';

@freezed
class WarehouseLogResponseModel with _$WarehouseLogResponseModel {
  factory WarehouseLogResponseModel({
    int? code,
    String? message,
    List<Log>? data,
  }) = _WarehouseLogResponseModel;

  factory WarehouseLogResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseLogResponseModelFromJson(json);
}
