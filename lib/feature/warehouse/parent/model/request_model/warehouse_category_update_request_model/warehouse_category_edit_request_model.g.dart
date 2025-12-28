// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_category_edit_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseCategoryEditRequestModelImpl
    _$$WarehouseCategoryEditRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseCategoryEditRequestModelImpl(
          homeId: json['household_id'] as String,
          categoryId: json['category_id'] as String,
          name: json['name'] as String,
          parentId: json['parent_id'] as String?,
          level: (json['level'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$WarehouseCategoryEditRequestModelImplToJson(
        _$WarehouseCategoryEditRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.homeId,
      'category_id': instance.categoryId,
      'name': instance.name,
      'parent_id': instance.parentId,
      'level': instance.level,
    };
