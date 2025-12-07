// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_item_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseItemResponseModel _$WarehouseItemResponseModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseItemResponseModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseItemResponseModel {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<Item>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseItemResponseModelCopyWith<WarehouseItemResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseItemResponseModelCopyWith<$Res> {
  factory $WarehouseItemResponseModelCopyWith(WarehouseItemResponseModel value,
          $Res Function(WarehouseItemResponseModel) then) =
      _$WarehouseItemResponseModelCopyWithImpl<$Res,
          WarehouseItemResponseModel>;
  @useResult
  $Res call({int? code, String? message, List<Item>? data});
}

/// @nodoc
class _$WarehouseItemResponseModelCopyWithImpl<$Res,
        $Val extends WarehouseItemResponseModel>
    implements $WarehouseItemResponseModelCopyWith<$Res> {
  _$WarehouseItemResponseModelCopyWithImpl(this._value, this._then);

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
              as List<Item>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseItemResponseModelImplCopyWith<$Res>
    implements $WarehouseItemResponseModelCopyWith<$Res> {
  factory _$$WarehouseItemResponseModelImplCopyWith(
          _$WarehouseItemResponseModelImpl value,
          $Res Function(_$WarehouseItemResponseModelImpl) then) =
      __$$WarehouseItemResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message, List<Item>? data});
}

/// @nodoc
class __$$WarehouseItemResponseModelImplCopyWithImpl<$Res>
    extends _$WarehouseItemResponseModelCopyWithImpl<$Res,
        _$WarehouseItemResponseModelImpl>
    implements _$$WarehouseItemResponseModelImplCopyWith<$Res> {
  __$$WarehouseItemResponseModelImplCopyWithImpl(
      _$WarehouseItemResponseModelImpl _value,
      $Res Function(_$WarehouseItemResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$WarehouseItemResponseModelImpl(
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
              as List<Item>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseItemResponseModelImpl implements _WarehouseItemResponseModel {
  _$WarehouseItemResponseModelImpl(
      {this.code, this.message, final List<Item>? data})
      : _data = data;

  factory _$WarehouseItemResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseItemResponseModelImplFromJson(json);

  @override
  final int? code;
  @override
  final String? message;
  final List<Item>? _data;
  @override
  List<Item>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WarehouseItemResponseModel(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseItemResponseModelImpl &&
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
  _$$WarehouseItemResponseModelImplCopyWith<_$WarehouseItemResponseModelImpl>
      get copyWith => __$$WarehouseItemResponseModelImplCopyWithImpl<
          _$WarehouseItemResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseItemResponseModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseItemResponseModel
    implements WarehouseItemResponseModel {
  factory _WarehouseItemResponseModel(
      {final int? code,
      final String? message,
      final List<Item>? data}) = _$WarehouseItemResponseModelImpl;

  factory _WarehouseItemResponseModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseItemResponseModelImpl.fromJson;

  @override
  int? get code;
  @override
  String? get message;
  @override
  List<Item>? get data;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseItemResponseModelImplCopyWith<_$WarehouseItemResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
