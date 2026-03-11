// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_category_update_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseCategoryUpdateRequestModelImpl
    _$$WarehouseCategoryUpdateRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseCategoryUpdateRequestModelImpl(
          householdId: json['household_id'] as String,
          categoryId: json['category_id'] as String,
          name: json['name'] as String,
          parentId: json['parent_id'] as String?,
          userName: json['user_name'] as String?,
        );

Map<String, dynamic> _$$WarehouseCategoryUpdateRequestModelImplToJson(
        _$WarehouseCategoryUpdateRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.householdId,
      'category_id': instance.categoryId,
      'name': instance.name,
      'parent_id': instance.parentId,
      'user_name': instance.userName,
    };
