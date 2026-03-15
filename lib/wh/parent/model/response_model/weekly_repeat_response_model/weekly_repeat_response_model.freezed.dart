// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_repeat_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeeklyRepeatResponseModel _$WeeklyRepeatResponseModelFromJson(
    Map<String, dynamic> json) {
  return _WeeklyRepeatResponseModel.fromJson(json);
}

/// @nodoc
mixin _$WeeklyRepeatResponseModel {
  int? get day => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_enable')
  bool? get isEnable => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_all_day')
  bool? get isAllDay => throw _privateConstructorUsedError;
  List<Period>? get period => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeeklyRepeatResponseModelCopyWith<WeeklyRepeatResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyRepeatResponseModelCopyWith<$Res> {
  factory $WeeklyRepeatResponseModelCopyWith(WeeklyRepeatResponseModel value,
          $Res Function(WeeklyRepeatResponseModel) then) =
      _$WeeklyRepeatResponseModelCopyWithImpl<$Res, WeeklyRepeatResponseModel>;
  @useResult
  $Res call(
      {int? day,
      @JsonKey(name: 'is_enable') bool? isEnable,
      @JsonKey(name: 'is_all_day') bool? isAllDay,
      List<Period>? period});
}

/// @nodoc
class _$WeeklyRepeatResponseModelCopyWithImpl<$Res,
        $Val extends WeeklyRepeatResponseModel>
    implements $WeeklyRepeatResponseModelCopyWith<$Res> {
  _$WeeklyRepeatResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = freezed,
    Object? isEnable = freezed,
    Object? isAllDay = freezed,
    Object? period = freezed,
  }) {
    return _then(_value.copyWith(
      day: freezed == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int?,
      isEnable: freezed == isEnable
          ? _value.isEnable
          : isEnable // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAllDay: freezed == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool?,
      period: freezed == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as List<Period>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeeklyRepeatResponseModelImplCopyWith<$Res>
    implements $WeeklyRepeatResponseModelCopyWith<$Res> {
  factory _$$WeeklyRepeatResponseModelImplCopyWith(
          _$WeeklyRepeatResponseModelImpl value,
          $Res Function(_$WeeklyRepeatResponseModelImpl) then) =
      __$$WeeklyRepeatResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? day,
      @JsonKey(name: 'is_enable') bool? isEnable,
      @JsonKey(name: 'is_all_day') bool? isAllDay,
      List<Period>? period});
}

/// @nodoc
class __$$WeeklyRepeatResponseModelImplCopyWithImpl<$Res>
    extends _$WeeklyRepeatResponseModelCopyWithImpl<$Res,
        _$WeeklyRepeatResponseModelImpl>
    implements _$$WeeklyRepeatResponseModelImplCopyWith<$Res> {
  __$$WeeklyRepeatResponseModelImplCopyWithImpl(
      _$WeeklyRepeatResponseModelImpl _value,
      $Res Function(_$WeeklyRepeatResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = freezed,
    Object? isEnable = freezed,
    Object? isAllDay = freezed,
    Object? period = freezed,
  }) {
    return _then(_$WeeklyRepeatResponseModelImpl(
      day: freezed == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int?,
      isEnable: freezed == isEnable
          ? _value.isEnable
          : isEnable // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAllDay: freezed == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool?,
      period: freezed == period
          ? _value._period
          : period // ignore: cast_nullable_to_non_nullable
              as List<Period>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklyRepeatResponseModelImpl implements _WeeklyRepeatResponseModel {
  _$WeeklyRepeatResponseModelImpl(
      {this.day,
      @JsonKey(name: 'is_enable') this.isEnable,
      @JsonKey(name: 'is_all_day') this.isAllDay,
      final List<Period>? period})
      : _period = period;

  factory _$WeeklyRepeatResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyRepeatResponseModelImplFromJson(json);

  @override
  final int? day;
  @override
  @JsonKey(name: 'is_enable')
  final bool? isEnable;
  @override
  @JsonKey(name: 'is_all_day')
  final bool? isAllDay;
  final List<Period>? _period;
  @override
  List<Period>? get period {
    final value = _period;
    if (value == null) return null;
    if (_period is EqualUnmodifiableListView) return _period;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WeeklyRepeatResponseModel(day: $day, isEnable: $isEnable, isAllDay: $isAllDay, period: $period)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyRepeatResponseModelImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.isEnable, isEnable) ||
                other.isEnable == isEnable) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            const DeepCollectionEquality().equals(other._period, _period));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, day, isEnable, isAllDay,
      const DeepCollectionEquality().hash(_period));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyRepeatResponseModelImplCopyWith<_$WeeklyRepeatResponseModelImpl>
      get copyWith => __$$WeeklyRepeatResponseModelImplCopyWithImpl<
          _$WeeklyRepeatResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyRepeatResponseModelImplToJson(
      this,
    );
  }
}

abstract class _WeeklyRepeatResponseModel implements WeeklyRepeatResponseModel {
  factory _WeeklyRepeatResponseModel(
      {final int? day,
      @JsonKey(name: 'is_enable') final bool? isEnable,
      @JsonKey(name: 'is_all_day') final bool? isAllDay,
      final List<Period>? period}) = _$WeeklyRepeatResponseModelImpl;

  factory _WeeklyRepeatResponseModel.fromJson(Map<String, dynamic> json) =
      _$WeeklyRepeatResponseModelImpl.fromJson;

  @override
  int? get day;
  @override
  @JsonKey(name: 'is_enable')
  bool? get isEnable;
  @override
  @JsonKey(name: 'is_all_day')
  bool? get isAllDay;
  @override
  List<Period>? get period;
  @override
  @JsonKey(ignore: true)
  _$$WeeklyRepeatResponseModelImplCopyWith<_$WeeklyRepeatResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
