// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'datum.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Datum _$DatumFromJson(Map<String, dynamic> json) {
  return _Datum.fromJson(json);
}

/// @nodoc
mixin _$Datum {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_id')
  String? get orderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'control_key')
  String? get controlKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_start_at')
  int? get bookingStartAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_end_at')
  int? get bookingEndAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_type')
  int? get orderType => throw _privateConstructorUsedError;
  @JsonKey(name: 'ticket_type')
  int? get ticketType => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  int? get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  int? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_type')
  int? get paymentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'ticket_created_at')
  int? get ticketCreatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_created_at')
  int? get paymentCreatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'adult_count')
  int? get adultCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'child_count')
  int? get childCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_reservable_info')
  ItemReservableInfo? get itemReservableInfo =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'user_info')
  UserInfo? get userInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'community_info')
  CommunityInfo? get communityInfo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DatumCopyWith<Datum> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatumCopyWith<$Res> {
  factory $DatumCopyWith(Datum value, $Res Function(Datum) then) =
      _$DatumCopyWithImpl<$Res, Datum>;
  @useResult
  $Res call(
      {String? id,
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
      @JsonKey(name: 'community_info') CommunityInfo? communityInfo});

  $ItemReservableInfoCopyWith<$Res>? get itemReservableInfo;
  $UserInfoCopyWith<$Res>? get userInfo;
  $CommunityInfoCopyWith<$Res>? get communityInfo;
}

