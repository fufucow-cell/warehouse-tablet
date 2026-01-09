import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_item_edit_quantity_request_model.freezed.dart';
part 'warehouse_item_edit_quantity_request_model.g.dart';

@freezed
class WarehouseItemEditQuantityRequestModel
    with _$WarehouseItemEditQuantityRequestModel {
  factory WarehouseItemEditQuantityRequestModel({
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'item_id') String? itemId,
    @JsonKey(name: 'user_name') String? userName,
    List<QuantityCabinetRequestModel>? cabinets,
  }) = _WarehouseItemEditQuantityRequestModel;

  factory WarehouseItemEditQuantityRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseItemEditQuantityRequestModelFromJson(json);
}

@freezed
class QuantityCabinetRequestModel with _$QuantityCabinetRequestModel {
  factory QuantityCabinetRequestModel({
    @JsonKey(name: 'cabinet_id') String? cabinetId,
    int? quantity,
  }) = _QuantityCabinetRequestModel;

  factory QuantityCabinetRequestModel.fromJson(Map<String, dynamic> json) =>
      _$QuantityCabinetRequestModelFromJson(json);
}
