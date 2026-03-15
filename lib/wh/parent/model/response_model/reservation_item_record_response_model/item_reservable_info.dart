import 'package:engo_terminal_app3/wh/parent/model/response_model/specific_date_response_model/specific_date_response_model.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/weekly_repeat_response_model/weekly_repeat_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_reservable_info.freezed.dart';
part 'item_reservable_info.g.dart';

@freezed
class ItemReservableInfo with _$ItemReservableInfo {
  factory ItemReservableInfo({
    String? name,
    @JsonKey(name: 'reservation_key') String? reservationKey,
    @JsonKey(name: 'category_lv1_text') String? categoryLv1Text,
    @JsonKey(name: 'category_lv2_text') String? categoryLv2Text,
    @JsonKey(name: 'category_lv3_text') String? categoryLv3Text,
    String? description,
    String? specification,
    String? notice,
    @JsonKey(name: 'hour_limit') int? hourLimit,
    @JsonKey(name: 'start_at') int? startAt,
    @JsonKey(name: 'end_at') int? endAt,
    @JsonKey(name: 'cancel_time_range') int? cancelTimeRange,
    @JsonKey(name: 'per_booking_people_limit') int? perBookingPeopleLimit,
    @JsonKey(name: 'total_people_limit') int? totalPeopleLimit,
    int? fee,
    @JsonKey(name: 'payment_type') int? paymentType,
    @JsonKey(name: 'date_rule_type') int? dateRuleType,
    @JsonKey(name: 'booking_limit_type') int? bookingLimitType,
    @JsonKey(name: 'is_published') bool? isPublished,
    @JsonKey(name: 'weekly_repeat') List<WeeklyRepeatResponseModel>? weeklyRepeat,
    @JsonKey(name: 'specific_date') List<SpecificDateResponseModel>? specificDate,
    @JsonKey(name: 'image_urls') List<String>? imageUrls,
  }) = _ItemReservableInfo;

  factory ItemReservableInfo.fromJson(Map<String, dynamic> json) =>
      _$ItemReservableInfoFromJson(json);
}
