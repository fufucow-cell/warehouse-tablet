// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_item_edit_quantity_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseItemEditQuantityRequestModel
    _$WarehouseItemEditQuantityRequestModelFromJson(Map<String, dynamic> json) {
  return _WarehouseItemEditQuantityRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseItemEditQuantityRequestModel {
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_id')
  String? get itemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  List<QuantityCabinetRequestModel>? get cabinets =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseItemEditQuantityRequestModelCopyWith<
          WarehouseItemEditQuantityRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseItemEditQuantityRequestModelCopyWith<$Res> {
  factory $WarehouseItemEditQuantityRequestModelCopyWith(
          WarehouseItemEditQuantityRequestModel value,
          $Res Function(WarehouseItemEditQuantityRequestModel) then) =
      _$WarehouseItemEditQuantityRequestModelCopyWithImpl<$Res,
          WarehouseItemEditQuantityRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'item_id') String? itemId,
      @JsonKey(name: 'user_name') String? userName,
      List<QuantityCabinetRequestModel>? cabinets});
}

/// @nodoc
class _$WarehouseItemEditQuantityRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseItemEditQuantityRequestModel>
    implements $WarehouseItemEditQuantityRequestModelCopyWith<$Res> {
  _$WarehouseItemEditQuantityRequestModelCopyWithImpl(this._value, this._then);

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
              as List<QuantityCabinetRequestModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseItemEditQuantityRequestModelImplCopyWith<$Res>
    implements $WarehouseItemEditQuantityRequestModelCopyWith<$Res> {
  factory _$$WarehouseItemEditQuantityRequestModelImplCopyWith(
          _$WarehouseItemEditQuantityRequestModelImpl value,
          $Res Function(_$WarehouseItemEditQuantityRequestModelImpl) then) =
      __$$WarehouseItemEditQuantityRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'item_id') String? itemId,
      @JsonKey(name: 'user_name') String? userName,
      List<QuantityCabinetRequestModel>? cabinets});
}

