// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_category_update_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseCategoryUpdateRequestModel
    _$WarehouseCategoryUpdateRequestModelFromJson(Map<String, dynamic> json) {
  return _WarehouseCategoryUpdateRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseCategoryUpdateRequestModel {
  @JsonKey(name: 'household_id')
  String get homeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_id')
  String? get parentId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseCategoryUpdateRequestModelCopyWith<
          WarehouseCategoryUpdateRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseCategoryUpdateRequestModelCopyWith<$Res> {
  factory $WarehouseCategoryUpdateRequestModelCopyWith(
          WarehouseCategoryUpdateRequestModel value,
          $Res Function(WarehouseCategoryUpdateRequestModel) then) =
      _$WarehouseCategoryUpdateRequestModelCopyWithImpl<$Res,
          WarehouseCategoryUpdateRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String homeId,
      @JsonKey(name: 'category_id') String categoryId,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'parent_id') String? parentId});
}

/// @nodoc
class _$WarehouseCategoryUpdateRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseCategoryUpdateRequestModel>
    implements $WarehouseCategoryUpdateRequestModelCopyWith<$Res> {
  _$WarehouseCategoryUpdateRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeId = null,
    Object? categoryId = null,
    Object? name = null,
    Object? parentId = freezed,
  }) {
    return _then(_value.copyWith(
      homeId: null == homeId
          ? _value.homeId
          : homeId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseCategoryUpdateRequestModelImplCopyWith<$Res>
    implements $WarehouseCategoryUpdateRequestModelCopyWith<$Res> {
  factory _$$WarehouseCategoryUpdateRequestModelImplCopyWith(
          _$WarehouseCategoryUpdateRequestModelImpl value,
          $Res Function(_$WarehouseCategoryUpdateRequestModelImpl) then) =
      __$$WarehouseCategoryUpdateRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String homeId,
      @JsonKey(name: 'category_id') String categoryId,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'parent_id') String? parentId});
}

/// @nodoc
class __$$WarehouseCategoryUpdateRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseCategoryUpdateRequestModelCopyWithImpl<$Res,
        _$WarehouseCategoryUpdateRequestModelImpl>
    implements _$$WarehouseCategoryUpdateRequestModelImplCopyWith<$Res> {
  __$$WarehouseCategoryUpdateRequestModelImplCopyWithImpl(
      _$WarehouseCategoryUpdateRequestModelImpl _value,
      $Res Function(_$WarehouseCategoryUpdateRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeId = null,
    Object? categoryId = null,
    Object? name = null,
    Object? parentId = freezed,
  }) {
    return _then(_$WarehouseCategoryUpdateRequestModelImpl(
      homeId: null == homeId
          ? _value.homeId
          : homeId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
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
class _$WarehouseCategoryUpdateRequestModelImpl
    implements _WarehouseCategoryUpdateRequestModel {
  _$WarehouseCategoryUpdateRequestModelImpl(
      {@JsonKey(name: 'household_id') required this.homeId,
      @JsonKey(name: 'category_id') required this.categoryId,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'parent_id') this.parentId});

  factory _$WarehouseCategoryUpdateRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseCategoryUpdateRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'household_id')
  final String homeId;
  @override
  @JsonKey(name: 'category_id')
  final String categoryId;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'parent_id')
  final String? parentId;

  @override
  String toString() {
    return 'WarehouseCategoryUpdateRequestModel(homeId: $homeId, categoryId: $categoryId, name: $name, parentId: $parentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseCategoryUpdateRequestModelImpl &&
            (identical(other.homeId, homeId) || other.homeId == homeId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, homeId, categoryId, name, parentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseCategoryUpdateRequestModelImplCopyWith<
          _$WarehouseCategoryUpdateRequestModelImpl>
      get copyWith => __$$WarehouseCategoryUpdateRequestModelImplCopyWithImpl<
          _$WarehouseCategoryUpdateRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseCategoryUpdateRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseCategoryUpdateRequestModel
    implements WarehouseCategoryUpdateRequestModel {
  factory _WarehouseCategoryUpdateRequestModel(
          {@JsonKey(name: 'household_id') required final String homeId,
          @JsonKey(name: 'category_id') required final String categoryId,
          @JsonKey(name: 'name') required final String name,
          @JsonKey(name: 'parent_id') final String? parentId}) =
      _$WarehouseCategoryUpdateRequestModelImpl;

  factory _WarehouseCategoryUpdateRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$WarehouseCategoryUpdateRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'household_id')
  String get homeId;
  @override
  @JsonKey(name: 'category_id')
  String get categoryId;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'parent_id')
  String? get parentId;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseCategoryUpdateRequestModelImplCopyWith<
          _$WarehouseCategoryUpdateRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
