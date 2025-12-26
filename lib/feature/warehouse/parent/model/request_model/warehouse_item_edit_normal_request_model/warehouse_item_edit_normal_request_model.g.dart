// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item_edit_normal_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseItemEditNormalRequestModelImpl
    _$$WarehouseItemEditNormalRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseItemEditNormalRequestModelImpl(
          householdId: json['household_id'] as String?,
          itemId: json['item_id'] as String?,
          photo: json['photo'] as String?,
          name: json['name'] as String?,
          description: json['description'] as String?,
          minStockAlert: (json['minStockAlert'] as num?)?.toInt(),
          categoryId: json['categoryId'] as String?,
        );

Map<String, dynamic> _$$WarehouseItemEditNormalRequestModelImplToJson(
        _$WarehouseItemEditNormalRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.householdId,
      'item_id': instance.itemId,
      'photo': instance.photo,
      'name': instance.name,
      'description': instance.description,
      'minStockAlert': instance.minStockAlert,
      'categoryId': instance.categoryId,
    };
