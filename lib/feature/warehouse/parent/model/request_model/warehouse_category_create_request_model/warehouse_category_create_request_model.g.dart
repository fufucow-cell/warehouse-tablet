// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_category_create_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseCategoryCreateRequestModelImpl
    _$$WarehouseCategoryCreateRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseCategoryCreateRequestModelImpl(
          name: json['name'] as String,
          homeId: json['household_id'] as String,
          parentId: json['parent_id'] as String?,
        );

Map<String, dynamic> _$$WarehouseCategoryCreateRequestModelImplToJson(
        _$WarehouseCategoryCreateRequestModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'household_id': instance.homeId,
      'parent_id': instance.parentId,
    };
