// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item_create_smart_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseItemCreateSmartRequestModelImpl
    _$$WarehouseItemCreateSmartRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseItemCreateSmartRequestModelImpl(
          householdId: json['household_id'] as String?,
          image: json['image'] as String?,
          language: json['language'] as String?,
          userName: json['user_name'] as String?,
        );

Map<String, dynamic> _$$WarehouseItemCreateSmartRequestModelImplToJson(
        _$WarehouseItemCreateSmartRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.householdId,
      'image': instance.image,
      'language': instance.language,
      'user_name': instance.userName,
    };
