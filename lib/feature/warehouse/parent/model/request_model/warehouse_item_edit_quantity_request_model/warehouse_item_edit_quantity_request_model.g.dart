// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item_edit_quantity_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseItemEditQuantityRequestModelImpl
    _$$WarehouseItemEditQuantityRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseItemEditQuantityRequestModelImpl(
          householdId: json['household_id'] as String?,
          itemId: json['item_id'] as String?,
          cabinets: (json['cabinets'] as List<dynamic>?)
              ?.map((e) => QuantityCabinetRequestModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$WarehouseItemEditQuantityRequestModelImplToJson(
        _$WarehouseItemEditQuantityRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.householdId,
      'item_id': instance.itemId,
      'cabinets': instance.cabinets?.map((e) => e.toJson()).toList(),
    };

_$QuantityCabinetRequestModelImpl _$$QuantityCabinetRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$QuantityCabinetRequestModelImpl(
      cabinetId: json['cabinet_id'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QuantityCabinetRequestModelImplToJson(
        _$QuantityCabinetRequestModelImpl instance) =>
    <String, dynamic>{
      'cabinet_id': instance.cabinetId,
      'quantity': instance.quantity,
    };
