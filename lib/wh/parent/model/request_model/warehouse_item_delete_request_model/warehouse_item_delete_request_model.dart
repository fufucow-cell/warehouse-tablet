import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_item_delete_request_model.freezed.dart';
part 'warehouse_item_delete_request_model.g.dart';

@freezed
class WarehouseItemDeleteRequestModel with _$WarehouseItemDeleteRequestModel {
  factory WarehouseItemDeleteRequestModel({
    String? id,
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'user_name') String? userName,
  }) = _WarehouseItemDeleteRequestModel;

  factory WarehouseItemDeleteRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WarehouseItemDeleteRequestModelFromJson(json);
}
