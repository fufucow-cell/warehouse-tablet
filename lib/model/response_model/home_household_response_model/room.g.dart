// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      roomId: json['room_id'] as String?,
      homeId: json['home_id'] as String?,
      roomName: json['room_name'] as String?,
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'room_id': instance.roomId,
      'home_id': instance.homeId,
      'room_name': instance.roomName,
    };
