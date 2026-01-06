// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_cabinet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateCabinetImpl _$$UpdateCabinetImplFromJson(Map<String, dynamic> json) =>
    _$UpdateCabinetImpl(
      cabinetId: json['cabinet_id'] as String?,
      newUpdateCabinetName: json['new_cabinet_name'] as String?,
      newRoomId: json['new_room_id'] as String?,
    );

Map<String, dynamic> _$$UpdateCabinetImplToJson(_$UpdateCabinetImpl instance) =>
    <String, dynamic>{
      'cabinet_id': instance.cabinetId,
      'new_cabinet_name': instance.newUpdateCabinetName,
      'new_room_id': instance.newRoomId,
    };
