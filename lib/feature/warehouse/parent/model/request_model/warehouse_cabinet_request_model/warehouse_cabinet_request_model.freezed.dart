// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_cabinet_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseCabinetRequestModel _$WarehouseCabinetRequestModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseCabinetRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseCabinetRequestModel {
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'household_id')
  String? get homeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_id')
  String? get roomId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseCabinetRequestModelCopyWith<WarehouseCabinetRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseCabinetRequestModelCopyWith<$Res> {
  factory $WarehouseCabinetRequestModelCopyWith(
          WarehouseCabinetRequestModel value,
          $Res Function(WarehouseCabinetRequestModel) then) =
      _$WarehouseCabinetRequestModelCopyWithImpl<$Res,
          WarehouseCabinetRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'household_id') String? homeId,
      @JsonKey(name: 'room_id') String? roomId});
}

/// @nodoc
class _$WarehouseCabinetRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseCabinetRequestModel>
    implements $WarehouseCabinetRequestModelCopyWith<$Res> {
  _$WarehouseCabinetRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetId = freezed,
    Object? homeId = freezed,
    Object? roomId = freezed,
  }) {
    return _then(_value.copyWith(
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$WarehouseCabinetRequestModelImplCopyWith<$Res>
    implements $WarehouseCabinetRequestModelCopyWith<$Res> {
  factory _$$WarehouseCabinetRequestModelImplCopyWith(
          _$WarehouseCabinetRequestModelImpl value,
          $Res Function(_$WarehouseCabinetRequestModelImpl) then) =
      __$$WarehouseCabinetRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'household_id') String? homeId,
      @JsonKey(name: 'room_id') String? roomId});
}

/// @nodoc
class __$$WarehouseCabinetRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseCabinetRequestModelCopyWithImpl<$Res,
        _$WarehouseCabinetRequestModelImpl>
    implements _$$WarehouseCabinetRequestModelImplCopyWith<$Res> {
  __$$WarehouseCabinetRequestModelImplCopyWithImpl(
      _$WarehouseCabinetRequestModelImpl _value,
      $Res Function(_$WarehouseCabinetRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetId = freezed,
    Object? homeId = freezed,
    Object? roomId = freezed,
  }) {
    return _then(_$WarehouseCabinetRequestModelImpl(
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$WarehouseCabinetRequestModelImpl
    implements _WarehouseCabinetRequestModel {
  _$WarehouseCabinetRequestModelImpl(
      {@JsonKey(name: 'cabinet_id') this.cabinetId,
      @JsonKey(name: 'household_id') this.homeId,
      @JsonKey(name: 'room_id') this.roomId});

  factory _$WarehouseCabinetRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseCabinetRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'cabinet_id')
  final String? cabinetId;
  @override
  @JsonKey(name: 'household_id')
  final String? homeId;
  @override
  @JsonKey(name: 'room_id')
  final String? roomId;

  @override
  String toString() {
    return 'WarehouseCabinetRequestModel(cabinetId: $cabinetId, homeId: $homeId, roomId: $roomId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseCabinetRequestModelImpl &&
            (identical(other.cabinetId, cabinetId) ||
                other.cabinetId == cabinetId) &&
            (identical(other.homeId, homeId) || other.homeId == homeId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cabinetId, homeId, roomId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseCabinetRequestModelImplCopyWith<
          _$WarehouseCabinetRequestModelImpl>
      get copyWith => __$$WarehouseCabinetRequestModelImplCopyWithImpl<
          _$WarehouseCabinetRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseCabinetRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseCabinetRequestModel
    implements WarehouseCabinetRequestModel {
  factory _WarehouseCabinetRequestModel(
          {@JsonKey(name: 'cabinet_id') final String? cabinetId,
          @JsonKey(name: 'household_id') final String? homeId,
          @JsonKey(name: 'room_id') final String? roomId}) =
      _$WarehouseCabinetRequestModelImpl;

  factory _WarehouseCabinetRequestModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseCabinetRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId;
  @override
  @JsonKey(name: 'household_id')
  String? get homeId;
  @override
  @JsonKey(name: 'room_id')
  String? get roomId;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseCabinetRequestModelImplCopyWith<
          _$WarehouseCabinetRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
