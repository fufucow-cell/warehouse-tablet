// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_cabinet_delete_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseCabinetDeleteRequestModel _$WarehouseCabinetDeleteRequestModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseCabinetDeleteRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseCabinetDeleteRequestModel {
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  List<DeleteCabinet>? get cabinets => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseCabinetDeleteRequestModelCopyWith<
          WarehouseCabinetDeleteRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseCabinetDeleteRequestModelCopyWith<$Res> {
  factory $WarehouseCabinetDeleteRequestModelCopyWith(
          WarehouseCabinetDeleteRequestModel value,
          $Res Function(WarehouseCabinetDeleteRequestModel) then) =
      _$WarehouseCabinetDeleteRequestModelCopyWithImpl<$Res,
          WarehouseCabinetDeleteRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'user_name') String? userName,
      List<DeleteCabinet>? cabinets});
}

/// @nodoc
class _$WarehouseCabinetDeleteRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseCabinetDeleteRequestModel>
    implements $WarehouseCabinetDeleteRequestModelCopyWith<$Res> {
  _$WarehouseCabinetDeleteRequestModelCopyWithImpl(this._value, this._then);

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
              as List<DeleteCabinet>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseCabinetDeleteRequestModelImplCopyWith<$Res>
    implements $WarehouseCabinetDeleteRequestModelCopyWith<$Res> {
  factory _$$WarehouseCabinetDeleteRequestModelImplCopyWith(
          _$WarehouseCabinetDeleteRequestModelImpl value,
          $Res Function(_$WarehouseCabinetDeleteRequestModelImpl) then) =
      __$$WarehouseCabinetDeleteRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'user_name') String? userName,
      List<DeleteCabinet>? cabinets});
}

/// @nodoc
class __$$WarehouseCabinetDeleteRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseCabinetDeleteRequestModelCopyWithImpl<$Res,
        _$WarehouseCabinetDeleteRequestModelImpl>
    implements _$$WarehouseCabinetDeleteRequestModelImplCopyWith<$Res> {
  __$$WarehouseCabinetDeleteRequestModelImplCopyWithImpl(
      _$WarehouseCabinetDeleteRequestModelImpl _value,
      $Res Function(_$WarehouseCabinetDeleteRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? userName = freezed,
    Object? cabinets = freezed,
  }) {
    return _then(_$WarehouseCabinetDeleteRequestModelImpl(
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
              as List<DeleteCabinet>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseCabinetDeleteRequestModelImpl
    implements _WarehouseCabinetDeleteRequestModel {
  _$WarehouseCabinetDeleteRequestModelImpl(
      {@JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'user_name') this.userName,
      final List<DeleteCabinet>? cabinets})
      : _cabinets = cabinets;

  factory _$WarehouseCabinetDeleteRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseCabinetDeleteRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  final List<DeleteCabinet>? _cabinets;
  @override
  List<DeleteCabinet>? get cabinets {
    final value = _cabinets;
    if (value == null) return null;
    if (_cabinets is EqualUnmodifiableListView) return _cabinets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WarehouseCabinetDeleteRequestModel(householdId: $householdId, userName: $userName, cabinets: $cabinets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseCabinetDeleteRequestModelImpl &&
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
  _$$WarehouseCabinetDeleteRequestModelImplCopyWith<
          _$WarehouseCabinetDeleteRequestModelImpl>
      get copyWith => __$$WarehouseCabinetDeleteRequestModelImplCopyWithImpl<
          _$WarehouseCabinetDeleteRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseCabinetDeleteRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseCabinetDeleteRequestModel
    implements WarehouseCabinetDeleteRequestModel {
  factory _WarehouseCabinetDeleteRequestModel(
          {@JsonKey(name: 'household_id') final String? householdId,
          @JsonKey(name: 'user_name') final String? userName,
          final List<DeleteCabinet>? cabinets}) =
      _$WarehouseCabinetDeleteRequestModelImpl;

  factory _WarehouseCabinetDeleteRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$WarehouseCabinetDeleteRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  List<DeleteCabinet>? get cabinets;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseCabinetDeleteRequestModelImplCopyWith<
          _$WarehouseCabinetDeleteRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
