// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LogImpl _$$LogImplFromJson(Map<String, dynamic> json) => _$LogImpl(
      id: json['id'] as String?,
      householdId: json['household_id'] as String?,
      userName: json['user_name'] as String?,
      createdAt: (json['created_at'] as num?)?.toInt(),
      operateType: (json['operate_type'] as num?)?.toInt(),
      entityType: (json['entity_type'] as num?)?.toInt(),
      recordType: (json['record_type'] as num?)?.toInt(),
      itemName: (json['item_name'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      itemDescription: (json['item_description'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      itemPhoto: (json['item_photo'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      itemMinStockCount: (json['item_min_stock_count'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toInt())
          .toList(),
      itemQuantity: json['item_quantity'] == null
          ? null
          : ItemQuantity.fromJson(
              json['item_quantity'] as Map<String, dynamic>),
      itemPosition: json['item_position'] == null
          ? null
          : ItemPosition.fromJson(
              json['item_position'] as Map<String, dynamic>),
      cabinetRoomName: (json['cabinet_room_name'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      cabinetName: (json['cabinet_name'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      categoryName: (json['category_name'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$$LogImplToJson(_$LogImpl instance) => <String, dynamic>{
      'id': instance.id,
      'household_id': instance.householdId,
      'user_name': instance.userName,
      'created_at': instance.createdAt,
      'operate_type': instance.operateType,
      'entity_type': instance.entityType,
      'record_type': instance.recordType,
      'item_name': instance.itemName,
      'item_description': instance.itemDescription,
      'item_photo': instance.itemPhoto,
      'item_min_stock_count': instance.itemMinStockCount,
      'item_quantity': instance.itemQuantity?.toJson(),
      'item_position': instance.itemPosition?.toJson(),
      'cabinet_room_name': instance.cabinetRoomName,
      'cabinet_name': instance.cabinetName,
      'category_name': instance.categoryName,
    };

_$ItemQuantityImpl _$$ItemQuantityImplFromJson(Map<String, dynamic> json) =>
    _$ItemQuantityImpl(
      totalCount: (json['total_count'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toInt())
          .toList(),
      cabinets: (json['cabinets'] as List<dynamic>?)
          ?.map((e) => ItemQuantityCabinet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ItemQuantityImplToJson(_$ItemQuantityImpl instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'cabinets': instance.cabinets?.map((e) => e.toJson()).toList(),
    };

_$ItemQuantityCabinetImpl _$$ItemQuantityCabinetImplFromJson(
        Map<String, dynamic> json) =>
    _$ItemQuantityCabinetImpl(
      cabinetName: json['cabinet_name'] as String?,
      count: (json['count'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toInt())
          .toList(),
    );

Map<String, dynamic> _$$ItemQuantityCabinetImplToJson(
        _$ItemQuantityCabinetImpl instance) =>
    <String, dynamic>{
      'cabinet_name': instance.cabinetName,
      'count': instance.count,
    };

_$ItemPositionImpl _$$ItemPositionImplFromJson(Map<String, dynamic> json) =>
    _$ItemPositionImpl(
      cabinets: (json['cabinets'] as List<dynamic>?)
          ?.map((e) => ItemPositionCabinet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ItemPositionImplToJson(_$ItemPositionImpl instance) =>
    <String, dynamic>{
      'cabinets': instance.cabinets?.map((e) => e.toJson()).toList(),
    };

_$ItemPositionCabinetImpl _$$ItemPositionCabinetImplFromJson(
        Map<String, dynamic> json) =>
    _$ItemPositionCabinetImpl(
      cabinetName: (json['cabinet_name'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ItemPositionCabinetImplToJson(
        _$ItemPositionCabinetImpl instance) =>
    <String, dynamic>{
      'cabinet_name': instance.cabinetName,
      'count': instance.count,
    };
