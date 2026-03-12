// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DatumImpl _$$DatumImplFromJson(Map<String, dynamic> json) => _$DatumImpl(
      id: json['id'] as String?,
      orderId: json['order_id'] as String?,
      controlKey: json['control_key'] as String?,
      bookingStartAt: (json['booking_start_at'] as num?)?.toInt(),
      bookingEndAt: (json['booking_end_at'] as num?)?.toInt(),
      createdAt: (json['created_at'] as num?)?.toInt(),
      orderType: (json['order_type'] as num?)?.toInt(),
      ticketType: (json['ticket_type'] as num?)?.toInt(),
      totalAmount: (json['total_amount'] as num?)?.toInt(),
      itemReservableInfo: json['item_reservable_info'] == null
          ? null
          : ItemReservableInfo.fromJson(
              json['item_reservable_info'] as Map<String, dynamic>),
      userInfo: json['user_info'] == null
          ? null
          : UserInfo.fromJson(json['user_info'] as Map<String, dynamic>),
      communityInfo: json['community_info'] == null
          ? null
          : CommunityInfo.fromJson(
              json['community_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DatumImplToJson(_$DatumImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'control_key': instance.controlKey,
      'booking_start_at': instance.bookingStartAt,
      'booking_end_at': instance.bookingEndAt,
      'created_at': instance.createdAt,
      'order_type': instance.orderType,
      'ticket_type': instance.ticketType,
      'total_amount': instance.totalAmount,
      'item_reservable_info': instance.itemReservableInfo?.toJson(),
      'user_info': instance.userInfo?.toJson(),
      'community_info': instance.communityInfo?.toJson(),
    };
