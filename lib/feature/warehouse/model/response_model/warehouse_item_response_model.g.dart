// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseItemResponseModel _$WarehouseItemResponseModelFromJson(
        Map<String, dynamic> json) =>
    WarehouseItemResponseModel(
      cabinetId: json['cabinet_id'] as String?,
      roomId: (json['room_id'] as num?)?.toInt(),
      homeId: (json['home_id'] as num?)?.toInt(),
      minStockAlert: (json['min_stock_alert'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WarehouseItemResponseModelToJson(
        WarehouseItemResponseModel instance) =>
    <String, dynamic>{
      'cabinet_id': instance.cabinetId,
      'room_id': instance.roomId,
      'home_id': instance.homeId,
      'min_stock_alert': instance.minStockAlert,
    };
