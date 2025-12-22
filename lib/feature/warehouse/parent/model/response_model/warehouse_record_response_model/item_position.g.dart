// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemPositionImpl _$$ItemPositionImplFromJson(Map<String, dynamic> json) =>
    _$ItemPositionImpl(
      cabinetName: (json['cabinet_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ItemPositionImplToJson(_$ItemPositionImpl instance) =>
    <String, dynamic>{
      'cabinet_name': instance.cabinetName,
      'count': instance.count,
    };
