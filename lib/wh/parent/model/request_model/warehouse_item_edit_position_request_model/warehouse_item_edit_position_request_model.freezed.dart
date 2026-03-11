// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_item_edit_position_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseItemEditPositionRequestModel
    _$WarehouseItemEditPositionRequestModelFromJson(Map<String, dynamic> json) {
  return _WarehouseItemEditPositionRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseItemEditPositionRequestModel {
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_id')
  String? get itemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  List<PositionCabinetRequestModel>? get cabinets =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseItemEditPositionRequestModelCopyWith<
          WarehouseItemEditPositionRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseItemEditPositionRequestModelCopyWith<$Res> {
  factory $WarehouseItemEditPositionRequestModelCopyWith(
          WarehouseItemEditPositionRequestModel value,
          $Res Function(WarehouseItemEditPositionRequestModel) then) =
      _$WarehouseItemEditPositionRequestModelCopyWithImpl<$Res,
          WarehouseItemEditPositionRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'item_id') String? itemId,
      @JsonKey(name: 'user_name') String? userName,
      List<PositionCabinetRequestModel>? cabinets});
}

/// @nodoc
class _$WarehouseItemEditPositionRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseItemEditPositionRequestModel>
    implements $WarehouseItemEditPositionRequestModelCopyWith<$Res> {
  _$WarehouseItemEditPositionRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? itemId = freezed,
    Object? userName = freezed,
    Object? cabinets = freezed,
  }) {
    return _then(_value.copyWith(
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      itemId: freezed == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      cabinets: freezed == cabinets
          ? _value.cabinets
          : cabinets // ignore: cast_nullable_to_non_nullable
              as List<PositionCabinetRequestModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseItemEditPositionRequestModelImplCopyWith<$Res>
    implements $WarehouseItemEditPositionRequestModelCopyWith<$Res> {
  factory _$$WarehouseItemEditPositionRequestModelImplCopyWith(
          _$WarehouseItemEditPositionRequestModelImpl value,
          $Res Function(_$WarehouseItemEditPositionRequestModelImpl) then) =
      __$$WarehouseItemEditPositionRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'item_id') String? itemId,
      @JsonKey(name: 'user_name') String? userName,
      List<PositionCabinetRequestModel>? cabinets});
}

