// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_cabinet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestCabinetImpl _$$RequestCabinetImplFromJson(Map<String, dynamic> json) =>
    _$RequestCabinetImpl(
      cabinetId: json['cabinet_id'] as String?,
      newRequestCabinetName: json['new_cabinet_name'] as String?,
      newRoomId: json['new_room_id'] as String?,
      isDelete: json['is_delete'] as bool?,
    );

Map<String, dynamic> _$$RequestCabinetImplToJson(
        _$RequestCabinetImpl instance) =>
    <String, dynamic>{
      'cabinet_id': instance.cabinetId,
      'new_cabinet_name': instance.newRequestCabinetName,
      'new_room_id': instance.newRoomId,
      'is_delete': instance.isDelete,
    };