/// @nodoc
class __$$WarehouseItemEditQuantityRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseItemEditQuantityRequestModelCopyWithImpl<$Res,
        _$WarehouseItemEditQuantityRequestModelImpl>
    implements _$$WarehouseItemEditQuantityRequestModelImplCopyWith<$Res> {
  __$$WarehouseItemEditQuantityRequestModelImplCopyWithImpl(
      _$WarehouseItemEditQuantityRequestModelImpl _value,
      $Res Function(_$WarehouseItemEditQuantityRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? itemId = freezed,
    Object? userName = freezed,
    Object? cabinets = freezed,
  }) {
    return _then(_$WarehouseItemEditQuantityRequestModelImpl(
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
              as List<QuantityCabinetRequestModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseItemEditQuantityRequestModelImpl
    implements _WarehouseItemEditQuantityRequestModel {
  _$WarehouseItemEditQuantityRequestModelImpl(
      {@JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'item_id') this.itemId,
      @JsonKey(name: 'user_name') this.userName,
      final List<QuantityCabinetRequestModel>? cabinets})
      : _cabinets = cabinets;

  factory _$WarehouseItemEditQuantityRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseItemEditQuantityRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  @JsonKey(name: 'item_id')
  final String? itemId;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  final List<QuantityCabinetRequestModel>? _cabinets;
  @override
  List<QuantityCabinetRequestModel>? get cabinets {
    final value = _cabinets;
    if (value == null) return null;
    if (_cabinets is EqualUnmodifiableListView) return _cabinets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WarehouseItemEditQuantityRequestModel(householdId: $householdId, itemId: $itemId, userName: $userName, cabinets: $cabinets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseItemEditQuantityRequestModelImpl &&
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
  _$$WarehouseItemEditQuantityRequestModelImplCopyWith<
          _$WarehouseItemEditQuantityRequestModelImpl>
      get copyWith => __$$WarehouseItemEditQuantityRequestModelImplCopyWithImpl<
          _$WarehouseItemEditQuantityRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseItemEditQuantityRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseItemEditQuantityRequestModel
    implements WarehouseItemEditQuantityRequestModel {
  factory _WarehouseItemEditQuantityRequestModel(
          {@JsonKey(name: 'household_id') final String? householdId,
          @JsonKey(name: 'item_id') final String? itemId,
          @JsonKey(name: 'user_name') final String? userName,
          final List<QuantityCabinetRequestModel>? cabinets}) =
      _$WarehouseItemEditQuantityRequestModelImpl;

  factory _WarehouseItemEditQuantityRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$WarehouseItemEditQuantityRequestModelImpl.fromJson;

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
  List<QuantityCabinetRequestModel>? get cabinets;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseItemEditQuantityRequestModelImplCopyWith<
          _$WarehouseItemEditQuantityRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

QuantityCabinetRequestModel _$QuantityCabinetRequestModelFromJson(
    Map<String, dynamic> json) {
  return _QuantityCabinetRequestModel.fromJson(json);
}

/// @nodoc
mixin _$QuantityCabinetRequestModel {
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuantityCabinetRequestModelCopyWith<QuantityCabinetRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuantityCabinetRequestModelCopyWith<$Res> {
  factory $QuantityCabinetRequestModelCopyWith(
          QuantityCabinetRequestModel value,
          $Res Function(QuantityCabinetRequestModel) then) =
      _$QuantityCabinetRequestModelCopyWithImpl<$Res,
          QuantityCabinetRequestModel>;
  @useResult
  $Res call({@JsonKey(name: 'cabinet_id') String? cabinetId, int? quantity});
}

/// @nodoc
class _$QuantityCabinetRequestModelCopyWithImpl<$Res,
        $Val extends QuantityCabinetRequestModel>
    implements $QuantityCabinetRequestModelCopyWith<$Res> {
  _$QuantityCabinetRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetId = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_value.copyWith(
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuantityCabinetRequestModelImplCopyWith<$Res>
    implements $QuantityCabinetRequestModelCopyWith<$Res> {
  factory _$$QuantityCabinetRequestModelImplCopyWith(
          _$QuantityCabinetRequestModelImpl value,
          $Res Function(_$QuantityCabinetRequestModelImpl) then) =
      __$$QuantityCabinetRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'cabinet_id') String? cabinetId, int? quantity});
}

/// @nodoc
class __$$QuantityCabinetRequestModelImplCopyWithImpl<$Res>
    extends _$QuantityCabinetRequestModelCopyWithImpl<$Res,
        _$QuantityCabinetRequestModelImpl>
    implements _$$QuantityCabinetRequestModelImplCopyWith<$Res> {
  __$$QuantityCabinetRequestModelImplCopyWithImpl(
      _$QuantityCabinetRequestModelImpl _value,
      $Res Function(_$QuantityCabinetRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetId = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_$QuantityCabinetRequestModelImpl(
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuantityCabinetRequestModelImpl
    implements _QuantityCabinetRequestModel {
  _$QuantityCabinetRequestModelImpl(
      {@JsonKey(name: 'cabinet_id') this.cabinetId, this.quantity});

  factory _$QuantityCabinetRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$QuantityCabinetRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'cabinet_id')
  final String? cabinetId;
  @override
  final int? quantity;

  @override
  String toString() {
    return 'QuantityCabinetRequestModel(cabinetId: $cabinetId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuantityCabinetRequestModelImpl &&
            (identical(other.cabinetId, cabinetId) ||
                other.cabinetId == cabinetId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cabinetId, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuantityCabinetRequestModelImplCopyWith<_$QuantityCabinetRequestModelImpl>
      get copyWith => __$$QuantityCabinetRequestModelImplCopyWithImpl<
          _$QuantityCabinetRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuantityCabinetRequestModelImplToJson(
      this,
    );
  }
}

abstract class _QuantityCabinetRequestModel
    implements QuantityCabinetRequestModel {
  factory _QuantityCabinetRequestModel(
      {@JsonKey(name: 'cabinet_id') final String? cabinetId,
      final int? quantity}) = _$QuantityCabinetRequestModelImpl;

  factory _QuantityCabinetRequestModel.fromJson(Map<String, dynamic> json) =
      _$QuantityCabinetRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId;
  @override
  int? get quantity;
  @override
  @JsonKey(ignore: true)
  _$$QuantityCabinetRequestModelImplCopyWith<_$QuantityCabinetRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
