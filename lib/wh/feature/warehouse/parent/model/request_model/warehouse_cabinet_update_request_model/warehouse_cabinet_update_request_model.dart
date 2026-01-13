import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/warehouse_cabinet_update_request_model/update_cabinet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_cabinet_update_request_model.freezed.dart';
part 'warehouse_cabinet_update_request_model.g.dart';

@freezed
class WarehouseCabinetUpdateRequestModel with _$WarehouseCabinetUpdateRequestModel {
  factory WarehouseCabinetUpdateRequestModel({
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'user_name') String? userName,
    List<UpdateCabinet>? cabinets,
  }) = _WarehouseCabinetUpdateRequestModel;

  factory WarehouseCabinetUpdateRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseCabinetUpdateRequestModelFromJson(json);
}
