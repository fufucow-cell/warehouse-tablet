// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specific_date_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpecificDateResponseModelImpl _$$SpecificDateResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SpecificDateResponseModelImpl(
      bookingDate: (json['booking_date'] as num?)?.toInt(),
      isAllDay: json['is_all_day'] as bool?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
    );

Map<String, dynamic> _$$SpecificDateResponseModelImplToJson(
        _$SpecificDateResponseModelImpl instance) =>
    <String, dynamic>{
      'booking_date': instance.bookingDate,
      'is_all_day': instance.isAllDay,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };
