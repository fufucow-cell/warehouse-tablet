import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_item_edit_position_request_model.freezed.dart';
part 'warehouse_item_edit_position_request_model.g.dart';

@freezed
class WarehouseItemEditPositionRequestModel with _$WarehouseItemEditPositionRequestModel {
  factory WarehouseItemEditPositionRequestModel({
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'item_id') String? itemId,
    @JsonKey(name: 'user_name') String? userName,
    List<PositionCabinetRequestModel>? cabinets,
  }) = _WarehouseItemEditPositionRequestModel;

  factory WarehouseItemEditPositionRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseItemEditPositionRequestModelFromJson(json);
}

@freezed
class PositionCabinetRequestModel with _$PositionCabinetRequestModel {
  factory PositionCabinetRequestModel({
    @JsonKey(name: 'old_cabinet_id') String? oldCabinetId,
    @JsonKey(name: 'new_cabinet_id') String? newCabinetId,
    int? quantity,
  }) = _PositionCabinetRequestModel;

  factory PositionCabinetRequestModel.fromJson(Map<String, dynamic> json) => _$PositionCabinetRequestModelFromJson(json);
}
