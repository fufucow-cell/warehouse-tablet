import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_cabinet_create_request_model.freezed.dart';
part 'warehouse_cabinet_create_request_model.g.dart';

@freezed
class WarehouseCabinetCreateRequestModel
    with _$WarehouseCabinetCreateRequestModel {
  factory WarehouseCabinetCreateRequestModel({
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'room_id') String? roomId,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'room_name') String? roomName,
    String? name,
  }) = _WarehouseCabinetCreateRequestModel;

  factory WarehouseCabinetCreateRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseCabinetCreateRequestModelFromJson(json);
}
