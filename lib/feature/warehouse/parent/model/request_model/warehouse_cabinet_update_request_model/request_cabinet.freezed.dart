// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_cabinet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestCabinet _$RequestCabinetFromJson(Map<String, dynamic> json) {
  return _RequestCabinet.fromJson(json);
}

/// @nodoc
mixin _$RequestCabinet {
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_cabinet_name')
  String? get newRequestCabinetName => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_room_id')
  String? get newRoomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_delete')
  bool? get isDelete => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestCabinetCopyWith<RequestCabinet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestCabinetCopyWith<$Res> {
  factory $RequestCabinetCopyWith(
          RequestCabinet value, $Res Function(RequestCabinet) then) =
      _$RequestCabinetCopyWithImpl<$Res, RequestCabinet>;
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'new_cabinet_name') String? newRequestCabinetName,
      @JsonKey(name: 'new_room_id') String? newRoomId,
      @JsonKey(name: 'is_delete') bool? isDelete});
}

/// @nodoc
class _$RequestCabinetCopyWithImpl<$Res, $Val extends RequestCabinet>
    implements $RequestCabinetCopyWith<$Res> {
  _$RequestCabinetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetId = freezed,
    Object? newRequestCabinetName = freezed,
    Object? newRoomId = freezed,
    Object? isDelete = freezed,
  }) {
    return _then(_value.copyWith(
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      newRequestCabinetName: freezed == newRequestCabinetName
          ? _value.newRequestCabinetName
          : newRequestCabinetName // ignore: cast_nullable_to_non_nullable
              as String?,
      newRoomId: freezed == newRoomId
          ? _value.newRoomId
          : newRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: freezed == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestCabinetImplCopyWith<$Res>
    implements $RequestCabinetCopyWith<$Res> {
  factory _$$RequestCabinetImplCopyWith(_$RequestCabinetImpl value,
          $Res Function(_$RequestCabinetImpl) then) =
      __$$RequestCabinetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'new_cabinet_name') String? newRequestCabinetName,
      @JsonKey(name: 'new_room_id') String? newRoomId,
      @JsonKey(name: 'is_delete') bool? isDelete});
}

/// @nodoc
class __$$RequestCabinetImplCopyWithImpl<$Res>
    extends _$RequestCabinetCopyWithImpl<$Res, _$RequestCabinetImpl>
    implements _$$RequestCabinetImplCopyWith<$Res> {
  __$$RequestCabinetImplCopyWithImpl(
      _$RequestCabinetImpl _value, $Res Function(_$RequestCabinetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetId = freezed,
    Object? newRequestCabinetName = freezed,
    Object? newRoomId = freezed,
    Object? isDelete = freezed,
  }) {
    return _then(_$RequestCabinetImpl(
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      newRequestCabinetName: freezed == newRequestCabinetName
          ? _value.newRequestCabinetName
          : newRequestCabinetName // ignore: cast_nullable_to_non_nullable
              as String?,
      newRoomId: freezed == newRoomId
          ? _value.newRoomId
          : newRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: freezed == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestCabinetImpl implements _RequestCabinet {
  _$RequestCabinetImpl(
      {@JsonKey(name: 'cabinet_id') this.cabinetId,
      @JsonKey(name: 'new_cabinet_name') this.newRequestCabinetName,
      @JsonKey(name: 'new_room_id') this.newRoomId,
      @JsonKey(name: 'is_delete') this.isDelete});

  factory _$RequestCabinetImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestCabinetImplFromJson(json);

  @override
  @JsonKey(name: 'cabinet_id')
  final String? cabinetId;
  @override
  @JsonKey(name: 'new_cabinet_name')
  final String? newRequestCabinetName;
  @override
  @JsonKey(name: 'new_room_id')
  final String? newRoomId;
  @override
  @JsonKey(name: 'is_delete')
  final bool? isDelete;

  @override
  String toString() {
    return 'RequestCabinet(cabinetId: $cabinetId, newRequestCabinetName: $newRequestCabinetName, newRoomId: $newRoomId, isDelete: $isDelete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestCabinetImpl &&
            (identical(other.cabinetId, cabinetId) ||
                other.cabinetId == cabinetId) &&
            (identical(other.newRequestCabinetName, newRequestCabinetName) ||
                other.newRequestCabinetName == newRequestCabinetName) &&
            (identical(other.newRoomId, newRoomId) ||
                other.newRoomId == newRoomId) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, cabinetId, newRequestCabinetName, newRoomId, isDelete);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestCabinetImplCopyWith<_$RequestCabinetImpl> get copyWith =>
      __$$RequestCabinetImplCopyWithImpl<_$RequestCabinetImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestCabinetImplToJson(
      this,
    );
  }
}

abstract class _RequestCabinet implements RequestCabinet {
  factory _RequestCabinet(
      {@JsonKey(name: 'cabinet_id') final String? cabinetId,
      @JsonKey(name: 'new_cabinet_name') final String? newRequestCabinetName,
      @JsonKey(name: 'new_room_id') final String? newRoomId,
      @JsonKey(name: 'is_delete') final bool? isDelete}) = _$RequestCabinetImpl;

  factory _RequestCabinet.fromJson(Map<String, dynamic> json) =
      _$RequestCabinetImpl.fromJson;

  @override
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId;
  @override
  @JsonKey(name: 'new_cabinet_name')
  String? get newRequestCabinetName;
  @override
  @JsonKey(name: 'new_room_id')
  String? get newRoomId;
  @override
  @JsonKey(name: 'is_delete')
  bool? get isDelete;
  @override
  @JsonKey(ignore: true)
  _$$RequestCabinetImplCopyWith<_$RequestCabinetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
