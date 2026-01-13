// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_cabinet_read_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseCabinetReadRequestModel _$WarehouseCabinetReadRequestModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseCabinetReadRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseCabinetReadRequestModel {
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_id')
  String? get roomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseCabinetReadRequestModelCopyWith<WarehouseCabinetReadRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseCabinetReadRequestModelCopyWith<$Res> {
  factory $WarehouseCabinetReadRequestModelCopyWith(
          WarehouseCabinetReadRequestModel value,
          $Res Function(WarehouseCabinetReadRequestModel) then) =
      _$WarehouseCabinetReadRequestModelCopyWithImpl<$Res,
          WarehouseCabinetReadRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'room_id') String? roomId,
      @JsonKey(name: 'household_id') String? householdId});
}

/// @nodoc
class _$WarehouseCabinetReadRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseCabinetReadRequestModel>
    implements $WarehouseCabinetReadRequestModelCopyWith<$Res> {
  _$WarehouseCabinetReadRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetId = freezed,
    Object? roomId = freezed,
    Object? householdId = freezed,
  }) {
    return _then(_value.copyWith(
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseCabinetReadRequestModelImplCopyWith<$Res>
    implements $WarehouseCabinetReadRequestModelCopyWith<$Res> {
  factory _$$WarehouseCabinetReadRequestModelImplCopyWith(
          _$WarehouseCabinetReadRequestModelImpl value,
          $Res Function(_$WarehouseCabinetReadRequestModelImpl) then) =
      __$$WarehouseCabinetReadRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'room_id') String? roomId,
      @JsonKey(name: 'household_id') String? householdId});
}

/// @nodoc
class __$$WarehouseCabinetReadRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseCabinetReadRequestModelCopyWithImpl<$Res,
        _$WarehouseCabinetReadRequestModelImpl>
    implements _$$WarehouseCabinetReadRequestModelImplCopyWith<$Res> {
  __$$WarehouseCabinetReadRequestModelImplCopyWithImpl(
      _$WarehouseCabinetReadRequestModelImpl _value,
      $Res Function(_$WarehouseCabinetReadRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetId = freezed,
    Object? roomId = freezed,
    Object? householdId = freezed,
  }) {
    return _then(_$WarehouseCabinetReadRequestModelImpl(
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseCabinetReadRequestModelImpl
    implements _WarehouseCabinetReadRequestModel {
  _$WarehouseCabinetReadRequestModelImpl(
      {@JsonKey(name: 'cabinet_id') this.cabinetId,
      @JsonKey(name: 'room_id') this.roomId,
      @JsonKey(name: 'household_id') this.householdId});

  factory _$WarehouseCabinetReadRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseCabinetReadRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'cabinet_id')
  final String? cabinetId;
  @override
  @JsonKey(name: 'room_id')
  final String? roomId;
  @override
  @JsonKey(name: 'household_id')
  final String? householdId;

  @override
  String toString() {
    return 'WarehouseCabinetReadRequestModel(cabinetId: $cabinetId, roomId: $roomId, householdId: $householdId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseCabinetReadRequestModelImpl &&
            (identical(other.cabinetId, cabinetId) ||
                other.cabinetId == cabinetId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cabinetId, roomId, householdId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseCabinetReadRequestModelImplCopyWith<
          _$WarehouseCabinetReadRequestModelImpl>
      get copyWith => __$$WarehouseCabinetReadRequestModelImplCopyWithImpl<
          _$WarehouseCabinetReadRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseCabinetReadRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseCabinetReadRequestModel
    implements WarehouseCabinetReadRequestModel {
  factory _WarehouseCabinetReadRequestModel(
          {@JsonKey(name: 'cabinet_id') final String? cabinetId,
          @JsonKey(name: 'room_id') final String? roomId,
          @JsonKey(name: 'household_id') final String? householdId}) =
      _$WarehouseCabinetReadRequestModelImpl;

  factory _WarehouseCabinetReadRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$WarehouseCabinetReadRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId;
  @override
  @JsonKey(name: 'room_id')
  String? get roomId;
  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseCabinetReadRequestModelImplCopyWith<
          _$WarehouseCabinetReadRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
