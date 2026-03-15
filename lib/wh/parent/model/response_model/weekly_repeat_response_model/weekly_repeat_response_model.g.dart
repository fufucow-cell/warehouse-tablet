// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_repeat_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeeklyRepeatResponseModelImpl _$$WeeklyRepeatResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WeeklyRepeatResponseModelImpl(
      day: (json['day'] as num?)?.toInt(),
      isEnable: json['is_enable'] as bool?,
      isAllDay: json['is_all_day'] as bool?,
      period: (json['period'] as List<dynamic>?)
          ?.map((e) => Period.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WeeklyRepeatResponseModelImplToJson(
        _$WeeklyRepeatResponseModelImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'is_enable': instance.isEnable,
      'is_all_day': instance.isAllDay,
      'period': instance.period?.map((e) => e.toJson()).toList(),
    };
