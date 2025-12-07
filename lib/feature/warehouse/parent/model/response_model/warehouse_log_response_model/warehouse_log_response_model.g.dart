// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_log_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseLogResponseModelImpl _$$WarehouseLogResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WarehouseLogResponseModelImpl(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Log.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WarehouseLogResponseModelImplToJson(
        _$WarehouseLogResponseModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