/// @nodoc
class __$$WarehouseItemEditPositionRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseItemEditPositionRequestModelCopyWithImpl<$Res,
        _$WarehouseItemEditPositionRequestModelImpl>
    implements _$$WarehouseItemEditPositionRequestModelImplCopyWith<$Res> {
  __$$WarehouseItemEditPositionRequestModelImplCopyWithImpl(
      _$WarehouseItemEditPositionRequestModelImpl _value,
      $Res Function(_$WarehouseItemEditPositionRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? itemId = freezed,
    Object? userName = freezed,
    Object? cabinets = freezed,
  }) {
    return _then(_$WarehouseItemEditPositionRequestModelImpl(
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      itemId: freezed == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      cabinets: freezed == cabinets
          ? _value._cabinets
          : cabinets // ignore: cast_nullable_to_non_nullable
              as List<PositionCabinetRequestModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseItemEditPositionRequestModelImpl
    implements _WarehouseItemEditPositionRequestModel {
  _$WarehouseItemEditPositionRequestModelImpl(
      {@JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'item_id') this.itemId,
      @JsonKey(name: 'user_name') this.userName,
      final List<PositionCabinetRequestModel>? cabinets})
      : _cabinets = cabinets;

  factory _$WarehouseItemEditPositionRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseItemEditPositionRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  @JsonKey(name: 'item_id')
  final String? itemId;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  final List<PositionCabinetRequestModel>? _cabinets;
  @override
  List<PositionCabinetRequestModel>? get cabinets {
    final value = _cabinets;
    if (value == null) return null;
    if (_cabinets is EqualUnmodifiableListView) return _cabinets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WarehouseItemEditPositionRequestModel(householdId: $householdId, itemId: $itemId, userName: $userName, cabinets: $cabinets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseItemEditPositionRequestModelImpl &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            const DeepCollectionEquality().equals(other._cabinets, _cabinets));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, householdId, itemId, userName,
      const DeepCollectionEquality().hash(_cabinets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseItemEditPositionRequestModelImplCopyWith<
          _$WarehouseItemEditPositionRequestModelImpl>
      get copyWith => __$$WarehouseItemEditPositionRequestModelImplCopyWithImpl<
          _$WarehouseItemEditPositionRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseItemEditPositionRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseItemEditPositionRequestModel
    implements WarehouseItemEditPositionRequestModel {
  factory _WarehouseItemEditPositionRequestModel(
          {@JsonKey(name: 'household_id') final String? householdId,
          @JsonKey(name: 'item_id') final String? itemId,
          @JsonKey(name: 'user_name') final String? userName,
          final List<PositionCabinetRequestModel>? cabinets}) =
      _$WarehouseItemEditPositionRequestModelImpl;

  factory _WarehouseItemEditPositionRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$WarehouseItemEditPositionRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  @JsonKey(name: 'item_id')
  String? get itemId;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  List<PositionCabinetRequestModel>? get cabinets;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseItemEditPositionRequestModelImplCopyWith<
          _$WarehouseItemEditPositionRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PositionCabinetRequestModel _$PositionCabinetRequestModelFromJson(
    Map<String, dynamic> json) {
  return _PositionCabinetRequestModel.fromJson(json);
}

/// @nodoc
mixin _$PositionCabinetRequestModel {
  @JsonKey(name: 'old_cabinet_id')
  String? get oldCabinetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_cabinet_id')
  String? get newCabinetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_delete')
  bool? get isDelete => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PositionCabinetRequestModelCopyWith<PositionCabinetRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PositionCabinetRequestModelCopyWith<$Res> {
  factory $PositionCabinetRequestModelCopyWith(
          PositionCabinetRequestModel value,
          $Res Function(PositionCabinetRequestModel) then) =
      _$PositionCabinetRequestModelCopyWithImpl<$Res,
          PositionCabinetRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'old_cabinet_id') String? oldCabinetId,
      @JsonKey(name: 'new_cabinet_id') String? newCabinetId,
      @JsonKey(name: 'is_delete') bool? isDelete,
      int? quantity});
}

/// @nodoc
class _$PositionCabinetRequestModelCopyWithImpl<$Res,
        $Val extends PositionCabinetRequestModel>
    implements $PositionCabinetRequestModelCopyWith<$Res> {
  _$PositionCabinetRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldCabinetId = freezed,
    Object? newCabinetId = freezed,
    Object? isDelete = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_value.copyWith(
      oldCabinetId: freezed == oldCabinetId
          ? _value.oldCabinetId
          : oldCabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      newCabinetId: freezed == newCabinetId
          ? _value.newCabinetId
          : newCabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: freezed == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PositionCabinetRequestModelImplCopyWith<$Res>
    implements $PositionCabinetRequestModelCopyWith<$Res> {
  factory _$$PositionCabinetRequestModelImplCopyWith(
          _$PositionCabinetRequestModelImpl value,
          $Res Function(_$PositionCabinetRequestModelImpl) then) =
      __$$PositionCabinetRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'old_cabinet_id') String? oldCabinetId,
      @JsonKey(name: 'new_cabinet_id') String? newCabinetId,
      @JsonKey(name: 'is_delete') bool? isDelete,
      int? quantity});
}

/// @nodoc
class __$$PositionCabinetRequestModelImplCopyWithImpl<$Res>
    extends _$PositionCabinetRequestModelCopyWithImpl<$Res,
        _$PositionCabinetRequestModelImpl>
    implements _$$PositionCabinetRequestModelImplCopyWith<$Res> {
  __$$PositionCabinetRequestModelImplCopyWithImpl(
      _$PositionCabinetRequestModelImpl _value,
      $Res Function(_$PositionCabinetRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldCabinetId = freezed,
    Object? newCabinetId = freezed,
    Object? isDelete = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_$PositionCabinetRequestModelImpl(
      oldCabinetId: freezed == oldCabinetId
          ? _value.oldCabinetId
          : oldCabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      newCabinetId: freezed == newCabinetId
          ? _value.newCabinetId
          : newCabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: freezed == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PositionCabinetRequestModelImpl
    implements _PositionCabinetRequestModel {
  _$PositionCabinetRequestModelImpl(
      {@JsonKey(name: 'old_cabinet_id') this.oldCabinetId,
      @JsonKey(name: 'new_cabinet_id') this.newCabinetId,
      @JsonKey(name: 'is_delete') this.isDelete,
      this.quantity});

  factory _$PositionCabinetRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PositionCabinetRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'old_cabinet_id')
  final String? oldCabinetId;
  @override
  @JsonKey(name: 'new_cabinet_id')
  final String? newCabinetId;
  @override
  @JsonKey(name: 'is_delete')
  final bool? isDelete;
  @override
  final int? quantity;

  @override
  String toString() {
    return 'PositionCabinetRequestModel(oldCabinetId: $oldCabinetId, newCabinetId: $newCabinetId, isDelete: $isDelete, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PositionCabinetRequestModelImpl &&
            (identical(other.oldCabinetId, oldCabinetId) ||
                other.oldCabinetId == oldCabinetId) &&
            (identical(other.newCabinetId, newCabinetId) ||
                other.newCabinetId == newCabinetId) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, oldCabinetId, newCabinetId, isDelete, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PositionCabinetRequestModelImplCopyWith<_$PositionCabinetRequestModelImpl>
      get copyWith => __$$PositionCabinetRequestModelImplCopyWithImpl<
          _$PositionCabinetRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PositionCabinetRequestModelImplToJson(
      this,
    );
  }
}

abstract class _PositionCabinetRequestModel
    implements PositionCabinetRequestModel {
  factory _PositionCabinetRequestModel(
      {@JsonKey(name: 'old_cabinet_id') final String? oldCabinetId,
      @JsonKey(name: 'new_cabinet_id') final String? newCabinetId,
      @JsonKey(name: 'is_delete') final bool? isDelete,
      final int? quantity}) = _$PositionCabinetRequestModelImpl;

  factory _PositionCabinetRequestModel.fromJson(Map<String, dynamic> json) =
      _$PositionCabinetRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'old_cabinet_id')
  String? get oldCabinetId;
  @override
  @JsonKey(name: 'new_cabinet_id')
  String? get newCabinetId;
  @override
  @JsonKey(name: 'is_delete')
  bool? get isDelete;
  @override
  int? get quantity;
  @override
  @JsonKey(ignore: true)
  _$$PositionCabinetRequestModelImplCopyWith<_$PositionCabinetRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
