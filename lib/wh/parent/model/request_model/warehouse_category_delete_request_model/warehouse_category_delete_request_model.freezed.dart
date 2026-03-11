// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_category_delete_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseCategoryDeleteRequestModel
    _$WarehouseCategoryDeleteRequestModelFromJson(Map<String, dynamic> json) {
  return _WarehouseCategoryDeleteRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseCategoryDeleteRequestModel {
  @JsonKey(name: 'household_id')
  String get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseCategoryDeleteRequestModelCopyWith<
          WarehouseCategoryDeleteRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseCategoryDeleteRequestModelCopyWith<$Res> {
  factory $WarehouseCategoryDeleteRequestModelCopyWith(
          WarehouseCategoryDeleteRequestModel value,
          $Res Function(WarehouseCategoryDeleteRequestModel) then) =
      _$WarehouseCategoryDeleteRequestModelCopyWithImpl<$Res,
          WarehouseCategoryDeleteRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String householdId,
      @JsonKey(name: 'category_id') String categoryId,
      @JsonKey(name: 'user_name') String? userName});
}

/// @nodoc
class _$WarehouseCategoryDeleteRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseCategoryDeleteRequestModel>
    implements $WarehouseCategoryDeleteRequestModelCopyWith<$Res> {
  _$WarehouseCategoryDeleteRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = null,
    Object? categoryId = null,
    Object? userName = freezed,
  }) {
    return _then(_value.copyWith(
      householdId: null == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseCategoryDeleteRequestModelImplCopyWith<$Res>
    implements $WarehouseCategoryDeleteRequestModelCopyWith<$Res> {
  factory _$$WarehouseCategoryDeleteRequestModelImplCopyWith(
          _$WarehouseCategoryDeleteRequestModelImpl value,
          $Res Function(_$WarehouseCategoryDeleteRequestModelImpl) then) =
      __$$WarehouseCategoryDeleteRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String householdId,
      @JsonKey(name: 'category_id') String categoryId,
      @JsonKey(name: 'user_name') String? userName});
}

/// @nodoc
class __$$WarehouseCategoryDeleteRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseCategoryDeleteRequestModelCopyWithImpl<$Res,
        _$WarehouseCategoryDeleteRequestModelImpl>
    implements _$$WarehouseCategoryDeleteRequestModelImplCopyWith<$Res> {
  __$$WarehouseCategoryDeleteRequestModelImplCopyWithImpl(
      _$WarehouseCategoryDeleteRequestModelImpl _value,
      $Res Function(_$WarehouseCategoryDeleteRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = null,
    Object? categoryId = null,
    Object? userName = freezed,
  }) {
    return _then(_$WarehouseCategoryDeleteRequestModelImpl(
      householdId: null == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseCategoryDeleteRequestModelImpl
    implements _WarehouseCategoryDeleteRequestModel {
  _$WarehouseCategoryDeleteRequestModelImpl(
      {@JsonKey(name: 'household_id') required this.householdId,
      @JsonKey(name: 'category_id') required this.categoryId,
      @JsonKey(name: 'user_name') this.userName});

  factory _$WarehouseCategoryDeleteRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseCategoryDeleteRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'household_id')
  final String householdId;
  @override
  @JsonKey(name: 'category_id')
  final String categoryId;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;

  @override
  String toString() {
    return 'WarehouseCategoryDeleteRequestModel(householdId: $householdId, categoryId: $categoryId, userName: $userName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseCategoryDeleteRequestModelImpl &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.userName, userName) ||
                other.userName == userName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, householdId, categoryId, userName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseCategoryDeleteRequestModelImplCopyWith<
          _$WarehouseCategoryDeleteRequestModelImpl>
      get copyWith => __$$WarehouseCategoryDeleteRequestModelImplCopyWithImpl<
          _$WarehouseCategoryDeleteRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseCategoryDeleteRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseCategoryDeleteRequestModel
    implements WarehouseCategoryDeleteRequestModel {
  factory _WarehouseCategoryDeleteRequestModel(
          {@JsonKey(name: 'household_id') required final String householdId,
          @JsonKey(name: 'category_id') required final String categoryId,
          @JsonKey(name: 'user_name') final String? userName}) =
      _$WarehouseCategoryDeleteRequestModelImpl;

  factory _WarehouseCategoryDeleteRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$WarehouseCategoryDeleteRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'household_id')
  String get householdId;
  @override
  @JsonKey(name: 'category_id')
  String get categoryId;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseCategoryDeleteRequestModelImplCopyWith<
          _$WarehouseCategoryDeleteRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
