// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_log_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseLogRequestModelImpl _$$WarehouseLogRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WarehouseLogRequestModelImpl(
      logId: json['log_id'] as String?,
      homeId: json['household_id'] as String?,
      afterTime: (json['after_time'] as num?)?.toInt(),
      operateType: (json['operate_type'] as num?)?.toInt(),
      itemType: (json['item_type'] as num?)?.toInt(),
      logType: (json['log_type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$WarehouseLogRequestModelImplToJson(
        _$WarehouseLogRequestModelImpl instance) =>
    <String, dynamic>{
      'log_id': instance.logId,
      'household_id': instance.homeId,
      'after_time': instance.afterTime,
      'operate_type': instance.operateType,
      'item_type': instance.itemType,
      'log_type': instance.logType,
    };
