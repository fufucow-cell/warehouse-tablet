// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_cabinet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateCabinetImpl _$$UpdateCabinetImplFromJson(Map<String, dynamic> json) =>
    _$UpdateCabinetImpl(
      cabinetId: json['cabinet_id'] as String?,
      newCabinetName: json['new_cabinet_name'] as String?,
      newRoomId: json['new_room_id'] as String?,
      oldRoomName: json['old_room_name'] as String?,
      newRoomName: json['new_room_name'] as String?,
    );

Map<String, dynamic> _$$UpdateCabinetImplToJson(_$UpdateCabinetImpl instance) =>
    <String, dynamic>{
      'cabinet_id': instance.cabinetId,
      'new_cabinet_name': instance.newCabinetName,
      'new_room_id': instance.newRoomId,
      'old_room_name': instance.oldRoomName,
      'new_room_name': instance.newRoomName,
    };
