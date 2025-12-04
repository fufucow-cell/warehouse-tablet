// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_log_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseLogRequestModel _$WarehouseLogRequestModelFromJson(
        Map<String, dynamic> json) =>
    WarehouseLogRequestModel(
      logId: json['log_id'] as String?,
      homeId: (json['home_id'] as num?)?.toInt(),
      userName: json['user_name'] as String?,
      createdAt: (json['created_at'] as num?)?.toInt(),
      operateType: (json['operate_type'] as num?)?.toInt(),
      itemType: (json['item_type'] as num?)?.toInt(),
      logType: (json['log_type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WarehouseLogRequestModelToJson(
        WarehouseLogRequestModel instance) =>
    <String, dynamic>{
      'log_id': instance.logId,
      'home_id': instance.homeId,
      'user_name': instance.userName,
      'created_at': instance.createdAt,
      'operate_type': instance.operateType,
      'item_type': instance.itemType,
      'log_type': instance.logType,
    };
