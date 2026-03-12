// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_item_record_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReservationItemRecordResponseModel _$ReservationItemRecordResponseModelFromJson(
    Map<String, dynamic> json) {
  return _ReservationItemRecordResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ReservationItemRecordResponseModel {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<Datum>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservationItemRecordResponseModelCopyWith<
          ReservationItemRecordResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationItemRecordResponseModelCopyWith<$Res> {
  factory $ReservationItemRecordResponseModelCopyWith(
          ReservationItemRecordResponseModel value,
          $Res Function(ReservationItemRecordResponseModel) then) =
      _$ReservationItemRecordResponseModelCopyWithImpl<$Res,
          ReservationItemRecordResponseModel>;
  @useResult
  $Res call({int? code, String? message, List<Datum>? data});
}

/// @nodoc
class _$ReservationItemRecordResponseModelCopyWithImpl<$Res,
        $Val extends ReservationItemRecordResponseModel>
    implements $ReservationItemRecordResponseModelCopyWith<$Res> {
  _$ReservationItemRecordResponseModelCopyWithImpl(this._value, this._then);

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
abstract class _$$ReservationItemRecordResponseModelImplCopyWith<$Res>
    implements $ReservationItemRecordResponseModelCopyWith<$Res> {
  factory _$$ReservationItemRecordResponseModelImplCopyWith(
          _$ReservationItemRecordResponseModelImpl value,
          $Res Function(_$ReservationItemRecordResponseModelImpl) then) =
      __$$ReservationItemRecordResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message, List<Datum>? data});
}

/// @nodoc
class __$$ReservationItemRecordResponseModelImplCopyWithImpl<$Res>
    extends _$ReservationItemRecordResponseModelCopyWithImpl<$Res,
        _$ReservationItemRecordResponseModelImpl>
    implements _$$ReservationItemRecordResponseModelImplCopyWith<$Res> {
  __$$ReservationItemRecordResponseModelImplCopyWithImpl(
      _$ReservationItemRecordResponseModelImpl _value,
      $Res Function(_$ReservationItemRecordResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ReservationItemRecordResponseModelImpl(
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
class _$ReservationItemRecordResponseModelImpl
    implements _ReservationItemRecordResponseModel {
  _$ReservationItemRecordResponseModelImpl(
      {this.code, this.message, final List<Datum>? data})
      : _data = data;

  factory _$ReservationItemRecordResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReservationItemRecordResponseModelImplFromJson(json);

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
    return 'ReservationItemRecordResponseModel(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationItemRecordResponseModelImpl &&
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
  _$$ReservationItemRecordResponseModelImplCopyWith<
          _$ReservationItemRecordResponseModelImpl>
      get copyWith => __$$ReservationItemRecordResponseModelImplCopyWithImpl<
          _$ReservationItemRecordResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationItemRecordResponseModelImplToJson(
      this,
    );
  }
}

abstract class _ReservationItemRecordResponseModel
    implements ReservationItemRecordResponseModel {
  factory _ReservationItemRecordResponseModel(
      {final int? code,
      final String? message,
      final List<Datum>? data}) = _$ReservationItemRecordResponseModelImpl;

  factory _ReservationItemRecordResponseModel.fromJson(
          Map<String, dynamic> json) =
      _$ReservationItemRecordResponseModelImpl.fromJson;

  @override
  int? get code;
  @override
  String? get message;
  @override
  List<Datum>? get data;
  @override
  @JsonKey(ignore: true)
  _$$ReservationItemRecordResponseModelImplCopyWith<
          _$ReservationItemRecordResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
