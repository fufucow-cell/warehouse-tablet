// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item_edit_position_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseItemEditPositionRequestModelImpl
    _$$WarehouseItemEditPositionRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseItemEditPositionRequestModelImpl(
          householdId: json['household_id'] as String?,
          itemId: json['item_id'] as String?,
          userName: json['user_name'] as String?,
          cabinets: (json['cabinets'] as List<dynamic>?)
              ?.map((e) => PositionCabinetRequestModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$WarehouseItemEditPositionRequestModelImplToJson(
        _$WarehouseItemEditPositionRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.householdId,
      'item_id': instance.itemId,
      'user_name': instance.userName,
      'cabinets': instance.cabinets?.map((e) => e.toJson()).toList(),
    };

_$PositionCabinetRequestModelImpl _$$PositionCabinetRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PositionCabinetRequestModelImpl(
      oldCabinetId: json['old_cabinet_id'] as String?,
      newCabinetId: json['new_cabinet_id'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PositionCabinetRequestModelImplToJson(
        _$PositionCabinetRequestModelImpl instance) =>
    <String, dynamic>{
      'old_cabinet_id': instance.oldCabinetId,
      'new_cabinet_id': instance.newCabinetId,
      'quantity': instance.quantity,
    };
