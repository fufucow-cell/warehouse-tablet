import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_item_smart_response_model.freezed.dart';
part 'warehouse_item_smart_response_model.g.dart';

@freezed
class WarehouseItemSmartResponseModel with _$WarehouseItemSmartResponseModel {
  factory WarehouseItemSmartResponseModel({
    String? name,
    String? description,
    @JsonKey(name: 'category_id') String? categoryId,
    String? category,
    @JsonKey(name: 'is_new_category') bool? isNewCategory,
    int? confidence,
  }) = _WarehouseItemSmartResponseModel;

  factory WarehouseItemSmartResponseModel.fromJson(Map<String, dynamic> json) => _$WarehouseItemSmartResponseModelFromJson(json);
}
