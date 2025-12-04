// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_cabinet_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseCabinetRequestModel _$WarehouseCabinetRequestModelFromJson(
        Map<String, dynamic> json) =>
    WarehouseCabinetRequestModel(
      cabinetId: json['cabinet_id'] as String?,
      homeId: (json['home_id'] as num?)?.toInt(),
      roomId: (json['room_id'] as num?)?.toInt(),
      userName: json['user_name'] as String?,
    );

Map<String, dynamic> _$WarehouseCabinetRequestModelToJson(
        WarehouseCabinetRequestModel instance) =>
    <String, dynamic>{
      'cabinet_id': instance.cabinetId,
      'home_id': instance.homeId,
      'room_id': instance.roomId,
      'user_name': instance.userName,
    };
