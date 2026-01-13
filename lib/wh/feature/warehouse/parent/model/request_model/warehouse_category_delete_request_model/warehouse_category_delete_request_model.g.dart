// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_category_delete_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseCategoryDeleteRequestModelImpl
    _$$WarehouseCategoryDeleteRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseCategoryDeleteRequestModelImpl(
          householdId: json['household_id'] as String,
          categoryId: json['category_id'] as String,
          userName: json['user_name'] as String?,
        );

Map<String, dynamic> _$$WarehouseCategoryDeleteRequestModelImplToJson(
        _$WarehouseCategoryDeleteRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.householdId,
      'category_id': instance.categoryId,
      'user_name': instance.userName,
    };
