// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_log_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseLogResponseModel _$WarehouseLogResponseModelFromJson(
        Map<String, dynamic> json) =>
    WarehouseLogResponseModel(
      logId: json['log_id'] as String?,
      homeId: (json['home_id'] as num?)?.toInt(),
      createdAt: (json['created_at'] as num?)?.toInt(),
      operateType: (json['operate_type'] as num?)?.toInt(),
      itemType: (json['item_type'] as num?)?.toInt(),
      modifyType: (json['modify_type'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      userName: json['user_name'] as String?,
      logType: (json['log_type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WarehouseLogResponseModelToJson(
        WarehouseLogResponseModel instance) =>
    <String, dynamic>{
      'log_id': instance.logId,
      'home_id': instance.homeId,
      'created_at': instance.createdAt,
      'operate_type': instance.operateType,
      'item_type': instance.itemType,
      'modify_type': instance.modifyType,
      'user_name': instance.userName,
      'log_type': instance.logType,
    };
