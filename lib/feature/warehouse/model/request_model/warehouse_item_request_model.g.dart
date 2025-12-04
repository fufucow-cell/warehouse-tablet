// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseItemRequestModel _$WarehouseItemRequestModelFromJson(
        Map<String, dynamic> json) =>
    WarehouseItemRequestModel(
      itemId: json['item_id'] as String?,
      cabinetId: json['cabinet_id'] as String?,
      categoryId: json['category_id'] as String?,
      roomId: (json['room_id'] as num?)?.toInt(),
      homeId: (json['home_id'] as num?)?.toInt(),
      minStockAlert: (json['min_stock_alert'] as num?)?.toInt(),
      userName: json['user_name'] as String?,
    );

Map<String, dynamic> _$WarehouseItemRequestModelToJson(
        WarehouseItemRequestModel instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'cabinet_id': instance.cabinetId,
      'category_id': instance.categoryId,
      'room_id': instance.roomId,
      'home_id': instance.homeId,
      'min_stock_alert': instance.minStockAlert,
      'user_name': instance.userName,
    };
