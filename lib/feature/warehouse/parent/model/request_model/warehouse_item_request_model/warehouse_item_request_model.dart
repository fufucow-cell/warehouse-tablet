import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_item_request_model.freezed.dart';
part 'warehouse_item_request_model.g.dart';

@freezed
class WarehouseItemRequestModel with _$WarehouseItemRequestModel {
  factory WarehouseItemRequestModel({
    @JsonKey(name: 'item_id') String? itemId,
    @JsonKey(name: 'cabinet_id') String? cabinetId,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'room_id') String? roomId,
    @JsonKey(name: 'household_id') String? householdId,
  }) = _WarehouseItemRequestModel;

  factory WarehouseItemRequestModel.fromJson(Map<String, dynamic> json) => _$WarehouseItemRequestModelFromJson(json);
}
