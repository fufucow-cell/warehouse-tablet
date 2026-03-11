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
          roomId: json['room_id'] as String?,
          userName: json['user_name'] as String?,
          roomName: json['room_name'] as String?,
          name: json['name'] as String?,
        );

Map<String, dynamic> _$$WarehouseCabinetCreateRequestModelImplToJson(
        _$WarehouseCabinetCreateRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.householdId,
      'room_id': instance.roomId,
      'user_name': instance.userName,
      'room_name': instance.roomName,
      'name': instance.name,
    };
