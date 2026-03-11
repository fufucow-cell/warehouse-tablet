// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_item_create_smart_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseItemCreateSmartRequestModel
    _$WarehouseItemCreateSmartRequestModelFromJson(Map<String, dynamic> json) {
  return _WarehouseItemCreateSmartRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseItemCreateSmartRequestModel {
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseItemCreateSmartRequestModelCopyWith<
          WarehouseItemCreateSmartRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseItemCreateSmartRequestModelCopyWith<$Res> {
  factory $WarehouseItemCreateSmartRequestModelCopyWith(
          WarehouseItemCreateSmartRequestModel value,
          $Res Function(WarehouseItemCreateSmartRequestModel) then) =
      _$WarehouseItemCreateSmartRequestModelCopyWithImpl<$Res,
          WarehouseItemCreateSmartRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      String? image,
      String? language,
      @JsonKey(name: 'user_name') String? userName});
}

/// @nodoc
class _$WarehouseItemCreateSmartRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseItemCreateSmartRequestModel>
    implements $WarehouseItemCreateSmartRequestModelCopyWith<$Res> {
  _$WarehouseItemCreateSmartRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? image = freezed,
    Object? language = freezed,
    Object? userName = freezed,
  }) {
    return _then(_value.copyWith(
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseItemCreateSmartRequestModelImplCopyWith<$Res>
    implements $WarehouseItemCreateSmartRequestModelCopyWith<$Res> {
  factory _$$WarehouseItemCreateSmartRequestModelImplCopyWith(
          _$WarehouseItemCreateSmartRequestModelImpl value,
          $Res Function(_$WarehouseItemCreateSmartRequestModelImpl) then) =
      __$$WarehouseItemCreateSmartRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      String? image,
      String? language,
      @JsonKey(name: 'user_name') String? userName});
}

/// @nodoc
class __$$WarehouseItemCreateSmartRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseItemCreateSmartRequestModelCopyWithImpl<$Res,
        _$WarehouseItemCreateSmartRequestModelImpl>
    implements _$$WarehouseItemCreateSmartRequestModelImplCopyWith<$Res> {
  __$$WarehouseItemCreateSmartRequestModelImplCopyWithImpl(
      _$WarehouseItemCreateSmartRequestModelImpl _value,
      $Res Function(_$WarehouseItemCreateSmartRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? image = freezed,
    Object? language = freezed,
    Object? userName = freezed,
  }) {
    return _then(_$WarehouseItemCreateSmartRequestModelImpl(
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseItemCreateSmartRequestModelImpl
    implements _WarehouseItemCreateSmartRequestModel {
  _$WarehouseItemCreateSmartRequestModelImpl(
      {@JsonKey(name: 'household_id') this.householdId,
      this.image,
      this.language,
      @JsonKey(name: 'user_name') this.userName});

  factory _$WarehouseItemCreateSmartRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseItemCreateSmartRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  final String? image;
  @override
  final String? language;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;

  @override
  String toString() {
    return 'WarehouseItemCreateSmartRequestModel(householdId: $householdId, image: $image, language: $language, userName: $userName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseItemCreateSmartRequestModelImpl &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.userName, userName) ||
                other.userName == userName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, householdId, image, language, userName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseItemCreateSmartRequestModelImplCopyWith<
          _$WarehouseItemCreateSmartRequestModelImpl>
      get copyWith => __$$WarehouseItemCreateSmartRequestModelImplCopyWithImpl<
          _$WarehouseItemCreateSmartRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseItemCreateSmartRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseItemCreateSmartRequestModel
    implements WarehouseItemCreateSmartRequestModel {
  factory _WarehouseItemCreateSmartRequestModel(
          {@JsonKey(name: 'household_id') final String? householdId,
          final String? image,
          final String? language,
          @JsonKey(name: 'user_name') final String? userName}) =
      _$WarehouseItemCreateSmartRequestModelImpl;

  factory _WarehouseItemCreateSmartRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$WarehouseItemCreateSmartRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  String? get image;
  @override
  String? get language;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseItemCreateSmartRequestModelImplCopyWith<
          _$WarehouseItemCreateSmartRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
