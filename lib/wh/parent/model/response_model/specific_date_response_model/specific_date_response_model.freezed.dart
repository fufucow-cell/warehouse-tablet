// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'specific_date_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SpecificDateResponseModel _$SpecificDateResponseModelFromJson(
    Map<String, dynamic> json) {
  return _SpecificDateResponseModel.fromJson(json);
}

/// @nodoc
mixin _$SpecificDateResponseModel {
  @JsonKey(name: 'booking_date')
  int? get bookingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_all_day')
  bool? get isAllDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String? get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String? get endTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SpecificDateResponseModelCopyWith<SpecificDateResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpecificDateResponseModelCopyWith<$Res> {
  factory $SpecificDateResponseModelCopyWith(SpecificDateResponseModel value,
          $Res Function(SpecificDateResponseModel) then) =
      _$SpecificDateResponseModelCopyWithImpl<$Res, SpecificDateResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'booking_date') int? bookingDate,
      @JsonKey(name: 'is_all_day') bool? isAllDay,
      @JsonKey(name: 'start_time') String? startTime,
      @JsonKey(name: 'end_time') String? endTime});
}

/// @nodoc
class _$SpecificDateResponseModelCopyWithImpl<$Res,
        $Val extends SpecificDateResponseModel>
    implements $SpecificDateResponseModelCopyWith<$Res> {
  _$SpecificDateResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingDate = freezed,
    Object? isAllDay = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
  }) {
    return _then(_value.copyWith(
      bookingDate: freezed == bookingDate
          ? _value.bookingDate
          : bookingDate // ignore: cast_nullable_to_non_nullable
              as int?,
      isAllDay: freezed == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpecificDateResponseModelImplCopyWith<$Res>
    implements $SpecificDateResponseModelCopyWith<$Res> {
  factory _$$SpecificDateResponseModelImplCopyWith(
          _$SpecificDateResponseModelImpl value,
          $Res Function(_$SpecificDateResponseModelImpl) then) =
      __$$SpecificDateResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'booking_date') int? bookingDate,
      @JsonKey(name: 'is_all_day') bool? isAllDay,
      @JsonKey(name: 'start_time') String? startTime,
      @JsonKey(name: 'end_time') String? endTime});
}

/// @nodoc
class __$$SpecificDateResponseModelImplCopyWithImpl<$Res>
    extends _$SpecificDateResponseModelCopyWithImpl<$Res,
        _$SpecificDateResponseModelImpl>
    implements _$$SpecificDateResponseModelImplCopyWith<$Res> {
  __$$SpecificDateResponseModelImplCopyWithImpl(
      _$SpecificDateResponseModelImpl _value,
      $Res Function(_$SpecificDateResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingDate = freezed,
    Object? isAllDay = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
  }) {
    return _then(_$SpecificDateResponseModelImpl(
      bookingDate: freezed == bookingDate
          ? _value.bookingDate
          : bookingDate // ignore: cast_nullable_to_non_nullable
              as int?,
      isAllDay: freezed == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpecificDateResponseModelImpl implements _SpecificDateResponseModel {
  _$SpecificDateResponseModelImpl(
      {@JsonKey(name: 'booking_date') this.bookingDate,
      @JsonKey(name: 'is_all_day') this.isAllDay,
      @JsonKey(name: 'start_time') this.startTime,
      @JsonKey(name: 'end_time') this.endTime});

  factory _$SpecificDateResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpecificDateResponseModelImplFromJson(json);

  @override
  @JsonKey(name: 'booking_date')
  final int? bookingDate;
  @override
  @JsonKey(name: 'is_all_day')
  final bool? isAllDay;
  @override
  @JsonKey(name: 'start_time')
  final String? startTime;
  @override
  @JsonKey(name: 'end_time')
  final String? endTime;

  @override
  String toString() {
    return 'SpecificDateResponseModel(bookingDate: $bookingDate, isAllDay: $isAllDay, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecificDateResponseModelImpl &&
            (identical(other.bookingDate, bookingDate) ||
                other.bookingDate == bookingDate) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bookingDate, isAllDay, startTime, endTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpecificDateResponseModelImplCopyWith<_$SpecificDateResponseModelImpl>
      get copyWith => __$$SpecificDateResponseModelImplCopyWithImpl<
          _$SpecificDateResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpecificDateResponseModelImplToJson(
      this,
    );
  }
}

abstract class _SpecificDateResponseModel implements SpecificDateResponseModel {
  factory _SpecificDateResponseModel(
          {@JsonKey(name: 'booking_date') final int? bookingDate,
          @JsonKey(name: 'is_all_day') final bool? isAllDay,
          @JsonKey(name: 'start_time') final String? startTime,
          @JsonKey(name: 'end_time') final String? endTime}) =
      _$SpecificDateResponseModelImpl;

  factory _SpecificDateResponseModel.fromJson(Map<String, dynamic> json) =
      _$SpecificDateResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'booking_date')
  int? get bookingDate;
  @override
  @JsonKey(name: 'is_all_day')
  bool? get isAllDay;
  @override
  @JsonKey(name: 'start_time')
  String? get startTime;
  @override
  @JsonKey(name: 'end_time')
  String? get endTime;
  @override
  @JsonKey(ignore: true)
  _$$SpecificDateResponseModelImplCopyWith<_$SpecificDateResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
