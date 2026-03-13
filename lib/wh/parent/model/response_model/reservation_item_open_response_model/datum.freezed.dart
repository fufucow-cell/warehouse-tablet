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
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'reservation_key')
  String? get reservationKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_lv1_text')
  String? get categoryLv1Text => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_lv2_text')
  String? get categoryLv2Text => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_lv3_text')
  String? get categoryLv3Text => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get specification => throw _privateConstructorUsedError;
  String? get notice => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_at')
  int? get startAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_at')
  int? get endAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancel_time_range')
  int? get cancelTimeRange => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_booking_people_limit')
  int? get perBookingPeopleLimit => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_people_limit')
  int? get totalPeopleLimit => throw _privateConstructorUsedError;
  int? get fee => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_type')
  int? get paymentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_rule_type')
  int? get dateRuleType => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_limit_type')
  int? get bookingLimitType => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_published')
  bool? get isPublished => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_urls')
  List<String>? get imageUrls => throw _privateConstructorUsedError;

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
      {String? name,
      @JsonKey(name: 'reservation_key') String? reservationKey,
      @JsonKey(name: 'category_lv1_text') String? categoryLv1Text,
      @JsonKey(name: 'category_lv2_text') String? categoryLv2Text,
      @JsonKey(name: 'category_lv3_text') String? categoryLv3Text,
      String? description,
      String? specification,
      String? notice,
      @JsonKey(name: 'duration_minutes') int? durationMinutes,
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
      @JsonKey(name: 'image_urls') List<String>? imageUrls});
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
    Object? name = freezed,
    Object? reservationKey = freezed,
    Object? categoryLv1Text = freezed,
    Object? categoryLv2Text = freezed,
    Object? categoryLv3Text = freezed,
    Object? description = freezed,
    Object? specification = freezed,
    Object? notice = freezed,
    Object? durationMinutes = freezed,
    Object? startAt = freezed,
    Object? endAt = freezed,
    Object? cancelTimeRange = freezed,
    Object? perBookingPeopleLimit = freezed,
    Object? totalPeopleLimit = freezed,
    Object? fee = freezed,
    Object? paymentType = freezed,
    Object? dateRuleType = freezed,
    Object? bookingLimitType = freezed,
    Object? isPublished = freezed,
    Object? imageUrls = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      reservationKey: freezed == reservationKey
          ? _value.reservationKey
          : reservationKey // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryLv1Text: freezed == categoryLv1Text
          ? _value.categoryLv1Text
          : categoryLv1Text // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryLv2Text: freezed == categoryLv2Text
          ? _value.categoryLv2Text
          : categoryLv2Text // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryLv3Text: freezed == categoryLv3Text
          ? _value.categoryLv3Text
          : categoryLv3Text // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      specification: freezed == specification
          ? _value.specification
          : specification // ignore: cast_nullable_to_non_nullable
              as String?,
      notice: freezed == notice
          ? _value.notice
          : notice // ignore: cast_nullable_to_non_nullable
              as String?,
      durationMinutes: freezed == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      startAt: freezed == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as int?,
      endAt: freezed == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as int?,
      cancelTimeRange: freezed == cancelTimeRange
          ? _value.cancelTimeRange
          : cancelTimeRange // ignore: cast_nullable_to_non_nullable
              as int?,
      perBookingPeopleLimit: freezed == perBookingPeopleLimit
          ? _value.perBookingPeopleLimit
          : perBookingPeopleLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPeopleLimit: freezed == totalPeopleLimit
          ? _value.totalPeopleLimit
          : totalPeopleLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as int?,
      dateRuleType: freezed == dateRuleType
          ? _value.dateRuleType
          : dateRuleType // ignore: cast_nullable_to_non_nullable
              as int?,
      bookingLimitType: freezed == bookingLimitType
          ? _value.bookingLimitType
          : bookingLimitType // ignore: cast_nullable_to_non_nullable
              as int?,
      isPublished: freezed == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool?,
      imageUrls: freezed == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
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
      {String? name,
      @JsonKey(name: 'reservation_key') String? reservationKey,
      @JsonKey(name: 'category_lv1_text') String? categoryLv1Text,
      @JsonKey(name: 'category_lv2_text') String? categoryLv2Text,
      @JsonKey(name: 'category_lv3_text') String? categoryLv3Text,
      String? description,
      String? specification,
      String? notice,
      @JsonKey(name: 'duration_minutes') int? durationMinutes,
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
      @JsonKey(name: 'image_urls') List<String>? imageUrls});
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
    Object? name = freezed,
    Object? reservationKey = freezed,
    Object? categoryLv1Text = freezed,
    Object? categoryLv2Text = freezed,
    Object? categoryLv3Text = freezed,
    Object? description = freezed,
    Object? specification = freezed,
    Object? notice = freezed,
    Object? durationMinutes = freezed,
    Object? startAt = freezed,
    Object? endAt = freezed,
    Object? cancelTimeRange = freezed,
    Object? perBookingPeopleLimit = freezed,
    Object? totalPeopleLimit = freezed,
    Object? fee = freezed,
    Object? paymentType = freezed,
    Object? dateRuleType = freezed,
    Object? bookingLimitType = freezed,
    Object? isPublished = freezed,
    Object? imageUrls = freezed,
  }) {
    return _then(_$DatumImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      reservationKey: freezed == reservationKey
          ? _value.reservationKey
          : reservationKey // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryLv1Text: freezed == categoryLv1Text
          ? _value.categoryLv1Text
          : categoryLv1Text // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryLv2Text: freezed == categoryLv2Text
          ? _value.categoryLv2Text
          : categoryLv2Text // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryLv3Text: freezed == categoryLv3Text
          ? _value.categoryLv3Text
          : categoryLv3Text // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      specification: freezed == specification
          ? _value.specification
          : specification // ignore: cast_nullable_to_non_nullable
              as String?,
      notice: freezed == notice
          ? _value.notice
          : notice // ignore: cast_nullable_to_non_nullable
              as String?,
      durationMinutes: freezed == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      startAt: freezed == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as int?,
      endAt: freezed == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as int?,
      cancelTimeRange: freezed == cancelTimeRange
          ? _value.cancelTimeRange
          : cancelTimeRange // ignore: cast_nullable_to_non_nullable
              as int?,
      perBookingPeopleLimit: freezed == perBookingPeopleLimit
          ? _value.perBookingPeopleLimit
          : perBookingPeopleLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPeopleLimit: freezed == totalPeopleLimit
          ? _value.totalPeopleLimit
          : totalPeopleLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as int?,
      dateRuleType: freezed == dateRuleType
          ? _value.dateRuleType
          : dateRuleType // ignore: cast_nullable_to_non_nullable
              as int?,
      bookingLimitType: freezed == bookingLimitType
          ? _value.bookingLimitType
          : bookingLimitType // ignore: cast_nullable_to_non_nullable
              as int?,
      isPublished: freezed == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool?,
      imageUrls: freezed == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DatumImpl implements _Datum {
  _$DatumImpl(
      {this.name,
      @JsonKey(name: 'reservation_key') this.reservationKey,
      @JsonKey(name: 'category_lv1_text') this.categoryLv1Text,
      @JsonKey(name: 'category_lv2_text') this.categoryLv2Text,
      @JsonKey(name: 'category_lv3_text') this.categoryLv3Text,
      this.description,
      this.specification,
      this.notice,
      @JsonKey(name: 'duration_minutes') this.durationMinutes,
      @JsonKey(name: 'start_at') this.startAt,
      @JsonKey(name: 'end_at') this.endAt,
      @JsonKey(name: 'cancel_time_range') this.cancelTimeRange,
      @JsonKey(name: 'per_booking_people_limit') this.perBookingPeopleLimit,
      @JsonKey(name: 'total_people_limit') this.totalPeopleLimit,
      this.fee,
      @JsonKey(name: 'payment_type') this.paymentType,
      @JsonKey(name: 'date_rule_type') this.dateRuleType,
      @JsonKey(name: 'booking_limit_type') this.bookingLimitType,
      @JsonKey(name: 'is_published') this.isPublished,
      @JsonKey(name: 'image_urls') final List<String>? imageUrls})
      : _imageUrls = imageUrls;

  factory _$DatumImpl.fromJson(Map<String, dynamic> json) =>
      _$$DatumImplFromJson(json);

  @override
  final String? name;
  @override
  @JsonKey(name: 'reservation_key')
  final String? reservationKey;
  @override
  @JsonKey(name: 'category_lv1_text')
  final String? categoryLv1Text;
  @override
  @JsonKey(name: 'category_lv2_text')
  final String? categoryLv2Text;
  @override
  @JsonKey(name: 'category_lv3_text')
  final String? categoryLv3Text;
  @override
  final String? description;
  @override
  final String? specification;
  @override
  final String? notice;
  @override
  @JsonKey(name: 'duration_minutes')
  final int? durationMinutes;
  @override
  @JsonKey(name: 'start_at')
  final int? startAt;
  @override
  @JsonKey(name: 'end_at')
  final int? endAt;
  @override
  @JsonKey(name: 'cancel_time_range')
  final int? cancelTimeRange;
  @override
  @JsonKey(name: 'per_booking_people_limit')
  final int? perBookingPeopleLimit;
  @override
  @JsonKey(name: 'total_people_limit')
  final int? totalPeopleLimit;
  @override
  final int? fee;
  @override
  @JsonKey(name: 'payment_type')
  final int? paymentType;
  @override
  @JsonKey(name: 'date_rule_type')
  final int? dateRuleType;
  @override
  @JsonKey(name: 'booking_limit_type')
  final int? bookingLimitType;
  @override
  @JsonKey(name: 'is_published')
  final bool? isPublished;
  final List<String>? _imageUrls;
  @override
  @JsonKey(name: 'image_urls')
  List<String>? get imageUrls {
    final value = _imageUrls;
    if (value == null) return null;
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Datum(name: $name, reservationKey: $reservationKey, categoryLv1Text: $categoryLv1Text, categoryLv2Text: $categoryLv2Text, categoryLv3Text: $categoryLv3Text, description: $description, specification: $specification, notice: $notice, durationMinutes: $durationMinutes, startAt: $startAt, endAt: $endAt, cancelTimeRange: $cancelTimeRange, perBookingPeopleLimit: $perBookingPeopleLimit, totalPeopleLimit: $totalPeopleLimit, fee: $fee, paymentType: $paymentType, dateRuleType: $dateRuleType, bookingLimitType: $bookingLimitType, isPublished: $isPublished, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatumImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.reservationKey, reservationKey) ||
                other.reservationKey == reservationKey) &&
            (identical(other.categoryLv1Text, categoryLv1Text) ||
                other.categoryLv1Text == categoryLv1Text) &&
            (identical(other.categoryLv2Text, categoryLv2Text) ||
                other.categoryLv2Text == categoryLv2Text) &&
            (identical(other.categoryLv3Text, categoryLv3Text) ||
                other.categoryLv3Text == categoryLv3Text) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.specification, specification) ||
                other.specification == specification) &&
            (identical(other.notice, notice) || other.notice == notice) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt) &&
            (identical(other.cancelTimeRange, cancelTimeRange) ||
                other.cancelTimeRange == cancelTimeRange) &&
            (identical(other.perBookingPeopleLimit, perBookingPeopleLimit) ||
                other.perBookingPeopleLimit == perBookingPeopleLimit) &&
            (identical(other.totalPeopleLimit, totalPeopleLimit) ||
                other.totalPeopleLimit == totalPeopleLimit) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.dateRuleType, dateRuleType) ||
                other.dateRuleType == dateRuleType) &&
            (identical(other.bookingLimitType, bookingLimitType) ||
                other.bookingLimitType == bookingLimitType) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        name,
        reservationKey,
        categoryLv1Text,
        categoryLv2Text,
        categoryLv3Text,
        description,
        specification,
        notice,
        durationMinutes,
        startAt,
        endAt,
        cancelTimeRange,
        perBookingPeopleLimit,
        totalPeopleLimit,
        fee,
        paymentType,
        dateRuleType,
        bookingLimitType,
        isPublished,
        const DeepCollectionEquality().hash(_imageUrls)
      ]);

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
          {final String? name,
          @JsonKey(name: 'reservation_key') final String? reservationKey,
          @JsonKey(name: 'category_lv1_text') final String? categoryLv1Text,
          @JsonKey(name: 'category_lv2_text') final String? categoryLv2Text,
          @JsonKey(name: 'category_lv3_text') final String? categoryLv3Text,
          final String? description,
          final String? specification,
          final String? notice,
          @JsonKey(name: 'duration_minutes') final int? durationMinutes,
          @JsonKey(name: 'start_at') final int? startAt,
          @JsonKey(name: 'end_at') final int? endAt,
          @JsonKey(name: 'cancel_time_range') final int? cancelTimeRange,
          @JsonKey(name: 'per_booking_people_limit')
          final int? perBookingPeopleLimit,
          @JsonKey(name: 'total_people_limit') final int? totalPeopleLimit,
          final int? fee,
          @JsonKey(name: 'payment_type') final int? paymentType,
          @JsonKey(name: 'date_rule_type') final int? dateRuleType,
          @JsonKey(name: 'booking_limit_type') final int? bookingLimitType,
          @JsonKey(name: 'is_published') final bool? isPublished,
          @JsonKey(name: 'image_urls') final List<String>? imageUrls}) =
      _$DatumImpl;

  factory _Datum.fromJson(Map<String, dynamic> json) = _$DatumImpl.fromJson;

  @override
  String? get name;
  @override
  @JsonKey(name: 'reservation_key')
  String? get reservationKey;
  @override
  @JsonKey(name: 'category_lv1_text')
  String? get categoryLv1Text;
  @override
  @JsonKey(name: 'category_lv2_text')
  String? get categoryLv2Text;
  @override
  @JsonKey(name: 'category_lv3_text')
  String? get categoryLv3Text;
  @override
  String? get description;
  @override
  String? get specification;
  @override
  String? get notice;
  @override
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes;
  @override
  @JsonKey(name: 'start_at')
  int? get startAt;
  @override
  @JsonKey(name: 'end_at')
  int? get endAt;
  @override
  @JsonKey(name: 'cancel_time_range')
  int? get cancelTimeRange;
  @override
  @JsonKey(name: 'per_booking_people_limit')
  int? get perBookingPeopleLimit;
  @override
  @JsonKey(name: 'total_people_limit')
  int? get totalPeopleLimit;
  @override
  int? get fee;
  @override
  @JsonKey(name: 'payment_type')
  int? get paymentType;
  @override
  @JsonKey(name: 'date_rule_type')
  int? get dateRuleType;
  @override
  @JsonKey(name: 'booking_limit_type')
  int? get bookingLimitType;
  @override
  @JsonKey(name: 'is_published')
  bool? get isPublished;
  @override
  @JsonKey(name: 'image_urls')
  List<String>? get imageUrls;
  @override
  @JsonKey(ignore: true)
  _$$DatumImplCopyWith<_$DatumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
