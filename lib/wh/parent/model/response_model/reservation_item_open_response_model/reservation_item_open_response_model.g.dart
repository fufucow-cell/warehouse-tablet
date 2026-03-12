// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_item_open_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationItemOpenResponseModelImpl
    _$$ReservationItemOpenResponseModelImplFromJson(
            Map<String, dynamic> json) =>
        _$ReservationItemOpenResponseModelImpl(
          code: (json['code'] as num?)?.toInt(),
          message: json['message'] as String?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$ReservationItemOpenResponseModelImplToJson(
        _$ReservationItemOpenResponseModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
