// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cabinet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CabinetImpl _$$CabinetImplFromJson(Map<String, dynamic> json) =>
    _$CabinetImpl(
      cabinetId: json['cabinet_id'] as String?,
      homeId: json['home_id'] as String?,
      roomId: json['room_id'] as String?,
      name: json['name'] as String?,
      roomName: json['room_name'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$CabinetImplToJson(_$CabinetImpl instance) =>
    <String, dynamic>{
      'cabinet_id': instance.cabinetId,
      'home_id': instance.homeId,
      'room_id': instance.roomId,
      'name': instance.name,
      'room_name': instance.roomName,
      'description': instance.description,
    };
