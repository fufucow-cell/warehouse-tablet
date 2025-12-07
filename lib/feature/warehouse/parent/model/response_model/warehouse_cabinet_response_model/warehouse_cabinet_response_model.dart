import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_cabinet_response_model/cabinet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_cabinet_response_model.freezed.dart';
part 'warehouse_cabinet_response_model.g.dart';

@freezed
class WarehouseCabinetResponseModel with _$WarehouseCabinetResponseModel {
  factory WarehouseCabinetResponseModel({
    int? code,
    String? message,
    List<Cabinet>? data,
  }) = _WarehouseCabinetResponseModel;

  factory WarehouseCabinetResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WarehouseCabinetResponseModelFromJson(json);
}
