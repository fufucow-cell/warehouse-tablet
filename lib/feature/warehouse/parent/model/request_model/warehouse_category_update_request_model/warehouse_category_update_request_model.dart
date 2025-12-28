import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_category_update_request_model.freezed.dart';
part 'warehouse_category_update_request_model.g.dart';

@freezed
class WarehouseCategoryUpdateRequestModel with _$WarehouseCategoryUpdateRequestModel {
  factory WarehouseCategoryUpdateRequestModel({
    @JsonKey(name: 'household_id') required String homeId,
    @JsonKey(name: 'category_id') required String categoryId,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'parent_id') String? parentId,
  }) = _WarehouseCategoryUpdateRequestModel;

  factory WarehouseCategoryUpdateRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseCategoryUpdateRequestModelFromJson(json);
}
