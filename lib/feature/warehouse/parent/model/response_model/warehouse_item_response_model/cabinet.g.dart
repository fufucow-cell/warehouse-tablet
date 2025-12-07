// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cabinet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CabinetImpl _$$CabinetImplFromJson(Map<String, dynamic> json) =>
    _$CabinetImpl(
      cabinetId: json['cabinet_id'] as String?,
      name: json['name'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CabinetImplToJson(_$CabinetImpl instance) =>
    <String, dynamic>{
      'cabinet_id': instance.cabinetId,
      'name': instance.name,
      'quantity': instance.quantity,
    };
