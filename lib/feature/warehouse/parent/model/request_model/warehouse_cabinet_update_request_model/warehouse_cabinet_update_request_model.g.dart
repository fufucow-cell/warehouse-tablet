// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_cabinet_update_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseCabinetUpdateRequestModelImpl
    _$$WarehouseCabinetUpdateRequestModelImplFromJson(
            Map<String, dynamic> json) =>
        _$WarehouseCabinetUpdateRequestModelImpl(
          householdId: json['household_id'] as String?,
          cabinets: (json['cabinets'] as List<dynamic>?)
              ?.map((e) => RequestCabinet.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$WarehouseCabinetUpdateRequestModelImplToJson(
        _$WarehouseCabinetUpdateRequestModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.householdId,
      'cabinets': instance.cabinets?.map((e) => e.toJson()).toList(),
    };
