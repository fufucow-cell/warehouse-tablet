// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_category_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseCategoryRequestModel _$WarehouseCategoryRequestModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseCategoryRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseCategoryRequestModel {
  @JsonKey(name: 'household_id')
  String? get homeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_id')
  String? get parentId => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseCategoryRequestModelCopyWith<WarehouseCategoryRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseCategoryRequestModelCopyWith<$Res> {
  factory $WarehouseCategoryRequestModelCopyWith(
          WarehouseCategoryRequestModel value,
          $Res Function(WarehouseCategoryRequestModel) then) =
      _$WarehouseCategoryRequestModelCopyWithImpl<$Res,
          WarehouseCategoryRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? homeId,
      @JsonKey(name: 'category_id') String? categoryId,
      @JsonKey(name: 'parent_id') String? parentId,
      int? level});
}

/// @nodoc
class _$WarehouseCategoryRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseCategoryRequestModel>
    implements $WarehouseCategoryRequestModelCopyWith<$Res> {
  _$WarehouseCategoryRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeId = freezed,
    Object? categoryId = freezed,
    Object? parentId = freezed,
    Object? level = freezed,
  }) {
    return _then(_value.copyWith(
      homeId: freezed == homeId
          ? _value.homeId
          : homeId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseCategoryRequestModelImplCopyWith<$Res>
    implements $WarehouseCategoryRequestModelCopyWith<$Res> {
  factory _$$WarehouseCategoryRequestModelImplCopyWith(
          _$WarehouseCategoryRequestModelImpl value,
          $Res Function(_$WarehouseCategoryRequestModelImpl) then) =
      __$$WarehouseCategoryRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? homeId,
      @JsonKey(name: 'category_id') String? categoryId,
      @JsonKey(name: 'parent_id') String? parentId,
      int? level});
}

/// @nodoc
class __$$WarehouseCategoryRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseCategoryRequestModelCopyWithImpl<$Res,
        _$WarehouseCategoryRequestModelImpl>
    implements _$$WarehouseCategoryRequestModelImplCopyWith<$Res> {
  __$$WarehouseCategoryRequestModelImplCopyWithImpl(
      _$WarehouseCategoryRequestModelImpl _value,
      $Res Function(_$WarehouseCategoryRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeId = freezed,
    Object? categoryId = freezed,
    Object? parentId = freezed,
    Object? level = freezed,
  }) {
    return _then(_$WarehouseCategoryRequestModelImpl(
      homeId: freezed == homeId
          ? _value.homeId
          : homeId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseCategoryRequestModelImpl
    implements _WarehouseCategoryRequestModel {
  _$WarehouseCategoryRequestModelImpl(
      {@JsonKey(name: 'household_id') this.homeId,
      @JsonKey(name: 'category_id') this.categoryId,
      @JsonKey(name: 'parent_id') this.parentId,
      this.level});

  factory _$WarehouseCategoryRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseCategoryRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'household_id')
  final String? homeId;
  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  @JsonKey(name: 'parent_id')
  final String? parentId;
  @override
  final int? level;

  @override
  String toString() {
    return 'WarehouseCategoryRequestModel(homeId: $homeId, categoryId: $categoryId, parentId: $parentId, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseCategoryRequestModelImpl &&
            (identical(other.homeId, homeId) || other.homeId == homeId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, homeId, categoryId, parentId, level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseCategoryRequestModelImplCopyWith<
          _$WarehouseCategoryRequestModelImpl>
      get copyWith => __$$WarehouseCategoryRequestModelImplCopyWithImpl<
          _$WarehouseCategoryRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseCategoryRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseCategoryRequestModel
    implements WarehouseCategoryRequestModel {
  factory _WarehouseCategoryRequestModel(
      {@JsonKey(name: 'household_id') final String? homeId,
      @JsonKey(name: 'category_id') final String? categoryId,
      @JsonKey(name: 'parent_id') final String? parentId,
      final int? level}) = _$WarehouseCategoryRequestModelImpl;

  factory _WarehouseCategoryRequestModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseCategoryRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'household_id')
  String? get homeId;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  @JsonKey(name: 'parent_id')
  String? get parentId;
  @override
  int? get level;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseCategoryRequestModelImplCopyWith<
          _$WarehouseCategoryRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
