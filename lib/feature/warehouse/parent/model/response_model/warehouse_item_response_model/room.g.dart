// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      roomId: json['room_id'] as String?,
      roomName: json['room_name'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      cabinets: (json['cabinets'] as List<dynamic>?)
          ?.map((e) => Cabinet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'room_id': instance.roomId,
      'room_name': instance.roomName,
      'quantity': instance.quantity,
      'cabinets': instance.cabinets?.map((e) => e.toJson()).toList(),
    };
