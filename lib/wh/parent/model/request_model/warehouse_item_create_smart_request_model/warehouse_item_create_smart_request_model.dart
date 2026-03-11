import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_item_create_smart_request_model.freezed.dart';
part 'warehouse_item_create_smart_request_model.g.dart';

@freezed
class WarehouseItemCreateSmartRequestModel with _$WarehouseItemCreateSmartRequestModel {
  factory WarehouseItemCreateSmartRequestModel({
    @JsonKey(name: 'household_id') String? householdId,
    String? image,
    String? language,
    @JsonKey(name: 'user_name') String? userName,
  }) = _WarehouseItemCreateSmartRequestModel;

  factory WarehouseItemCreateSmartRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseItemCreateSmartRequestModelFromJson(json);
}
