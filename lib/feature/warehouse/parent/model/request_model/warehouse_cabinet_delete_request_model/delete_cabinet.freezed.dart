// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_cabinet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeleteCabinet _$DeleteCabinetFromJson(Map<String, dynamic> json) {
  return _DeleteCabinet.fromJson(json);
}

/// @nodoc
mixin _$DeleteCabinet {
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'old_room_name')
  String? get oldRoomName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeleteCabinetCopyWith<DeleteCabinet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteCabinetCopyWith<$Res> {
  factory $DeleteCabinetCopyWith(
          DeleteCabinet value, $Res Function(DeleteCabinet) then) =
      _$DeleteCabinetCopyWithImpl<$Res, DeleteCabinet>;
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'old_room_name') String? oldRoomName});
}

/// @nodoc
class _$DeleteCabinetCopyWithImpl<$Res, $Val extends DeleteCabinet>
    implements $DeleteCabinetCopyWith<$Res> {
  _$DeleteCabinetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetId = freezed,
    Object? oldRoomName = freezed,
  }) {
    return _then(_value.copyWith(
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      oldRoomName: freezed == oldRoomName
          ? _value.oldRoomName
          : oldRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeleteCabinetImplCopyWith<$Res>
    implements $DeleteCabinetCopyWith<$Res> {
  factory _$$DeleteCabinetImplCopyWith(
          _$DeleteCabinetImpl value, $Res Function(_$DeleteCabinetImpl) then) =
      __$$DeleteCabinetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'old_room_name') String? oldRoomName});
}

/// @nodoc
class __$$DeleteCabinetImplCopyWithImpl<$Res>
    extends _$DeleteCabinetCopyWithImpl<$Res, _$DeleteCabinetImpl>
    implements _$$DeleteCabinetImplCopyWith<$Res> {
  __$$DeleteCabinetImplCopyWithImpl(
      _$DeleteCabinetImpl _value, $Res Function(_$DeleteCabinetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetId = freezed,
    Object? oldRoomName = freezed,
  }) {
    return _then(_$DeleteCabinetImpl(
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      oldRoomName: freezed == oldRoomName
          ? _value.oldRoomName
          : oldRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteCabinetImpl implements _DeleteCabinet {
  _$DeleteCabinetImpl(
      {@JsonKey(name: 'cabinet_id') this.cabinetId,
      @JsonKey(name: 'old_room_name') this.oldRoomName});

  factory _$DeleteCabinetImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeleteCabinetImplFromJson(json);

  @override
  @JsonKey(name: 'cabinet_id')
  final String? cabinetId;
  @override
  @JsonKey(name: 'old_room_name')
  final String? oldRoomName;

  @override
  String toString() {
    return 'DeleteCabinet(cabinetId: $cabinetId, oldRoomName: $oldRoomName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCabinetImpl &&
            (identical(other.cabinetId, cabinetId) ||
                other.cabinetId == cabinetId) &&
            (identical(other.oldRoomName, oldRoomName) ||
                other.oldRoomName == oldRoomName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cabinetId, oldRoomName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCabinetImplCopyWith<_$DeleteCabinetImpl> get copyWith =>
      __$$DeleteCabinetImplCopyWithImpl<_$DeleteCabinetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteCabinetImplToJson(
      this,
    );
  }
}

abstract class _DeleteCabinet implements DeleteCabinet {
  factory _DeleteCabinet(
          {@JsonKey(name: 'cabinet_id') final String? cabinetId,
          @JsonKey(name: 'old_room_name') final String? oldRoomName}) =
      _$DeleteCabinetImpl;

  factory _DeleteCabinet.fromJson(Map<String, dynamic> json) =
      _$DeleteCabinetImpl.fromJson;

  @override
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId;
  @override
  @JsonKey(name: 'old_room_name')
  String? get oldRoomName;
  @override
  @JsonKey(ignore: true)
  _$$DeleteCabinetImplCopyWith<_$DeleteCabinetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
