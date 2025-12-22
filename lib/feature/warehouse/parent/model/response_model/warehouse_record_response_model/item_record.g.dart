// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemRecordImpl _$$ItemRecordImplFromJson(Map<String, dynamic> json) =>
    _$ItemRecordImpl(
      id: json['id'] as String?,
      householdId: json['household_id'] as String?,
      userName: json['user_name'] as String?,
      createdAt: (json['created_at'] as num?)?.toInt(),
      operateType: (json['operate_type'] as num?)?.toInt(),
      entityType: (json['entity_type'] as num?)?.toInt(),
      itemName: (json['item_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      itemDescription: (json['item_description'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      itemPhoto: (json['item_photo'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      itemMinStockCount: (json['item_min_stock_count'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      categoryName: (json['category_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      cabinetName: (json['cabinet_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      cabinetRoomName: (json['cabinet_room_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      itemPosition: (json['item_position'] as List<dynamic>?)
          ?.map((e) => ItemPosition.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemQuantity: json['item_quantity'] == null
          ? null
          : ItemQuantity.fromJson(
              json['item_quantity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ItemRecordImplToJson(_$ItemRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'household_id': instance.householdId,
      'user_name': instance.userName,
      'created_at': instance.createdAt,
      'operate_type': instance.operateType,
      'entity_type': instance.entityType,
      'item_name': instance.itemName,
      'item_description': instance.itemDescription,
      'item_photo': instance.itemPhoto,
      'item_min_stock_count': instance.itemMinStockCount,
      'category_name': instance.categoryName,
      'cabinet_name': instance.cabinetName,
      'cabinet_room_name': instance.cabinetRoomName,
      'item_position': instance.itemPosition?.map((e) => e.toJson()).toList(),
      'item_quantity': instance.itemQuantity?.toJson(),
    };
