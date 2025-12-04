// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_room_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeRoomRequestModel _$HomeRoomRequestModelFromJson(
        Map<String, dynamic> json) =>
    HomeRoomRequestModel(
      homeId: (json['home_id'] as num?)?.toInt(),
      roomId: (json['room_id'] as num?)?.toInt(),
      roomName: json['room_name'] as String?,
    );

Map<String, dynamic> _$HomeRoomRequestModelToJson(
        HomeRoomRequestModel instance) =>
    <String, dynamic>{
      'home_id': instance.homeId,
      'room_id': instance.roomId,
      'room_name': instance.roomName,
    };
