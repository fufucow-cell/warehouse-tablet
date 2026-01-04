// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_cabinet_update_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseCabinetUpdateRequestModel _$WarehouseCabinetUpdateRequestModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseCabinetUpdateRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseCabinetUpdateRequestModel {
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  List<RequestCabinet>? get cabinets => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseCabinetUpdateRequestModelCopyWith<
          WarehouseCabinetUpdateRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseCabinetUpdateRequestModelCopyWith<$Res> {
  factory $WarehouseCabinetUpdateRequestModelCopyWith(
          WarehouseCabinetUpdateRequestModel value,
          $Res Function(WarehouseCabinetUpdateRequestModel) then) =
      _$WarehouseCabinetUpdateRequestModelCopyWithImpl<$Res,
          WarehouseCabinetUpdateRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'user_name') String? userName,
      List<RequestCabinet>? cabinets});
}

/// @nodoc
class _$WarehouseCabinetUpdateRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseCabinetUpdateRequestModel>
    implements $WarehouseCabinetUpdateRequestModelCopyWith<$Res> {
  _$WarehouseCabinetUpdateRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? userName = freezed,
    Object? cabinets = freezed,
  }) {
    return _then(_value.copyWith(
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      cabinets: freezed == cabinets
          ? _value.cabinets
          : cabinets // ignore: cast_nullable_to_non_nullable
              as List<RequestCabinet>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseCabinetUpdateRequestModelImplCopyWith<$Res>
    implements $WarehouseCabinetUpdateRequestModelCopyWith<$Res> {
  factory _$$WarehouseCabinetUpdateRequestModelImplCopyWith(
          _$WarehouseCabinetUpdateRequestModelImpl value,
          $Res Function(_$WarehouseCabinetUpdateRequestModelImpl) then) =
      __$$WarehouseCabinetUpdateRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'user_name') String? userName,
      List<RequestCabinet>? cabinets});
}

/// @nodoc
class __$$WarehouseCabinetUpdateRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseCabinetUpdateRequestModelCopyWithImpl<$Res,
        _$WarehouseCabinetUpdateRequestModelImpl>
    implements _$$WarehouseCabinetUpdateRequestModelImplCopyWith<$Res> {
  __$$WarehouseCabinetUpdateRequestModelImplCopyWithImpl(
      _$WarehouseCabinetUpdateRequestModelImpl _value,
      $Res Function(_$WarehouseCabinetUpdateRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? userName = freezed,
    Object? cabinets = freezed,
  }) {
    return _then(_$WarehouseCabinetUpdateRequestModelImpl(
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      cabinets: freezed == cabinets
          ? _value._cabinets
          : cabinets // ignore: cast_nullable_to_non_nullable
              as List<RequestCabinet>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseCabinetUpdateRequestModelImpl
    implements _WarehouseCabinetUpdateRequestModel {
  _$WarehouseCabinetUpdateRequestModelImpl(
      {@JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'user_name') this.userName,
      final List<RequestCabinet>? cabinets})
      : _cabinets = cabinets;

  factory _$WarehouseCabinetUpdateRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseCabinetUpdateRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  final List<RequestCabinet>? _cabinets;
  @override
  List<RequestCabinet>? get cabinets {
    final value = _cabinets;
    if (value == null) return null;
    if (_cabinets is EqualUnmodifiableListView) return _cabinets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WarehouseCabinetUpdateRequestModel(householdId: $householdId, userName: $userName, cabinets: $cabinets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseCabinetUpdateRequestModelImpl &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            const DeepCollectionEquality().equals(other._cabinets, _cabinets));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, householdId, userName,
      const DeepCollectionEquality().hash(_cabinets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseCabinetUpdateRequestModelImplCopyWith<
          _$WarehouseCabinetUpdateRequestModelImpl>
      get copyWith => __$$WarehouseCabinetUpdateRequestModelImplCopyWithImpl<
          _$WarehouseCabinetUpdateRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseCabinetUpdateRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseCabinetUpdateRequestModel
    implements WarehouseCabinetUpdateRequestModel {
  factory _WarehouseCabinetUpdateRequestModel(
          {@JsonKey(name: 'household_id') final String? householdId,
          @JsonKey(name: 'user_name') final String? userName,
          final List<RequestCabinet>? cabinets}) =
      _$WarehouseCabinetUpdateRequestModelImpl;

  factory _WarehouseCabinetUpdateRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$WarehouseCabinetUpdateRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  List<RequestCabinet>? get cabinets;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseCabinetUpdateRequestModelImplCopyWith<
          _$WarehouseCabinetUpdateRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
