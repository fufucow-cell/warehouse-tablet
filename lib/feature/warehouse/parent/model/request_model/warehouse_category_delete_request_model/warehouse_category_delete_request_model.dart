import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_category_delete_request_model.freezed.dart';
part 'warehouse_category_delete_request_model.g.dart';

@freezed
class WarehouseCategoryDeleteRequestModel
    with _$WarehouseCategoryDeleteRequestModel {
  factory WarehouseCategoryDeleteRequestModel({
    @JsonKey(name: 'household_id') required String homeId,
    @JsonKey(name: 'category_id') required String categoryId,
  }) = _WarehouseCategoryDeleteRequestModel;

  factory WarehouseCategoryDeleteRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseCategoryDeleteRequestModelFromJson(json);
}
