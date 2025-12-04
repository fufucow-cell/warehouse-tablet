// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_room_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeRoomResponseModel _$HomeRoomResponseModelFromJson(
        Map<String, dynamic> json) =>
    HomeRoomResponseModel(
      roomId: (json['room_id'] as num?)?.toInt(),
      homeId: (json['home_id'] as num?)?.toInt(),
      roomName: json['room_name'] as String?,
    );

Map<String, dynamic> _$HomeRoomResponseModelToJson(
        HomeRoomResponseModel instance) =>
    <String, dynamic>{
      'room_id': instance.roomId,
      'home_id': instance.homeId,
      'room_name': instance.roomName,
    };
