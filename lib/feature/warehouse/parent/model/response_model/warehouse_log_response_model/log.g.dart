// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LogImpl _$$LogImplFromJson(Map<String, dynamic> json) => _$LogImpl(
      logId: json['log_id'] as String?,
      userName: json['user_name'] as String?,
      createdAt: (json['created_at'] as num?)?.toInt(),
      operateType: (json['operate_type'] as num?)?.toInt(),
      entityType: (json['entity_type'] as num?)?.toInt(),
      logType: (json['log_type'] as num?)?.toInt(),
      entityName: (json['entity_name'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      descriptionName: (json['description_name'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      categoryName: (json['category_name'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      quantityCount: (json['quantity_count'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toInt())
          .toList(),
      minStockCount: (json['min_stock_count'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toInt())
          .toList(),
      roomName: (json['room_name'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      photoUrl: (json['photo_url'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$$LogImplToJson(_$LogImpl instance) => <String, dynamic>{
      'log_id': instance.logId,
      'user_name': instance.userName,
      'created_at': instance.createdAt,
      'operate_type': instance.operateType,
      'entity_type': instance.entityType,
      'log_type': instance.logType,
      'entity_name': instance.entityName,
      'description_name': instance.descriptionName,
      'category_name': instance.categoryName,
      'quantity_count': instance.quantityCount,
      'min_stock_count': instance.minStockCount,
      'room_name': instance.roomName,
      'photo_url': instance.photoUrl,
    };
