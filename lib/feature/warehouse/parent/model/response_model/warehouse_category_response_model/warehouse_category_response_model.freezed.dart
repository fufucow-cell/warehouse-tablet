// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_category_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseCategoryResponseModel _$WarehouseCategoryResponseModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseCategoryResponseModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseCategoryResponseModel {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<Category>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseCategoryResponseModelCopyWith<WarehouseCategoryResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseCategoryResponseModelCopyWith<$Res> {
  factory $WarehouseCategoryResponseModelCopyWith(
          WarehouseCategoryResponseModel value,
          $Res Function(WarehouseCategoryResponseModel) then) =
      _$WarehouseCategoryResponseModelCopyWithImpl<$Res,
          WarehouseCategoryResponseModel>;
  @useResult
  $Res call({int? code, String? message, List<Category>? data});
}

/// @nodoc
class _$WarehouseCategoryResponseModelCopyWithImpl<$Res,
        $Val extends WarehouseCategoryResponseModel>
    implements $WarehouseCategoryResponseModelCopyWith<$Res> {
  _$WarehouseCategoryResponseModelCopyWithImpl(this._value, this._then);

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
              as List<Category>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseCategoryResponseModelImplCopyWith<$Res>
    implements $WarehouseCategoryResponseModelCopyWith<$Res> {
  factory _$$WarehouseCategoryResponseModelImplCopyWith(
          _$WarehouseCategoryResponseModelImpl value,
          $Res Function(_$WarehouseCategoryResponseModelImpl) then) =
      __$$WarehouseCategoryResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message, List<Category>? data});
}

/// @nodoc
class __$$WarehouseCategoryResponseModelImplCopyWithImpl<$Res>
    extends _$WarehouseCategoryResponseModelCopyWithImpl<$Res,
        _$WarehouseCategoryResponseModelImpl>
    implements _$$WarehouseCategoryResponseModelImplCopyWith<$Res> {
  __$$WarehouseCategoryResponseModelImplCopyWithImpl(
      _$WarehouseCategoryResponseModelImpl _value,
      $Res Function(_$WarehouseCategoryResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$WarehouseCategoryResponseModelImpl(
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
              as List<Category>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseCategoryResponseModelImpl
    implements _WarehouseCategoryResponseModel {
  _$WarehouseCategoryResponseModelImpl(
      {this.code, this.message, final List<Category>? data})
      : _data = data;

  factory _$WarehouseCategoryResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseCategoryResponseModelImplFromJson(json);

  @override
  final int? code;
  @override
  final String? message;
  final List<Category>? _data;
  @override
  List<Category>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WarehouseCategoryResponseModel(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseCategoryResponseModelImpl &&
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
  _$$WarehouseCategoryResponseModelImplCopyWith<
          _$WarehouseCategoryResponseModelImpl>
      get copyWith => __$$WarehouseCategoryResponseModelImplCopyWithImpl<
          _$WarehouseCategoryResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseCategoryResponseModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseCategoryResponseModel
    implements WarehouseCategoryResponseModel {
  factory _WarehouseCategoryResponseModel(
      {final int? code,
      final String? message,
      final List<Category>? data}) = _$WarehouseCategoryResponseModelImpl;

  factory _WarehouseCategoryResponseModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseCategoryResponseModelImpl.fromJson;

  @override
  int? get code;
  @override
  String? get message;
  @override
  List<Category>? get data;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseCategoryResponseModelImplCopyWith<
          _$WarehouseCategoryResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
