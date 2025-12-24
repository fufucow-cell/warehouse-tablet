// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item_create_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseItemCreateRequestModelImpl
    _$$WarehouseItemCreateRequestModelImplFromJson(Map<String, dynamic> json) =>
        _$WarehouseItemCreateRequestModelImpl(
          name: json['name'] as String,
          description: json['description'] as String?,
          quantity: (json['quantity'] as num).toInt(),
          minStockAlert: (json['min_stock_alert'] as num?)?.toInt(),
          photo: json['photo'] as String?,
          cabinetId: json['cabinet_id'] as String?,
          categoryId: json['category_id'] as String?,
          householdId: json['household_id'] as String?,
        );

Map<String, dynamic> _$$WarehouseItemCreateRequestModelImplToJson(
        _$WarehouseItemCreateRequestModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'quantity': instance.quantity,
      'min_stock_alert': instance.minStockAlert,
      'photo': instance.photo,
      'cabinet_id': instance.cabinetId,
      'category_id': instance.categoryId,
      'household_id': instance.householdId,
    };
