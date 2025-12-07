import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'category.dart';

part 'warehouse_category_response_model.freezed.dart';
part 'warehouse_category_response_model.g.dart';

@freezed
class WarehouseCategoryResponseModel
    with _$WarehouseCategoryResponseModel {
  factory WarehouseCategoryResponseModel({
    int? code,
    String? message,
    List<Category>? data,
  }) = _WarehouseCategoryResponseModel;

  factory WarehouseCategoryResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$WarehouseCategoryResponseModelFromJson(json);
}
