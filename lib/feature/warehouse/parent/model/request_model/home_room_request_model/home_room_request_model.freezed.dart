// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_room_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomeRoomRequestModel _$HomeRoomRequestModelFromJson(Map<String, dynamic> json) {
  return _HomeRoomRequestModel.fromJson(json);
}

/// @nodoc
mixin _$HomeRoomRequestModel {
  @JsonKey(name: 'household_id')
  String? get homeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_id')
  String? get roomId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeRoomRequestModelCopyWith<HomeRoomRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeRoomRequestModelCopyWith<$Res> {
  factory $HomeRoomRequestModelCopyWith(HomeRoomRequestModel value,
          $Res Function(HomeRoomRequestModel) then) =
      _$HomeRoomRequestModelCopyWithImpl<$Res, HomeRoomRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? homeId,
      @JsonKey(name: 'room_id') String? roomId});
}

/// @nodoc
class _$HomeRoomRequestModelCopyWithImpl<$Res,
        $Val extends HomeRoomRequestModel>
    implements $HomeRoomRequestModelCopyWith<$Res> {
  _$HomeRoomRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeId = freezed,
    Object? roomId = freezed,
  }) {
    return _then(_value.copyWith(
      homeId: freezed == homeId
          ? _value.homeId
          : homeId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeRoomRequestModelImplCopyWith<$Res>
    implements $HomeRoomRequestModelCopyWith<$Res> {
  factory _$$HomeRoomRequestModelImplCopyWith(_$HomeRoomRequestModelImpl value,
          $Res Function(_$HomeRoomRequestModelImpl) then) =
      __$$HomeRoomRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? homeId,
      @JsonKey(name: 'room_id') String? roomId});
}

/// @nodoc
class __$$HomeRoomRequestModelImplCopyWithImpl<$Res>
    extends _$HomeRoomRequestModelCopyWithImpl<$Res, _$HomeRoomRequestModelImpl>
    implements _$$HomeRoomRequestModelImplCopyWith<$Res> {
  __$$HomeRoomRequestModelImplCopyWithImpl(_$HomeRoomRequestModelImpl _value,
      $Res Function(_$HomeRoomRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeId = freezed,
    Object? roomId = freezed,
  }) {
    return _then(_$HomeRoomRequestModelImpl(
      homeId: freezed == homeId
          ? _value.homeId
          : homeId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeRoomRequestModelImpl implements _HomeRoomRequestModel {
  _$HomeRoomRequestModelImpl(
      {@JsonKey(name: 'household_id') this.homeId,
      @JsonKey(name: 'room_id') this.roomId});

  factory _$HomeRoomRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeRoomRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'household_id')
  final String? homeId;
  @override
  @JsonKey(name: 'room_id')
  final String? roomId;

  @override
  String toString() {
    return 'HomeRoomRequestModel(homeId: $homeId, roomId: $roomId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeRoomRequestModelImpl &&
            (identical(other.homeId, homeId) || other.homeId == homeId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, homeId, roomId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeRoomRequestModelImplCopyWith<_$HomeRoomRequestModelImpl>
      get copyWith =>
          __$$HomeRoomRequestModelImplCopyWithImpl<_$HomeRoomRequestModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeRoomRequestModelImplToJson(
      this,
    );
  }
}

abstract class _HomeRoomRequestModel implements HomeRoomRequestModel {
  factory _HomeRoomRequestModel(
          {@JsonKey(name: 'household_id') final String? homeId,
          @JsonKey(name: 'room_id') final String? roomId}) =
      _$HomeRoomRequestModelImpl;

  factory _HomeRoomRequestModel.fromJson(Map<String, dynamic> json) =
      _$HomeRoomRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'household_id')
  String? get homeId;
  @override
  @JsonKey(name: 'room_id')
  String? get roomId;
  @override
  @JsonKey(ignore: true)
  _$$HomeRoomRequestModelImplCopyWith<_$HomeRoomRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
