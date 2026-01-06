// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseItemRequestModelImpl _$$WarehouseItemRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WarehouseItemRequestModelImpl(
      itemId: json['item_id'] as String?,
      cabinetId: json['cabinet_id'] as String?,
      categoryId: json['category_id'] as String?,
      roomId: json['room_id'] as String?,
      householdId: json['household_id'] as String?,
    );

Map<String, dynamic> _$$WarehouseItemRequestModelImplToJson(
        _$WarehouseItemRequestModelImpl instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'cabinet_id': instance.cabinetId,
      'category_id': instance.categoryId,
      'room_id': instance.roomId,
      'household_id': instance.householdId,
    };
