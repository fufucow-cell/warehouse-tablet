// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_cabinet_delete_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseCabinetDeleteRequestModelImpl
    _$$WarehouseCabinetDeleteRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseCabinetDeleteRequestModelImpl(
          householdId: json['household_id'] as String?,
          userName: json['user_name'] as String?,
          cabinets: (json['cabinets'] as List<dynamic>?)
              ?.map((e) => DeleteCabinet.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$WarehouseCabinetDeleteRequestModelImplToJson(
        _$WarehouseCabinetDeleteRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.householdId,
      'user_name': instance.userName,
      'cabinets': instance.cabinets?.map((e) => e.toJson()).toList(),
    };
