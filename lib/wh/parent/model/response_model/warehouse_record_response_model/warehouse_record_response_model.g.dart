// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_record_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseRecordResponseModelImpl _$$WarehouseRecordResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WarehouseRecordResponseModelImpl(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WarehouseRecordResponseModelImplToJson(
        _$WarehouseRecordResponseModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
