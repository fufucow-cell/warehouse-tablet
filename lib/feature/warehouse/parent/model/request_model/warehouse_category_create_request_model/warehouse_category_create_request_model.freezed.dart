// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_category_create_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseCategoryCreateRequestModel
    _$WarehouseCategoryCreateRequestModelFromJson(Map<String, dynamic> json) {
  return _WarehouseCategoryCreateRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseCategoryCreateRequestModel {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'household_id')
  String get homeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_id')
  String? get parentId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseCategoryCreateRequestModelCopyWith<
          WarehouseCategoryCreateRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseCategoryCreateRequestModelCopyWith<$Res> {
  factory $WarehouseCategoryCreateRequestModelCopyWith(
          WarehouseCategoryCreateRequestModel value,
          $Res Function(WarehouseCategoryCreateRequestModel) then) =
      _$WarehouseCategoryCreateRequestModelCopyWithImpl<$Res,
          WarehouseCategoryCreateRequestModel>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'household_id') String homeId,
      @JsonKey(name: 'parent_id') String? parentId});
}

/// @nodoc
class _$WarehouseCategoryCreateRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseCategoryCreateRequestModel>
    implements $WarehouseCategoryCreateRequestModelCopyWith<$Res> {
  _$WarehouseCategoryCreateRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? homeId = null,
    Object? parentId = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      homeId: null == homeId
          ? _value.homeId
          : homeId // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseCategoryCreateRequestModelImplCopyWith<$Res>
    implements $WarehouseCategoryCreateRequestModelCopyWith<$Res> {
  factory _$$WarehouseCategoryCreateRequestModelImplCopyWith(
          _$WarehouseCategoryCreateRequestModelImpl value,
          $Res Function(_$WarehouseCategoryCreateRequestModelImpl) then) =
      __$$WarehouseCategoryCreateRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'household_id') String homeId,
      @JsonKey(name: 'parent_id') String? parentId});
}

/// @nodoc
class __$$WarehouseCategoryCreateRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseCategoryCreateRequestModelCopyWithImpl<$Res,
        _$WarehouseCategoryCreateRequestModelImpl>
    implements _$$WarehouseCategoryCreateRequestModelImplCopyWith<$Res> {
  __$$WarehouseCategoryCreateRequestModelImplCopyWithImpl(
      _$WarehouseCategoryCreateRequestModelImpl _value,
      $Res Function(_$WarehouseCategoryCreateRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? homeId = null,
    Object? parentId = freezed,
  }) {
    return _then(_$WarehouseCategoryCreateRequestModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      homeId: null == homeId
          ? _value.homeId
          : homeId // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseCategoryCreateRequestModelImpl
    implements _WarehouseCategoryCreateRequestModel {
  _$WarehouseCategoryCreateRequestModelImpl(
      {required this.name,
      @JsonKey(name: 'household_id') required this.homeId,
      @JsonKey(name: 'parent_id') this.parentId});

  factory _$WarehouseCategoryCreateRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseCategoryCreateRequestModelImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'household_id')
  final String homeId;
  @override
  @JsonKey(name: 'parent_id')
  final String? parentId;

  @override
  String toString() {
    return 'WarehouseCategoryCreateRequestModel(name: $name, homeId: $homeId, parentId: $parentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseCategoryCreateRequestModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.homeId, homeId) || other.homeId == homeId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, homeId, parentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseCategoryCreateRequestModelImplCopyWith<
          _$WarehouseCategoryCreateRequestModelImpl>
      get copyWith => __$$WarehouseCategoryCreateRequestModelImplCopyWithImpl<
          _$WarehouseCategoryCreateRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseCategoryCreateRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseCategoryCreateRequestModel
    implements WarehouseCategoryCreateRequestModel {
  factory _WarehouseCategoryCreateRequestModel(
          {required final String name,
          @JsonKey(name: 'household_id') required final String homeId,
          @JsonKey(name: 'parent_id') final String? parentId}) =
      _$WarehouseCategoryCreateRequestModelImpl;

  factory _WarehouseCategoryCreateRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$WarehouseCategoryCreateRequestModelImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'household_id')
  String get homeId;
  @override
  @JsonKey(name: 'parent_id')
  String? get parentId;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseCategoryCreateRequestModelImplCopyWith<
          _$WarehouseCategoryCreateRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
