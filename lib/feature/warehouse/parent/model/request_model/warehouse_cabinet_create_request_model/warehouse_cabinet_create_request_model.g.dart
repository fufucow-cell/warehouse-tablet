// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_cabinet_create_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseCabinetCreateRequestModelImpl
    _$$WarehouseCabinetCreateRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseCabinetCreateRequestModelImpl(
          householdId: json['household_id'] as String?,
          cabinetName: json['cabinet_name'] as String?,
          roomId: json['room_id'] as String?,
        );

Map<String, dynamic> _$$WarehouseCabinetCreateRequestModelImplToJson(
        _$WarehouseCabinetCreateRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.householdId,
      'cabinet_name': instance.cabinetName,
      'room_id': instance.roomId,
    };
