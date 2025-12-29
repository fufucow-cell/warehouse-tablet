import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_item_create_request_model.freezed.dart';
part 'warehouse_item_create_request_model.g.dart';

@freezed
class WarehouseItemCreateRequestModel with _$WarehouseItemCreateRequestModel {
  factory WarehouseItemCreateRequestModel({
    required String name,
    String? description,
    required int quantity,
    @JsonKey(name: 'min_stock_alert') int? minStockAlert,
    String? photo,
    @JsonKey(name: 'cabinet_id') String? cabinetId,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'household_id') String? householdId,
  }) = _WarehouseItemCreateRequestModel;

  factory WarehouseItemCreateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WarehouseItemCreateRequestModelFromJson(json);
}
