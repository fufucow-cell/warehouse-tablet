// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_reservable_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemReservableInfoImpl _$$ItemReservableInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$ItemReservableInfoImpl(
      name: json['name'] as String?,
      reservationKey: json['reservation_key'] as String?,
      categoryLv1Text: json['category_lv1_text'] as String?,
      categoryLv2Text: json['category_lv2_text'] as String?,
      categoryLv3Text: json['category_lv3_text'] as String?,
      description: json['description'] as String?,
      specification: json['specification'] as String?,
      notice: json['notice'] as String?,
      durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
      startAt: (json['start_at'] as num?)?.toInt(),
      endAt: (json['end_at'] as num?)?.toInt(),
      cancelTimeRange: (json['cancel_time_range'] as num?)?.toInt(),
      perBookingPeopleLimit:
          (json['per_booking_people_limit'] as num?)?.toInt(),
      totalPeopleLimit: (json['total_people_limit'] as num?)?.toInt(),
      fee: (json['fee'] as num?)?.toInt(),
      paymentType: (json['payment_type'] as num?)?.toInt(),
      dateRuleType: (json['date_rule_type'] as num?)?.toInt(),
      bookingLimitType: (json['booking_limit_type'] as num?)?.toInt(),
      isPublished: json['is_published'] as bool?,
    );

Map<String, dynamic> _$$ItemReservableInfoImplToJson(
        _$ItemReservableInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'reservation_key': instance.reservationKey,
      'category_lv1_text': instance.categoryLv1Text,
      'category_lv2_text': instance.categoryLv2Text,
      'category_lv3_text': instance.categoryLv3Text,
      'description': instance.description,
      'specification': instance.specification,
      'notice': instance.notice,
      'duration_minutes': instance.durationMinutes,
      'start_at': instance.startAt,
      'end_at': instance.endAt,
      'cancel_time_range': instance.cancelTimeRange,
      'per_booking_people_limit': instance.perBookingPeopleLimit,
      'total_people_limit': instance.totalPeopleLimit,
      'fee': instance.fee,
      'payment_type': instance.paymentType,
      'date_rule_type': instance.dateRuleType,
      'booking_limit_type': instance.bookingLimitType,
      'is_published': instance.isPublished,
    };
