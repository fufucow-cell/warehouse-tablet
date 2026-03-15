import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_record_response_model/community_info.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_record_response_model/item_reservable_info.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_record_response_model/user_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'datum.freezed.dart';
part 'datum.g.dart';

@freezed
class Datum with _$Datum {
  factory Datum({
    String? id,
    @JsonKey(name: 'order_id') String? orderId,
    @JsonKey(name: 'control_key') String? controlKey,
    @JsonKey(name: 'booking_start_at') int? bookingStartAt,
    @JsonKey(name: 'booking_end_at') int? bookingEndAt,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'order_type') int? orderType,
    @JsonKey(name: 'ticket_type') int? ticketType,
    @JsonKey(name: 'total_amount') int? totalAmount,
    @JsonKey(name: 'updated_at') int? updatedAt,
    @JsonKey(name: 'payment_type') int? paymentType,
    @JsonKey(name: 'ticket_created_at') int? ticketCreatedAt,
    @JsonKey(name: 'payment_created_at') int? paymentCreatedAt,
    @JsonKey(name: 'adult_count') int? adultCount,
    @JsonKey(name: 'child_count') int? childCount,
    @JsonKey(name: 'item_reservable_info')
    ItemReservableInfo? itemReservableInfo,
    @JsonKey(name: 'user_info') UserInfo? userInfo,
    @JsonKey(name: 'community_info') CommunityInfo? communityInfo,
  }) = _Datum;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}

/// Alias for UI/service naming.
/// Keep Freezed-generated `Datum` intact to avoid regenerating code.
typedef RecordItem = Datum;
