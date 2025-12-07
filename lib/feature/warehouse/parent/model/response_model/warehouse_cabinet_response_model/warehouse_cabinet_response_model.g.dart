// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_cabinet_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseCabinetResponseModelImpl
    _$$WarehouseCabinetResponseModelImplFromJson(Map<String, dynamic> json) =>
        _$WarehouseCabinetResponseModelImpl(
          code: (json['code'] as num?)?.toInt(),
          message: json['message'] as String?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => Cabinet.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$WarehouseCabinetResponseModelImplToJson(
        _$WarehouseCabinetResponseModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
