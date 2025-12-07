import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_category_request_model.freezed.dart';
part 'warehouse_category_request_model.g.dart';

@freezed
class WarehouseCategoryRequestModel with _$WarehouseCategoryRequestModel {
  factory WarehouseCategoryRequestModel({
    @JsonKey(name: 'home_id') String? homeId,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'parent_id') String? parentId,
    int? level,
  }) = _WarehouseCategoryRequestModel;

  factory WarehouseCategoryRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WarehouseCategoryRequestModelFromJson(json);
}
