import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_delete_request_model/delete_cabinet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_cabinet_delete_request_model.freezed.dart';
part 'warehouse_cabinet_delete_request_model.g.dart';

@freezed
class WarehouseCabinetDeleteRequestModel with _$WarehouseCabinetDeleteRequestModel {
  factory WarehouseCabinetDeleteRequestModel({
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'user_name') String? userName,
    List<DeleteCabinet>? cabinets,
  }) = _WarehouseCabinetDeleteRequestModel;

  factory WarehouseCabinetDeleteRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseCabinetDeleteRequestModelFromJson(json);
}
