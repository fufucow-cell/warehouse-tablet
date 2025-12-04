// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_cabinet_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseCabinetResponseModel _$WarehouseCabinetResponseModelFromJson(
        Map<String, dynamic> json) =>
    WarehouseCabinetResponseModel(
      homeId: (json['home_id'] as num?)?.toInt(),
      roomId: (json['room_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WarehouseCabinetResponseModelToJson(
        WarehouseCabinetResponseModel instance) =>
    <String, dynamic>{
      'home_id': instance.homeId,
      'room_id': instance.roomId,
    };
