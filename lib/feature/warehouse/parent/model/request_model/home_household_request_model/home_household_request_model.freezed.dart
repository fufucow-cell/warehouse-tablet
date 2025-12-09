// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_household_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomeHouseholdRequestModel _$HomeHouseholdRequestModelFromJson(
    Map<String, dynamic> json) {
  return _HomeHouseholdRequestModel.fromJson(json);
}

/// @nodoc
mixin _$HomeHouseholdRequestModel {
  @JsonKey(name: 'home_id')
  String? get homeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'home_name')
  String? get homeName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeHouseholdRequestModelCopyWith<HomeHouseholdRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeHouseholdRequestModelCopyWith<$Res> {
  factory $HomeHouseholdRequestModelCopyWith(HomeHouseholdRequestModel value,
          $Res Function(HomeHouseholdRequestModel) then) =
      _$HomeHouseholdRequestModelCopyWithImpl<$Res, HomeHouseholdRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'home_id') String? homeId,
      @JsonKey(name: 'home_name') String? homeName});
}

/// @nodoc
class _$HomeHouseholdRequestModelCopyWithImpl<$Res,
        $Val extends HomeHouseholdRequestModel>
    implements $HomeHouseholdRequestModelCopyWith<$Res> {
  _$HomeHouseholdRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeId = freezed,
    Object? homeName = freezed,
  }) {
    return _then(_value.copyWith(
      homeId: freezed == homeId
          ? _value.homeId
          : homeId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeName: freezed == homeName
          ? _value.homeName
          : homeName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeHouseholdRequestModelImplCopyWith<$Res>
    implements $HomeHouseholdRequestModelCopyWith<$Res> {
  factory _$$HomeHouseholdRequestModelImplCopyWith(
          _$HomeHouseholdRequestModelImpl value,
          $Res Function(_$HomeHouseholdRequestModelImpl) then) =
      __$$HomeHouseholdRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'home_id') String? homeId,
      @JsonKey(name: 'home_name') String? homeName});
}

/// @nodoc
class __$$HomeHouseholdRequestModelImplCopyWithImpl<$Res>
    extends _$HomeHouseholdRequestModelCopyWithImpl<$Res,
        _$HomeHouseholdRequestModelImpl>
    implements _$$HomeHouseholdRequestModelImplCopyWith<$Res> {
  __$$HomeHouseholdRequestModelImplCopyWithImpl(
      _$HomeHouseholdRequestModelImpl _value,
      $Res Function(_$HomeHouseholdRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeId = freezed,
    Object? homeName = freezed,
  }) {
    return _then(_$HomeHouseholdRequestModelImpl(
      homeId: freezed == homeId
          ? _value.homeId
          : homeId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeName: freezed == homeName
          ? _value.homeName
          : homeName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeHouseholdRequestModelImpl implements _HomeHouseholdRequestModel {
  _$HomeHouseholdRequestModelImpl(
      {@JsonKey(name: 'home_id') this.homeId,
      @JsonKey(name: 'home_name') this.homeName});

  factory _$HomeHouseholdRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeHouseholdRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'home_id')
  final String? homeId;
  @override
  @JsonKey(name: 'home_name')
  final String? homeName;

  @override
  String toString() {
    return 'HomeHouseholdRequestModel(homeId: $homeId, homeName: $homeName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeHouseholdRequestModelImpl &&
            (identical(other.homeId, homeId) || other.homeId == homeId) &&
            (identical(other.homeName, homeName) ||
                other.homeName == homeName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, homeId, homeName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeHouseholdRequestModelImplCopyWith<_$HomeHouseholdRequestModelImpl>
      get copyWith => __$$HomeHouseholdRequestModelImplCopyWithImpl<
          _$HomeHouseholdRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeHouseholdRequestModelImplToJson(
      this,
    );
  }
}

abstract class _HomeHouseholdRequestModel implements HomeHouseholdRequestModel {
  factory _HomeHouseholdRequestModel(
          {@JsonKey(name: 'home_id') final String? homeId,
          @JsonKey(name: 'home_name') final String? homeName}) =
      _$HomeHouseholdRequestModelImpl;

  factory _HomeHouseholdRequestModel.fromJson(Map<String, dynamic> json) =
      _$HomeHouseholdRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'home_id')
  String? get homeId;
  @override
  @JsonKey(name: 'home_name')
  String? get homeName;
  @override
  @JsonKey(ignore: true)
  _$$HomeHouseholdRequestModelImplCopyWith<_$HomeHouseholdRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
