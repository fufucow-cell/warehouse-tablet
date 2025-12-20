// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_category_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseCategoryRequestModelImpl
    _$$WarehouseCategoryRequestModelImplFromJson(Map<String, dynamic> json) =>
        _$WarehouseCategoryRequestModelImpl(
          homeId: json['household_id'] as String?,
          categoryId: json['category_id'] as String?,
          parentId: json['parent_id'] as String?,
          level: (json['level'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$WarehouseCategoryRequestModelImplToJson(
        _$WarehouseCategoryRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.homeId,
      'category_id': instance.categoryId,
      'parent_id': instance.parentId,
      'level': instance.level,
    };
