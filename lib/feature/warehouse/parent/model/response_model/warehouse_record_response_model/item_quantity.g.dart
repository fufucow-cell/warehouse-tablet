// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_quantity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemQuantityImpl _$$ItemQuantityImplFromJson(Map<String, dynamic> json) =>
    _$ItemQuantityImpl(
      totalCount: (json['total_count'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      cabinets: (json['cabinets'] as List<dynamic>?)
          ?.map((e) => Cabinet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ItemQuantityImplToJson(_$ItemQuantityImpl instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'cabinets': instance.cabinets?.map((e) => e.toJson()).toList(),
    };
