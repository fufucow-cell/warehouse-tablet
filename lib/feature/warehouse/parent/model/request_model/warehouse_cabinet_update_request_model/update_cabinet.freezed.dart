// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_cabinet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateCabinet _$UpdateCabinetFromJson(Map<String, dynamic> json) {
  return _UpdateCabinet.fromJson(json);
}

/// @nodoc
mixin _$UpdateCabinet {
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_cabinet_name')
  String? get newCabinetName => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_room_id')
  String? get newRoomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'old_room_name')
  String? get oldRoomName => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_room_name')
  String? get newRoomName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateCabinetCopyWith<UpdateCabinet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateCabinetCopyWith<$Res> {
  factory $UpdateCabinetCopyWith(
          UpdateCabinet value, $Res Function(UpdateCabinet) then) =
      _$UpdateCabinetCopyWithImpl<$Res, UpdateCabinet>;
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'new_cabinet_name') String? newCabinetName,
      @JsonKey(name: 'new_room_id') String? newRoomId,
      @JsonKey(name: 'old_room_name') String? oldRoomName,
      @JsonKey(name: 'new_room_name') String? newRoomName});
}

/// @nodoc
class _$UpdateCabinetCopyWithImpl<$Res, $Val extends UpdateCabinet>
    implements $UpdateCabinetCopyWith<$Res> {
  _$UpdateCabinetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetId = freezed,
    Object? newCabinetName = freezed,
    Object? newRoomId = freezed,
    Object? oldRoomName = freezed,
    Object? newRoomName = freezed,
  }) {
    return _then(_value.copyWith(
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      newCabinetName: freezed == newCabinetName
          ? _value.newCabinetName
          : newCabinetName // ignore: cast_nullable_to_non_nullable
              as String?,
      newRoomId: freezed == newRoomId
          ? _value.newRoomId
          : newRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      oldRoomName: freezed == oldRoomName
          ? _value.oldRoomName
          : oldRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
      newRoomName: freezed == newRoomName
          ? _value.newRoomName
          : newRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateCabinetImplCopyWith<$Res>
    implements $UpdateCabinetCopyWith<$Res> {
  factory _$$UpdateCabinetImplCopyWith(
          _$UpdateCabinetImpl value, $Res Function(_$UpdateCabinetImpl) then) =
      __$$UpdateCabinetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'new_cabinet_name') String? newCabinetName,
      @JsonKey(name: 'new_room_id') String? newRoomId,
      @JsonKey(name: 'old_room_name') String? oldRoomName,
      @JsonKey(name: 'new_room_name') String? newRoomName});
}

/// @nodoc
class __$$UpdateCabinetImplCopyWithImpl<$Res>
    extends _$UpdateCabinetCopyWithImpl<$Res, _$UpdateCabinetImpl>
    implements _$$UpdateCabinetImplCopyWith<$Res> {
  __$$UpdateCabinetImplCopyWithImpl(
      _$UpdateCabinetImpl _value, $Res Function(_$UpdateCabinetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetId = freezed,
    Object? newCabinetName = freezed,
    Object? newRoomId = freezed,
    Object? oldRoomName = freezed,
    Object? newRoomName = freezed,
  }) {
    return _then(_$UpdateCabinetImpl(
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      newCabinetName: freezed == newCabinetName
          ? _value.newCabinetName
          : newCabinetName // ignore: cast_nullable_to_non_nullable
              as String?,
      newRoomId: freezed == newRoomId
          ? _value.newRoomId
          : newRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      oldRoomName: freezed == oldRoomName
          ? _value.oldRoomName
          : oldRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
      newRoomName: freezed == newRoomName
          ? _value.newRoomName
          : newRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateCabinetImpl implements _UpdateCabinet {
  _$UpdateCabinetImpl(
      {@JsonKey(name: 'cabinet_id') this.cabinetId,
      @JsonKey(name: 'new_cabinet_name') this.newCabinetName,
      @JsonKey(name: 'new_room_id') this.newRoomId,
      @JsonKey(name: 'old_room_name') this.oldRoomName,
      @JsonKey(name: 'new_room_name') this.newRoomName});

  factory _$UpdateCabinetImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateCabinetImplFromJson(json);

  @override
  @JsonKey(name: 'cabinet_id')
  final String? cabinetId;
  @override
  @JsonKey(name: 'new_cabinet_name')
  final String? newCabinetName;
  @override
  @JsonKey(name: 'new_room_id')
  final String? newRoomId;
  @override
  @JsonKey(name: 'old_room_name')
  final String? oldRoomName;
  @override
  @JsonKey(name: 'new_room_name')
  final String? newRoomName;

  @override
  String toString() {
    return 'UpdateCabinet(cabinetId: $cabinetId, newCabinetName: $newCabinetName, newRoomId: $newRoomId, oldRoomName: $oldRoomName, newRoomName: $newRoomName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCabinetImpl &&
            (identical(other.cabinetId, cabinetId) ||
                other.cabinetId == cabinetId) &&
            (identical(other.newCabinetName, newCabinetName) ||
                other.newCabinetName == newCabinetName) &&
            (identical(other.newRoomId, newRoomId) ||
                other.newRoomId == newRoomId) &&
            (identical(other.oldRoomName, oldRoomName) ||
                other.oldRoomName == oldRoomName) &&
            (identical(other.newRoomName, newRoomName) ||
                other.newRoomName == newRoomName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cabinetId, newCabinetName,
      newRoomId, oldRoomName, newRoomName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCabinetImplCopyWith<_$UpdateCabinetImpl> get copyWith =>
      __$$UpdateCabinetImplCopyWithImpl<_$UpdateCabinetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateCabinetImplToJson(
      this,
    );
  }
}

abstract class _UpdateCabinet implements UpdateCabinet {
  factory _UpdateCabinet(
          {@JsonKey(name: 'cabinet_id') final String? cabinetId,
          @JsonKey(name: 'new_cabinet_name') final String? newCabinetName,
          @JsonKey(name: 'new_room_id') final String? newRoomId,
          @JsonKey(name: 'old_room_name') final String? oldRoomName,
          @JsonKey(name: 'new_room_name') final String? newRoomName}) =
      _$UpdateCabinetImpl;

  factory _UpdateCabinet.fromJson(Map<String, dynamic> json) =
      _$UpdateCabinetImpl.fromJson;

  @override
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId;
  @override
  @JsonKey(name: 'new_cabinet_name')
  String? get newCabinetName;
  @override
  @JsonKey(name: 'new_room_id')
  String? get newRoomId;
  @override
  @JsonKey(name: 'old_room_name')
  String? get oldRoomName;
  @override
  @JsonKey(name: 'new_room_name')
  String? get newRoomName;
  @override
  @JsonKey(ignore: true)
  _$$UpdateCabinetImplCopyWith<_$UpdateCabinetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
