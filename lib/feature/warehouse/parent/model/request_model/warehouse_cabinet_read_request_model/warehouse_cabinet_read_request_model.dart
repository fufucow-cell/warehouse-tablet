import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_cabinet_read_request_model.freezed.dart';
part 'warehouse_cabinet_read_request_model.g.dart';

@freezed
class WarehouseCabinetReadRequestModel with _$WarehouseCabinetReadRequestModel {
  factory WarehouseCabinetReadRequestModel({
    @JsonKey(name: 'cabinet_id') String? cabinetId,
    @JsonKey(name: 'room_id') String? roomId,
    @JsonKey(name: 'household_id') String? householdId,
  }) = _WarehouseCabinetReadRequestModel;

  factory WarehouseCabinetReadRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$WarehouseCabinetReadRequestModelFromJson(json);
}
