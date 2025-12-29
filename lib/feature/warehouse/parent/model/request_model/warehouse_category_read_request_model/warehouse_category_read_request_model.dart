import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_category_read_request_model.freezed.dart';
part 'warehouse_category_read_request_model.g.dart';

@freezed
class WarehouseCategoryReadRequestModel
    with _$WarehouseCategoryReadRequestModel {
  factory WarehouseCategoryReadRequestModel({
    @JsonKey(name: 'household_id') String? homeId,
    @JsonKey(name: 'category_id') String? categoryId,
  }) = _WarehouseCategoryReadRequestModel;

  factory WarehouseCategoryReadRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseCategoryReadRequestModelFromJson(json);
}
