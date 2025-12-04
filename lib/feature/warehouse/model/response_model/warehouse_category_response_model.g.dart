// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_category_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseCategoryResponseModel _$WarehouseCategoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    WarehouseCategoryResponseModel(
      homeId: (json['home_id'] as num?)?.toInt(),
      parentId: json['parent_id'] as String?,
    );

Map<String, dynamic> _$WarehouseCategoryResponseModelToJson(
        WarehouseCategoryResponseModel instance) =>
    <String, dynamic>{
      'home_id': instance.homeId,
      'parent_id': instance.parentId,
    };
