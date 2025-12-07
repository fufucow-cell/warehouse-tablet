import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_cabinet_request_model.freezed.dart';
part 'warehouse_cabinet_request_model.g.dart';

@freezed
class WarehouseCabinetRequestModel with _$WarehouseCabinetRequestModel {
  factory WarehouseCabinetRequestModel({
    @JsonKey(name: 'cabinet_id') String? cabinetId,
    @JsonKey(name: 'home_id') String? homeId,
    @JsonKey(name: 'room_id') String? roomId,
  }) = _WarehouseCabinetRequestModel;

  factory WarehouseCabinetRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseCabinetRequestModelFromJson(json);
}
