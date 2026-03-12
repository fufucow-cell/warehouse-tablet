// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_item_open_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReservationItemOpenResponseModel _$ReservationItemOpenResponseModelFromJson(
    Map<String, dynamic> json) {
  return _ReservationItemOpenResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ReservationItemOpenResponseModel {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<Datum>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservationItemOpenResponseModelCopyWith<ReservationItemOpenResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationItemOpenResponseModelCopyWith<$Res> {
  factory $ReservationItemOpenResponseModelCopyWith(
          ReservationItemOpenResponseModel value,
          $Res Function(ReservationItemOpenResponseModel) then) =
      _$ReservationItemOpenResponseModelCopyWithImpl<$Res,
          ReservationItemOpenResponseModel>;
  @useResult
  $Res call({int? code, String? message, List<Datum>? data});
}

/// @nodoc
class _$ReservationItemOpenResponseModelCopyWithImpl<$Res,
        $Val extends ReservationItemOpenResponseModel>
    implements $ReservationItemOpenResponseModelCopyWith<$Res> {
  _$ReservationItemOpenResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Datum>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationItemOpenResponseModelImplCopyWith<$Res>
    implements $ReservationItemOpenResponseModelCopyWith<$Res> {
  factory _$$ReservationItemOpenResponseModelImplCopyWith(
          _$ReservationItemOpenResponseModelImpl value,
          $Res Function(_$ReservationItemOpenResponseModelImpl) then) =
      __$$ReservationItemOpenResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message, List<Datum>? data});
}

/// @nodoc
class __$$ReservationItemOpenResponseModelImplCopyWithImpl<$Res>
    extends _$ReservationItemOpenResponseModelCopyWithImpl<$Res,
        _$ReservationItemOpenResponseModelImpl>
    implements _$$ReservationItemOpenResponseModelImplCopyWith<$Res> {
  __$$ReservationItemOpenResponseModelImplCopyWithImpl(
      _$ReservationItemOpenResponseModelImpl _value,
      $Res Function(_$ReservationItemOpenResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ReservationItemOpenResponseModelImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Datum>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReservationItemOpenResponseModelImpl
    implements _ReservationItemOpenResponseModel {
  _$ReservationItemOpenResponseModelImpl(
      {this.code, this.message, final List<Datum>? data})
      : _data = data;

  factory _$ReservationItemOpenResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReservationItemOpenResponseModelImplFromJson(json);

  @override
  final int? code;
  @override
  final String? message;
  final List<Datum>? _data;
  @override
  List<Datum>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ReservationItemOpenResponseModel(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationItemOpenResponseModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, message, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationItemOpenResponseModelImplCopyWith<
          _$ReservationItemOpenResponseModelImpl>
      get copyWith => __$$ReservationItemOpenResponseModelImplCopyWithImpl<
          _$ReservationItemOpenResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationItemOpenResponseModelImplToJson(
      this,
    );
  }
}

abstract class _ReservationItemOpenResponseModel
    implements ReservationItemOpenResponseModel {
  factory _ReservationItemOpenResponseModel(
      {final int? code,
      final String? message,
      final List<Datum>? data}) = _$ReservationItemOpenResponseModelImpl;

  factory _ReservationItemOpenResponseModel.fromJson(
          Map<String, dynamic> json) =
      _$ReservationItemOpenResponseModelImpl.fromJson;

  @override
  int? get code;
  @override
  String? get message;
  @override
  List<Datum>? get data;
  @override
  @JsonKey(ignore: true)
  _$$ReservationItemOpenResponseModelImplCopyWith<
          _$ReservationItemOpenResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
