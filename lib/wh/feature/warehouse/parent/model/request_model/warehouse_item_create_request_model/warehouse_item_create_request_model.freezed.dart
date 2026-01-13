// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_item_create_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseItemCreateRequestModel _$WarehouseItemCreateRequestModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseItemCreateRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseItemCreateRequestModel {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_stock_alert')
  int? get minStockAlert => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseItemCreateRequestModelCopyWith<WarehouseItemCreateRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseItemCreateRequestModelCopyWith<$Res> {
  factory $WarehouseItemCreateRequestModelCopyWith(
          WarehouseItemCreateRequestModel value,
          $Res Function(WarehouseItemCreateRequestModel) then) =
      _$WarehouseItemCreateRequestModelCopyWithImpl<$Res,
          WarehouseItemCreateRequestModel>;
  @useResult
  $Res call(
      {String name,
      String? description,
      int quantity,
      @JsonKey(name: 'min_stock_alert') int? minStockAlert,
      String? photo,
      @JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'category_id') String? categoryId,
      @JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'user_name') String? userName});
}

/// @nodoc
class _$WarehouseItemCreateRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseItemCreateRequestModel>
    implements $WarehouseItemCreateRequestModelCopyWith<$Res> {
  _$WarehouseItemCreateRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? quantity = null,
    Object? minStockAlert = freezed,
    Object? photo = freezed,
    Object? cabinetId = freezed,
    Object? categoryId = freezed,
    Object? householdId = freezed,
    Object? userName = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      minStockAlert: freezed == minStockAlert
          ? _value.minStockAlert
          : minStockAlert // ignore: cast_nullable_to_non_nullable
              as int?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$WarehouseItemCreateRequestModelImplCopyWith<$Res>
    implements $WarehouseItemCreateRequestModelCopyWith<$Res> {
  factory _$$WarehouseItemCreateRequestModelImplCopyWith(
          _$WarehouseItemCreateRequestModelImpl value,
          $Res Function(_$WarehouseItemCreateRequestModelImpl) then) =
      __$$WarehouseItemCreateRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? description,
      int quantity,
      @JsonKey(name: 'min_stock_alert') int? minStockAlert,
      String? photo,
      @JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'category_id') String? categoryId,
      @JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'user_name') String? userName});
}

/// @nodoc
class __$$WarehouseItemCreateRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseItemCreateRequestModelCopyWithImpl<$Res,
        _$WarehouseItemCreateRequestModelImpl>
    implements _$$WarehouseItemCreateRequestModelImplCopyWith<$Res> {
  __$$WarehouseItemCreateRequestModelImplCopyWithImpl(
      _$WarehouseItemCreateRequestModelImpl _value,
      $Res Function(_$WarehouseItemCreateRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? quantity = null,
    Object? minStockAlert = freezed,
    Object? photo = freezed,
    Object? cabinetId = freezed,
    Object? categoryId = freezed,
    Object? householdId = freezed,
    Object? userName = freezed,
  }) {
    return _then(_$WarehouseItemCreateRequestModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      minStockAlert: freezed == minStockAlert
          ? _value.minStockAlert
          : minStockAlert // ignore: cast_nullable_to_non_nullable
              as int?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
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
class _$WarehouseItemCreateRequestModelImpl
    implements _WarehouseItemCreateRequestModel {
  _$WarehouseItemCreateRequestModelImpl(
      {required this.name,
      this.description,
      required this.quantity,
      @JsonKey(name: 'min_stock_alert') this.minStockAlert,
      this.photo,
      @JsonKey(name: 'cabinet_id') this.cabinetId,
      @JsonKey(name: 'category_id') this.categoryId,
      @JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'user_name') this.userName});

  factory _$WarehouseItemCreateRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseItemCreateRequestModelImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  @override
  final int quantity;
  @override
  @JsonKey(name: 'min_stock_alert')
  final int? minStockAlert;
  @override
  final String? photo;
  @override
  @JsonKey(name: 'cabinet_id')
  final String? cabinetId;
  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;

  @override
  String toString() {
    return 'WarehouseItemCreateRequestModel(name: $name, description: $description, quantity: $quantity, minStockAlert: $minStockAlert, photo: $photo, cabinetId: $cabinetId, categoryId: $categoryId, householdId: $householdId, userName: $userName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseItemCreateRequestModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.minStockAlert, minStockAlert) ||
                other.minStockAlert == minStockAlert) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.cabinetId, cabinetId) ||
                other.cabinetId == cabinetId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.userName, userName) ||
                other.userName == userName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, quantity,
      minStockAlert, photo, cabinetId, categoryId, householdId, userName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseItemCreateRequestModelImplCopyWith<
          _$WarehouseItemCreateRequestModelImpl>
      get copyWith => __$$WarehouseItemCreateRequestModelImplCopyWithImpl<
          _$WarehouseItemCreateRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseItemCreateRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseItemCreateRequestModel
    implements WarehouseItemCreateRequestModel {
  factory _WarehouseItemCreateRequestModel(
          {required final String name,
          final String? description,
          required final int quantity,
          @JsonKey(name: 'min_stock_alert') final int? minStockAlert,
          final String? photo,
          @JsonKey(name: 'cabinet_id') final String? cabinetId,
          @JsonKey(name: 'category_id') final String? categoryId,
          @JsonKey(name: 'household_id') final String? householdId,
          @JsonKey(name: 'user_name') final String? userName}) =
      _$WarehouseItemCreateRequestModelImpl;

  factory _WarehouseItemCreateRequestModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseItemCreateRequestModelImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'min_stock_alert')
  int? get minStockAlert;
  @override
  String? get photo;
  @override
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseItemCreateRequestModelImplCopyWith<
          _$WarehouseItemCreateRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
