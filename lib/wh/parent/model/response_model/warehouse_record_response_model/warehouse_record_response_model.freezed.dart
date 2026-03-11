// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_record_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseRecordResponseModel _$WarehouseRecordResponseModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseRecordResponseModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseRecordResponseModel {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<ItemRecord>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseRecordResponseModelCopyWith<WarehouseRecordResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseRecordResponseModelCopyWith<$Res> {
  factory $WarehouseRecordResponseModelCopyWith(
          WarehouseRecordResponseModel value,
          $Res Function(WarehouseRecordResponseModel) then) =
      _$WarehouseRecordResponseModelCopyWithImpl<$Res,
          WarehouseRecordResponseModel>;
  @useResult
  $Res call({int? code, String? message, List<ItemRecord>? data});
}

/// @nodoc
class _$WarehouseRecordResponseModelCopyWithImpl<$Res,
        $Val extends WarehouseRecordResponseModel>
    implements $WarehouseRecordResponseModelCopyWith<$Res> {
  _$WarehouseRecordResponseModelCopyWithImpl(this._value, this._then);

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
              as List<ItemRecord>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseRecordResponseModelImplCopyWith<$Res>
    implements $WarehouseRecordResponseModelCopyWith<$Res> {
  factory _$$WarehouseRecordResponseModelImplCopyWith(
          _$WarehouseRecordResponseModelImpl value,
          $Res Function(_$WarehouseRecordResponseModelImpl) then) =
      __$$WarehouseRecordResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message, List<ItemRecord>? data});
}

/// @nodoc
class __$$WarehouseRecordResponseModelImplCopyWithImpl<$Res>
    extends _$WarehouseRecordResponseModelCopyWithImpl<$Res,
        _$WarehouseRecordResponseModelImpl>
    implements _$$WarehouseRecordResponseModelImplCopyWith<$Res> {
  __$$WarehouseRecordResponseModelImplCopyWithImpl(
      _$WarehouseRecordResponseModelImpl _value,
      $Res Function(_$WarehouseRecordResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$WarehouseRecordResponseModelImpl(
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
              as List<ItemRecord>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseRecordResponseModelImpl
    implements _WarehouseRecordResponseModel {
  _$WarehouseRecordResponseModelImpl(
      {this.code, this.message, final List<ItemRecord>? data})
      : _data = data;

  factory _$WarehouseRecordResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseRecordResponseModelImplFromJson(json);

  @override
  final int? code;
  @override
  final String? message;
  final List<ItemRecord>? _data;
  @override
  List<ItemRecord>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WarehouseRecordResponseModel(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseRecordResponseModelImpl &&
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
  _$$WarehouseRecordResponseModelImplCopyWith<
          _$WarehouseRecordResponseModelImpl>
      get copyWith => __$$WarehouseRecordResponseModelImplCopyWithImpl<
          _$WarehouseRecordResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseRecordResponseModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseRecordResponseModel
    implements WarehouseRecordResponseModel {
  factory _WarehouseRecordResponseModel(
      {final int? code,
      final String? message,
      final List<ItemRecord>? data}) = _$WarehouseRecordResponseModelImpl;

  factory _WarehouseRecordResponseModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseRecordResponseModelImpl.fromJson;

  @override
  int? get code;
  @override
  String? get message;
  @override
  List<ItemRecord>? get data;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseRecordResponseModelImplCopyWith<
          _$WarehouseRecordResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
