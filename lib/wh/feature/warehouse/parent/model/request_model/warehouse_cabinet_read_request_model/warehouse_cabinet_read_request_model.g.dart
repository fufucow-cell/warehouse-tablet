// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_cabinet_read_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseCabinetReadRequestModelImpl
    _$$WarehouseCabinetReadRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseCabinetReadRequestModelImpl(
          cabinetId: json['cabinet_id'] as String?,
          roomId: json['room_id'] as String?,
          householdId: json['household_id'] as String?,
        );

Map<String, dynamic> _$$WarehouseCabinetReadRequestModelImplToJson(
        _$WarehouseCabinetReadRequestModelImpl instance) =>
    <String, dynamic>{
      'cabinet_id': instance.cabinetId,
      'room_id': instance.roomId,
      'household_id': instance.householdId,
    };
