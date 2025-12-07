// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseItemResponseModelImpl _$$WarehouseItemResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WarehouseItemResponseModelImpl(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WarehouseItemResponseModelImplToJson(
        _$WarehouseItemResponseModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
