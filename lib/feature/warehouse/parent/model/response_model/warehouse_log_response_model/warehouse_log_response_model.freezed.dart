// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_log_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseLogResponseModel _$WarehouseLogResponseModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseLogResponseModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseLogResponseModel {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<Log>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseLogResponseModelCopyWith<WarehouseLogResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseLogResponseModelCopyWith<$Res> {
  factory $WarehouseLogResponseModelCopyWith(WarehouseLogResponseModel value,
          $Res Function(WarehouseLogResponseModel) then) =
      _$WarehouseLogResponseModelCopyWithImpl<$Res, WarehouseLogResponseModel>;
  @useResult
  $Res call({int? code, String? message, List<Log>? data});
}

/// @nodoc
class _$WarehouseLogResponseModelCopyWithImpl<$Res,
        $Val extends WarehouseLogResponseModel>
    implements $WarehouseLogResponseModelCopyWith<$Res> {
  _$WarehouseLogResponseModelCopyWithImpl(this._value, this._then);

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
              as List<Log>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseLogResponseModelImplCopyWith<$Res>
    implements $WarehouseLogResponseModelCopyWith<$Res> {
  factory _$$WarehouseLogResponseModelImplCopyWith(
          _$WarehouseLogResponseModelImpl value,
          $Res Function(_$WarehouseLogResponseModelImpl) then) =
      __$$WarehouseLogResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message, List<Log>? data});
}

/// @nodoc
class __$$WarehouseLogResponseModelImplCopyWithImpl<$Res>
    extends _$WarehouseLogResponseModelCopyWithImpl<$Res,
        _$WarehouseLogResponseModelImpl>
    implements _$$WarehouseLogResponseModelImplCopyWith<$Res> {
  __$$WarehouseLogResponseModelImplCopyWithImpl(
      _$WarehouseLogResponseModelImpl _value,
      $Res Function(_$WarehouseLogResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$WarehouseLogResponseModelImpl(
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
              as List<Log>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseLogResponseModelImpl implements _WarehouseLogResponseModel {
  _$WarehouseLogResponseModelImpl(
      {this.code, this.message, final List<Log>? data})
      : _data = data;

  factory _$WarehouseLogResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WarehouseLogResponseModelImplFromJson(json);

  @override
  final int? code;
  @override
  final String? message;
  final List<Log>? _data;
  @override
  List<Log>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WarehouseLogResponseModel(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseLogResponseModelImpl &&
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
  _$$WarehouseLogResponseModelImplCopyWith<_$WarehouseLogResponseModelImpl>
      get copyWith => __$$WarehouseLogResponseModelImplCopyWithImpl<
          _$WarehouseLogResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseLogResponseModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseLogResponseModel implements WarehouseLogResponseModel {
  factory _WarehouseLogResponseModel(
      {final int? code,
      final String? message,
      final List<Log>? data}) = _$WarehouseLogResponseModelImpl;

  factory _WarehouseLogResponseModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseLogResponseModelImpl.fromJson;

  @override
  int? get code;
  @override
  String? get message;
  @override
  List<Log>? get data;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseLogResponseModelImplCopyWith<_$WarehouseLogResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