/// @nodoc
class _$DatumCopyWithImpl<$Res, $Val extends Datum>
    implements $DatumCopyWith<$Res> {
  _$DatumCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? orderId = freezed,
    Object? controlKey = freezed,
    Object? bookingStartAt = freezed,
    Object? bookingEndAt = freezed,
    Object? createdAt = freezed,
    Object? orderType = freezed,
    Object? ticketType = freezed,
    Object? totalAmount = freezed,
    Object? updatedAt = freezed,
    Object? paymentType = freezed,
    Object? ticketCreatedAt = freezed,
    Object? paymentCreatedAt = freezed,
    Object? adultCount = freezed,
    Object? childCount = freezed,
    Object? itemReservableInfo = freezed,
    Object? userInfo = freezed,
    Object? communityInfo = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      controlKey: freezed == controlKey
          ? _value.controlKey
          : controlKey // ignore: cast_nullable_to_non_nullable
              as String?,
      bookingStartAt: freezed == bookingStartAt
          ? _value.bookingStartAt
          : bookingStartAt // ignore: cast_nullable_to_non_nullable
              as int?,
      bookingEndAt: freezed == bookingEndAt
          ? _value.bookingEndAt
          : bookingEndAt // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
      orderType: freezed == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as int?,
      ticketType: freezed == ticketType
          ? _value.ticketType
          : ticketType // ignore: cast_nullable_to_non_nullable
              as int?,
      totalAmount: freezed == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as int?,
      ticketCreatedAt: freezed == ticketCreatedAt
          ? _value.ticketCreatedAt
          : ticketCreatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentCreatedAt: freezed == paymentCreatedAt
          ? _value.paymentCreatedAt
          : paymentCreatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      adultCount: freezed == adultCount
          ? _value.adultCount
          : adultCount // ignore: cast_nullable_to_non_nullable
              as int?,
      childCount: freezed == childCount
          ? _value.childCount
          : childCount // ignore: cast_nullable_to_non_nullable
              as int?,
      itemReservableInfo: freezed == itemReservableInfo
          ? _value.itemReservableInfo
          : itemReservableInfo // ignore: cast_nullable_to_non_nullable
              as ItemReservableInfo?,
      userInfo: freezed == userInfo
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as UserInfo?,
      communityInfo: freezed == communityInfo
          ? _value.communityInfo
          : communityInfo // ignore: cast_nullable_to_non_nullable
              as CommunityInfo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ItemReservableInfoCopyWith<$Res>? get itemReservableInfo {
    if (_value.itemReservableInfo == null) {
      return null;
    }

    return $ItemReservableInfoCopyWith<$Res>(_value.itemReservableInfo!,
        (value) {
      return _then(_value.copyWith(itemReservableInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserInfoCopyWith<$Res>? get userInfo {
    if (_value.userInfo == null) {
      return null;
    }

    return $UserInfoCopyWith<$Res>(_value.userInfo!, (value) {
      return _then(_value.copyWith(userInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CommunityInfoCopyWith<$Res>? get communityInfo {
    if (_value.communityInfo == null) {
      return null;
    }

    return $CommunityInfoCopyWith<$Res>(_value.communityInfo!, (value) {
      return _then(_value.copyWith(communityInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DatumImplCopyWith<$Res> implements $DatumCopyWith<$Res> {
  factory _$$DatumImplCopyWith(
          _$DatumImpl value, $Res Function(_$DatumImpl) then) =
      __$$DatumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
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
      @JsonKey(name: 'community_info') CommunityInfo? communityInfo});

  @override
  $ItemReservableInfoCopyWith<$Res>? get itemReservableInfo;
  @override
  $UserInfoCopyWith<$Res>? get userInfo;
  @override
  $CommunityInfoCopyWith<$Res>? get communityInfo;
}

/// @nodoc
class __$$DatumImplCopyWithImpl<$Res>
    extends _$DatumCopyWithImpl<$Res, _$DatumImpl>
    implements _$$DatumImplCopyWith<$Res> {
  __$$DatumImplCopyWithImpl(
      _$DatumImpl _value, $Res Function(_$DatumImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? orderId = freezed,
    Object? controlKey = freezed,
    Object? bookingStartAt = freezed,
    Object? bookingEndAt = freezed,
    Object? createdAt = freezed,
    Object? orderType = freezed,
    Object? ticketType = freezed,
    Object? totalAmount = freezed,
    Object? updatedAt = freezed,
    Object? paymentType = freezed,
    Object? ticketCreatedAt = freezed,
    Object? paymentCreatedAt = freezed,
    Object? adultCount = freezed,
    Object? childCount = freezed,
    Object? itemReservableInfo = freezed,
    Object? userInfo = freezed,
    Object? communityInfo = freezed,
  }) {
    return _then(_$DatumImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      controlKey: freezed == controlKey
          ? _value.controlKey
          : controlKey // ignore: cast_nullable_to_non_nullable
              as String?,
      bookingStartAt: freezed == bookingStartAt
          ? _value.bookingStartAt
          : bookingStartAt // ignore: cast_nullable_to_non_nullable
              as int?,
      bookingEndAt: freezed == bookingEndAt
          ? _value.bookingEndAt
          : bookingEndAt // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
      orderType: freezed == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as int?,
      ticketType: freezed == ticketType
          ? _value.ticketType
          : ticketType // ignore: cast_nullable_to_non_nullable
              as int?,
      totalAmount: freezed == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as int?,
      ticketCreatedAt: freezed == ticketCreatedAt
          ? _value.ticketCreatedAt
          : ticketCreatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentCreatedAt: freezed == paymentCreatedAt
          ? _value.paymentCreatedAt
          : paymentCreatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      adultCount: freezed == adultCount
          ? _value.adultCount
          : adultCount // ignore: cast_nullable_to_non_nullable
              as int?,
      childCount: freezed == childCount
          ? _value.childCount
          : childCount // ignore: cast_nullable_to_non_nullable
              as int?,
      itemReservableInfo: freezed == itemReservableInfo
          ? _value.itemReservableInfo
          : itemReservableInfo // ignore: cast_nullable_to_non_nullable
              as ItemReservableInfo?,
      userInfo: freezed == userInfo
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as UserInfo?,
      communityInfo: freezed == communityInfo
          ? _value.communityInfo
          : communityInfo // ignore: cast_nullable_to_non_nullable
              as CommunityInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DatumImpl implements _Datum {
  _$DatumImpl(
      {this.id,
      @JsonKey(name: 'order_id') this.orderId,
      @JsonKey(name: 'control_key') this.controlKey,
      @JsonKey(name: 'booking_start_at') this.bookingStartAt,
      @JsonKey(name: 'booking_end_at') this.bookingEndAt,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'order_type') this.orderType,
      @JsonKey(name: 'ticket_type') this.ticketType,
      @JsonKey(name: 'total_amount') this.totalAmount,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'payment_type') this.paymentType,
      @JsonKey(name: 'ticket_created_at') this.ticketCreatedAt,
      @JsonKey(name: 'payment_created_at') this.paymentCreatedAt,
      @JsonKey(name: 'adult_count') this.adultCount,
      @JsonKey(name: 'child_count') this.childCount,
      @JsonKey(name: 'item_reservable_info') this.itemReservableInfo,
      @JsonKey(name: 'user_info') this.userInfo,
      @JsonKey(name: 'community_info') this.communityInfo});

  factory _$DatumImpl.fromJson(Map<String, dynamic> json) =>
      _$$DatumImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'order_id')
  final String? orderId;
  @override
  @JsonKey(name: 'control_key')
  final String? controlKey;
  @override
  @JsonKey(name: 'booking_start_at')
  final int? bookingStartAt;
  @override
  @JsonKey(name: 'booking_end_at')
  final int? bookingEndAt;
  @override
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @override
  @JsonKey(name: 'order_type')
  final int? orderType;
  @override
  @JsonKey(name: 'ticket_type')
  final int? ticketType;
  @override
  @JsonKey(name: 'total_amount')
  final int? totalAmount;
  @override
  @JsonKey(name: 'updated_at')
  final int? updatedAt;
  @override
  @JsonKey(name: 'payment_type')
  final int? paymentType;
  @override
  @JsonKey(name: 'ticket_created_at')
  final int? ticketCreatedAt;
  @override
  @JsonKey(name: 'payment_created_at')
  final int? paymentCreatedAt;
  @override
  @JsonKey(name: 'adult_count')
  final int? adultCount;
  @override
  @JsonKey(name: 'child_count')
  final int? childCount;
  @override
  @JsonKey(name: 'item_reservable_info')
  final ItemReservableInfo? itemReservableInfo;
  @override
  @JsonKey(name: 'user_info')
  final UserInfo? userInfo;
  @override
  @JsonKey(name: 'community_info')
  final CommunityInfo? communityInfo;

  @override
  String toString() {
    return 'Datum(id: $id, orderId: $orderId, controlKey: $controlKey, bookingStartAt: $bookingStartAt, bookingEndAt: $bookingEndAt, createdAt: $createdAt, orderType: $orderType, ticketType: $ticketType, totalAmount: $totalAmount, updatedAt: $updatedAt, paymentType: $paymentType, ticketCreatedAt: $ticketCreatedAt, paymentCreatedAt: $paymentCreatedAt, adultCount: $adultCount, childCount: $childCount, itemReservableInfo: $itemReservableInfo, userInfo: $userInfo, communityInfo: $communityInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatumImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.controlKey, controlKey) ||
                other.controlKey == controlKey) &&
            (identical(other.bookingStartAt, bookingStartAt) ||
                other.bookingStartAt == bookingStartAt) &&
            (identical(other.bookingEndAt, bookingEndAt) ||
                other.bookingEndAt == bookingEndAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.ticketType, ticketType) ||
                other.ticketType == ticketType) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.ticketCreatedAt, ticketCreatedAt) ||
                other.ticketCreatedAt == ticketCreatedAt) &&
            (identical(other.paymentCreatedAt, paymentCreatedAt) ||
                other.paymentCreatedAt == paymentCreatedAt) &&
            (identical(other.adultCount, adultCount) ||
                other.adultCount == adultCount) &&
            (identical(other.childCount, childCount) ||
                other.childCount == childCount) &&
            (identical(other.itemReservableInfo, itemReservableInfo) ||
                other.itemReservableInfo == itemReservableInfo) &&
            (identical(other.userInfo, userInfo) ||
                other.userInfo == userInfo) &&
            (identical(other.communityInfo, communityInfo) ||
                other.communityInfo == communityInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      orderId,
      controlKey,
      bookingStartAt,
      bookingEndAt,
      createdAt,
      orderType,
      ticketType,
      totalAmount,
      updatedAt,
      paymentType,
      ticketCreatedAt,
      paymentCreatedAt,
      adultCount,
      childCount,
      itemReservableInfo,
      userInfo,
      communityInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DatumImplCopyWith<_$DatumImpl> get copyWith =>
      __$$DatumImplCopyWithImpl<_$DatumImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DatumImplToJson(
      this,
    );
  }
}

abstract class _Datum implements Datum {
  factory _Datum(
      {final String? id,
      @JsonKey(name: 'order_id') final String? orderId,
      @JsonKey(name: 'control_key') final String? controlKey,
      @JsonKey(name: 'booking_start_at') final int? bookingStartAt,
      @JsonKey(name: 'booking_end_at') final int? bookingEndAt,
      @JsonKey(name: 'created_at') final int? createdAt,
      @JsonKey(name: 'order_type') final int? orderType,
      @JsonKey(name: 'ticket_type') final int? ticketType,
      @JsonKey(name: 'total_amount') final int? totalAmount,
      @JsonKey(name: 'updated_at') final int? updatedAt,
      @JsonKey(name: 'payment_type') final int? paymentType,
      @JsonKey(name: 'ticket_created_at') final int? ticketCreatedAt,
      @JsonKey(name: 'payment_created_at') final int? paymentCreatedAt,
      @JsonKey(name: 'adult_count') final int? adultCount,
      @JsonKey(name: 'child_count') final int? childCount,
      @JsonKey(name: 'item_reservable_info')
      final ItemReservableInfo? itemReservableInfo,
      @JsonKey(name: 'user_info') final UserInfo? userInfo,
      @JsonKey(name: 'community_info')
      final CommunityInfo? communityInfo}) = _$DatumImpl;

  factory _Datum.fromJson(Map<String, dynamic> json) = _$DatumImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'order_id')
  String? get orderId;
  @override
  @JsonKey(name: 'control_key')
  String? get controlKey;
  @override
  @JsonKey(name: 'booking_start_at')
  int? get bookingStartAt;
  @override
  @JsonKey(name: 'booking_end_at')
  int? get bookingEndAt;
  @override
  @JsonKey(name: 'created_at')
  int? get createdAt;
  @override
  @JsonKey(name: 'order_type')
  int? get orderType;
  @override
  @JsonKey(name: 'ticket_type')
  int? get ticketType;
  @override
  @JsonKey(name: 'total_amount')
  int? get totalAmount;
  @override
  @JsonKey(name: 'updated_at')
  int? get updatedAt;
  @override
  @JsonKey(name: 'payment_type')
  int? get paymentType;
  @override
  @JsonKey(name: 'ticket_created_at')
  int? get ticketCreatedAt;
  @override
  @JsonKey(name: 'payment_created_at')
  int? get paymentCreatedAt;
  @override
  @JsonKey(name: 'adult_count')
  int? get adultCount;
  @override
  @JsonKey(name: 'child_count')
  int? get childCount;
  @override
  @JsonKey(name: 'item_reservable_info')
  ItemReservableInfo? get itemReservableInfo;
  @override
  @JsonKey(name: 'user_info')
  UserInfo? get userInfo;
  @override
  @JsonKey(name: 'community_info')
  CommunityInfo? get communityInfo;
  @override
  @JsonKey(ignore: true)
  _$$DatumImplCopyWith<_$DatumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
