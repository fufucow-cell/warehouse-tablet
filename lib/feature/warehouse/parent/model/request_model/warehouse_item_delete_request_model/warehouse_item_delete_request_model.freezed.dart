// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_item_delete_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseItemDeleteRequestModel _$WarehouseItemDeleteRequestModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseItemDeleteRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseItemDeleteRequestModel {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseItemDeleteRequestModelCopyWith<WarehouseItemDeleteRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseItemDeleteRequestModelCopyWith<$Res> {
  factory $WarehouseItemDeleteRequestModelCopyWith(
          WarehouseItemDeleteRequestModel value,
          $Res Function(WarehouseItemDeleteRequestModel) then) =
      _$WarehouseItemDeleteRequestModelCopyWithImpl<$Res,
          WarehouseItemDeleteRequestModel>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'user_name') String? userName});
}

/// @nodoc
class _$WarehouseItemDeleteRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseItemDeleteRequestModel>
    implements $WarehouseItemDeleteRequestModelCopyWith<$Res> {
  _$WarehouseItemDeleteRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? householdId = freezed,
    Object? userName = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseItemDeleteRequestModelImplCopyWith<$Res>
    implements $WarehouseItemDeleteRequestModelCopyWith<$Res> {
  factory _$$WarehouseItemDeleteRequestModelImplCopyWith(
          _$WarehouseItemDeleteRequestModelImpl value,
          $Res Function(_$WarehouseItemDeleteRequestModelImpl) then) =
      __$$WarehouseItemDeleteRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'user_name') String? userName});
}

/// @nodoc
class __$$WarehouseItemDeleteRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseItemDeleteRequestModelCopyWithImpl<$Res,
        _$WarehouseItemDeleteRequestModelImpl>
    implements _$$WarehouseItemDeleteRequestModelImplCopyWith<$Res> {
  __$$WarehouseItemDeleteRequestModelImplCopyWithImpl(
      _$WarehouseItemDeleteRequestModelImpl _value,
      $Res Function(_$WarehouseItemDeleteRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? householdId = freezed,
    Object? userName = freezed,
  }) {
    return _then(_$WarehouseItemDeleteRequestModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseItemDeleteRequestModelImpl
    implements _WarehouseItemDeleteRequestModel {
  _$WarehouseItemDeleteRequestModelImpl(
      {this.id,
      @JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'user_name') this.userName});

  factory _$WarehouseItemDeleteRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseItemDeleteRequestModelImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;

  @override
  String toString() {
    return 'WarehouseItemDeleteRequestModel(id: $id, householdId: $householdId, userName: $userName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseItemDeleteRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.userName, userName) ||
                other.userName == userName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, householdId, userName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseItemDeleteRequestModelImplCopyWith<
          _$WarehouseItemDeleteRequestModelImpl>
      get copyWith => __$$WarehouseItemDeleteRequestModelImplCopyWithImpl<
          _$WarehouseItemDeleteRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseItemDeleteRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseItemDeleteRequestModel
    implements WarehouseItemDeleteRequestModel {
  factory _WarehouseItemDeleteRequestModel(
          {final String? id,
          @JsonKey(name: 'household_id') final String? householdId,
          @JsonKey(name: 'user_name') final String? userName}) =
      _$WarehouseItemDeleteRequestModelImpl;

  factory _WarehouseItemDeleteRequestModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseItemDeleteRequestModelImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseItemDeleteRequestModelImplCopyWith<
          _$WarehouseItemDeleteRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
