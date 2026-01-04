import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_item_edit_normal_request_model.freezed.dart';
part 'warehouse_item_edit_normal_request_model.g.dart';

@freezed
class WarehouseItemEditNormalRequestModel with _$WarehouseItemEditNormalRequestModel {
  factory WarehouseItemEditNormalRequestModel({
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'item_id') String? itemId,
    String? photo,
    String? name,
    String? description,
    int? minStockAlert,
    String? categoryId,
    @JsonKey(name: 'user_name') String? userName,
  }) = _WarehouseItemEditNormalRequestModel;

  factory WarehouseItemEditNormalRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseItemEditNormalRequestModelFromJson(json);
}
