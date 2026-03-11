// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_category_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseCategoryResponseModelImpl
    _$$WarehouseCategoryResponseModelImplFromJson(Map<String, dynamic> json) =>
        _$WarehouseCategoryResponseModelImpl(
          code: (json['code'] as num?)?.toInt(),
          message: json['message'] as String?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$WarehouseCategoryResponseModelImplToJson(
        _$WarehouseCategoryResponseModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
