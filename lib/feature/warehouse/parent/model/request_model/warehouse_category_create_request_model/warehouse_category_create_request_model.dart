import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_category_create_request_model.freezed.dart';
part 'warehouse_category_create_request_model.g.dart';

@freezed
class WarehouseCategoryCreateRequestModel with _$WarehouseCategoryCreateRequestModel {
  factory WarehouseCategoryCreateRequestModel({
    required String name,
    @JsonKey(name: 'household_id') required String homeId,
    @JsonKey(name: 'parent_id') String? parentId,
  }) = _WarehouseCategoryCreateRequestModel;

  factory WarehouseCategoryCreateRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseCategoryCreateRequestModelFromJson(json);
}
