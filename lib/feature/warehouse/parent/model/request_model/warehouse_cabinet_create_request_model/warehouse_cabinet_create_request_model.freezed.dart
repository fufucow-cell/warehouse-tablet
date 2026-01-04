// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_cabinet_create_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseCabinetCreateRequestModel _$WarehouseCabinetCreateRequestModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseCabinetCreateRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseCabinetCreateRequestModel {
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_id')
  String? get roomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseCabinetCreateRequestModelCopyWith<
          WarehouseCabinetCreateRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseCabinetCreateRequestModelCopyWith<$Res> {
  factory $WarehouseCabinetCreateRequestModelCopyWith(
          WarehouseCabinetCreateRequestModel value,
          $Res Function(WarehouseCabinetCreateRequestModel) then) =
      _$WarehouseCabinetCreateRequestModelCopyWithImpl<$Res,
          WarehouseCabinetCreateRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'room_id') String? roomId,
      @JsonKey(name: 'user_name') String? userName,
      String? name});
}

/// @nodoc
class _$WarehouseCabinetCreateRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseCabinetCreateRequestModel>
    implements $WarehouseCabinetCreateRequestModelCopyWith<$Res> {
  _$WarehouseCabinetCreateRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? roomId = freezed,
    Object? userName = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseCabinetCreateRequestModelImplCopyWith<$Res>
    implements $WarehouseCabinetCreateRequestModelCopyWith<$Res> {
  factory _$$WarehouseCabinetCreateRequestModelImplCopyWith(
          _$WarehouseCabinetCreateRequestModelImpl value,
          $Res Function(_$WarehouseCabinetCreateRequestModelImpl) then) =
      __$$WarehouseCabinetCreateRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'room_id') String? roomId,
      @JsonKey(name: 'user_name') String? userName,
      String? name});
}

/// @nodoc
class __$$WarehouseCabinetCreateRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseCabinetCreateRequestModelCopyWithImpl<$Res,
        _$WarehouseCabinetCreateRequestModelImpl>
    implements _$$WarehouseCabinetCreateRequestModelImplCopyWith<$Res> {
  __$$WarehouseCabinetCreateRequestModelImplCopyWithImpl(
      _$WarehouseCabinetCreateRequestModelImpl _value,
      $Res Function(_$WarehouseCabinetCreateRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? roomId = freezed,
    Object? userName = freezed,
    Object? name = freezed,
  }) {
    return _then(_$WarehouseCabinetCreateRequestModelImpl(
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseCabinetCreateRequestModelImpl
    implements _WarehouseCabinetCreateRequestModel {
  _$WarehouseCabinetCreateRequestModelImpl(
      {@JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'room_id') this.roomId,
      @JsonKey(name: 'user_name') this.userName,
      this.name});

  factory _$WarehouseCabinetCreateRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseCabinetCreateRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  @JsonKey(name: 'room_id')
  final String? roomId;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  @override
  final String? name;

  @override
  String toString() {
    return 'WarehouseCabinetCreateRequestModel(householdId: $householdId, roomId: $roomId, userName: $userName, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseCabinetCreateRequestModelImpl &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, householdId, roomId, userName, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseCabinetCreateRequestModelImplCopyWith<
          _$WarehouseCabinetCreateRequestModelImpl>
      get copyWith => __$$WarehouseCabinetCreateRequestModelImplCopyWithImpl<
          _$WarehouseCabinetCreateRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseCabinetCreateRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseCabinetCreateRequestModel
    implements WarehouseCabinetCreateRequestModel {
  factory _WarehouseCabinetCreateRequestModel(
      {@JsonKey(name: 'household_id') final String? householdId,
      @JsonKey(name: 'room_id') final String? roomId,
      @JsonKey(name: 'user_name') final String? userName,
      final String? name}) = _$WarehouseCabinetCreateRequestModelImpl;

  factory _WarehouseCabinetCreateRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$WarehouseCabinetCreateRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  @JsonKey(name: 'room_id')
  String? get roomId;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseCabinetCreateRequestModelImplCopyWith<
          _$WarehouseCabinetCreateRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
