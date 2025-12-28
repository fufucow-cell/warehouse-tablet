// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_category_read_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseCategoryReadRequestModelImpl
    _$$WarehouseCategoryReadRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseCategoryReadRequestModelImpl(
          homeId: json['household_id'] as String?,
          categoryId: json['category_id'] as String?,
        );

Map<String, dynamic> _$$WarehouseCategoryReadRequestModelImplToJson(
        _$WarehouseCategoryReadRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.homeId,
      'category_id': instance.categoryId,
    };
