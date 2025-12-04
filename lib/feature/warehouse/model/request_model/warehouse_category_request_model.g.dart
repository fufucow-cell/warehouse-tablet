// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_category_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseCategoryRequestModel _$WarehouseCategoryRequestModelFromJson(
        Map<String, dynamic> json) =>
    WarehouseCategoryRequestModel(
      categoryId: json['category_id'] as String?,
      parentId: json['parent_id'] as String?,
      homeId: (json['home_id'] as num?)?.toInt(),
      userName: json['user_name'] as String?,
    );

Map<String, dynamic> _$WarehouseCategoryRequestModelToJson(
        WarehouseCategoryRequestModel instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'parent_id': instance.parentId,
      'home_id': instance.homeId,
      'user_name': instance.userName,
    };
