// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_category_read_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseCategoryReadRequestModel _$WarehouseCategoryReadRequestModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseCategoryReadRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseCategoryReadRequestModel {
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseCategoryReadRequestModelCopyWith<WarehouseCategoryReadRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseCategoryReadRequestModelCopyWith<$Res> {
  factory $WarehouseCategoryReadRequestModelCopyWith(
          WarehouseCategoryReadRequestModel value,
          $Res Function(WarehouseCategoryReadRequestModel) then) =
      _$WarehouseCategoryReadRequestModelCopyWithImpl<$Res,
          WarehouseCategoryReadRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'category_id') String? categoryId});
}

/// @nodoc
class _$WarehouseCategoryReadRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseCategoryReadRequestModel>
    implements $WarehouseCategoryReadRequestModelCopyWith<$Res> {
  _$WarehouseCategoryReadRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_value.copyWith(
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseCategoryReadRequestModelImplCopyWith<$Res>
    implements $WarehouseCategoryReadRequestModelCopyWith<$Res> {
  factory _$$WarehouseCategoryReadRequestModelImplCopyWith(
          _$WarehouseCategoryReadRequestModelImpl value,
          $Res Function(_$WarehouseCategoryReadRequestModelImpl) then) =
      __$$WarehouseCategoryReadRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'category_id') String? categoryId});
}

/// @nodoc
class __$$WarehouseCategoryReadRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseCategoryReadRequestModelCopyWithImpl<$Res,
        _$WarehouseCategoryReadRequestModelImpl>
    implements _$$WarehouseCategoryReadRequestModelImplCopyWith<$Res> {
  __$$WarehouseCategoryReadRequestModelImplCopyWithImpl(
      _$WarehouseCategoryReadRequestModelImpl _value,
      $Res Function(_$WarehouseCategoryReadRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_$WarehouseCategoryReadRequestModelImpl(
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseCategoryReadRequestModelImpl
    implements _WarehouseCategoryReadRequestModel {
  _$WarehouseCategoryReadRequestModelImpl(
      {@JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'category_id') this.categoryId});

  factory _$WarehouseCategoryReadRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseCategoryReadRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;

  @override
  String toString() {
    return 'WarehouseCategoryReadRequestModel(householdId: $householdId, categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseCategoryReadRequestModelImpl &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, householdId, categoryId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseCategoryReadRequestModelImplCopyWith<
          _$WarehouseCategoryReadRequestModelImpl>
      get copyWith => __$$WarehouseCategoryReadRequestModelImplCopyWithImpl<
          _$WarehouseCategoryReadRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseCategoryReadRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseCategoryReadRequestModel
    implements WarehouseCategoryReadRequestModel {
  factory _WarehouseCategoryReadRequestModel(
          {@JsonKey(name: 'household_id') final String? householdId,
          @JsonKey(name: 'category_id') final String? categoryId}) =
      _$WarehouseCategoryReadRequestModelImpl;

  factory _WarehouseCategoryReadRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$WarehouseCategoryReadRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseCategoryReadRequestModelImplCopyWith<
          _$WarehouseCategoryReadRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
