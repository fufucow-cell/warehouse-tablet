// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemRecordImpl _$$ItemRecordImplFromJson(Map<String, dynamic> json) =>
    _$ItemRecordImpl(
      id: json['id'] as String?,
      householdId: json['household_id'] as String?,
      itemId: json['item_id'] as String?,
      userName: json['user_name'] as String?,
      createdAt: (json['created_at'] as num?)?.toInt(),
      operateType: (json['operate_type'] as num?)?.toInt(),
      entityType: (json['entity_type'] as num?)?.toInt(),
      itemName: _stringListFromJson(json['item_name']),
      itemDescription: _stringListFromJson(json['item_description']),
      itemPhoto: _stringListFromJson(json['item_photo']),
      itemMinStockCount: (json['item_min_stock_count'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      categoryName: _categoryNameListFromJson(json['category_name']),
      cabinetName: _stringListFromJson(json['cabinet_name']),
      cabinetRoomName: _stringListFromJson(json['cabinet_room_name']),
      quantityCount: (json['quantity_count'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$ItemRecordImplToJson(_$ItemRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'household_id': instance.householdId,
      'item_id': instance.itemId,
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
      'quantity_count': instance.quantityCount,
    };
