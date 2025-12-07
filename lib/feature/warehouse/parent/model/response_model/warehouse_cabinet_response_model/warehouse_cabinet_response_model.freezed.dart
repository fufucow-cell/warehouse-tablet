// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_cabinet_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseCabinetResponseModel _$WarehouseCabinetResponseModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseCabinetResponseModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseCabinetResponseModel {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<Cabinet>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseCabinetResponseModelCopyWith<WarehouseCabinetResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseCabinetResponseModelCopyWith<$Res> {
  factory $WarehouseCabinetResponseModelCopyWith(
          WarehouseCabinetResponseModel value,
          $Res Function(WarehouseCabinetResponseModel) then) =
      _$WarehouseCabinetResponseModelCopyWithImpl<$Res,
          WarehouseCabinetResponseModel>;
  @useResult
  $Res call({int? code, String? message, List<Cabinet>? data});
}

/// @nodoc
class _$WarehouseCabinetResponseModelCopyWithImpl<$Res,
        $Val extends WarehouseCabinetResponseModel>
    implements $WarehouseCabinetResponseModelCopyWith<$Res> {
  _$WarehouseCabinetResponseModelCopyWithImpl(this._value, this._then);

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
              as List<Cabinet>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseCabinetResponseModelImplCopyWith<$Res>
    implements $WarehouseCabinetResponseModelCopyWith<$Res> {
  factory _$$WarehouseCabinetResponseModelImplCopyWith(
          _$WarehouseCabinetResponseModelImpl value,
          $Res Function(_$WarehouseCabinetResponseModelImpl) then) =
      __$$WarehouseCabinetResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message, List<Cabinet>? data});
}

/// @nodoc
class __$$WarehouseCabinetResponseModelImplCopyWithImpl<$Res>
    extends _$WarehouseCabinetResponseModelCopyWithImpl<$Res,
        _$WarehouseCabinetResponseModelImpl>
    implements _$$WarehouseCabinetResponseModelImplCopyWith<$Res> {
  __$$WarehouseCabinetResponseModelImplCopyWithImpl(
      _$WarehouseCabinetResponseModelImpl _value,
      $Res Function(_$WarehouseCabinetResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$WarehouseCabinetResponseModelImpl(
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
              as List<Cabinet>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseCabinetResponseModelImpl
    implements _WarehouseCabinetResponseModel {
  _$WarehouseCabinetResponseModelImpl(
      {this.code, this.message, final List<Cabinet>? data})
      : _data = data;

  factory _$WarehouseCabinetResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseCabinetResponseModelImplFromJson(json);

  @override
  final int? code;
  @override
  final String? message;
  final List<Cabinet>? _data;
  @override
  List<Cabinet>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WarehouseCabinetResponseModel(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseCabinetResponseModelImpl &&
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
  _$$WarehouseCabinetResponseModelImplCopyWith<
          _$WarehouseCabinetResponseModelImpl>
      get copyWith => __$$WarehouseCabinetResponseModelImplCopyWithImpl<
          _$WarehouseCabinetResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseCabinetResponseModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseCabinetResponseModel
    implements WarehouseCabinetResponseModel {
  factory _WarehouseCabinetResponseModel(
      {final int? code,
      final String? message,
      final List<Cabinet>? data}) = _$WarehouseCabinetResponseModelImpl;

  factory _WarehouseCabinetResponseModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseCabinetResponseModelImpl.fromJson;

  @override
  int? get code;
  @override
  String? get message;
  @override
  List<Cabinet>? get data;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseCabinetResponseModelImplCopyWith<
          _$WarehouseCabinetResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
