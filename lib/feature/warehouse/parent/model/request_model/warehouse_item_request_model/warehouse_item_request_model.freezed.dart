// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_item_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseItemRequestModel _$WarehouseItemRequestModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseItemRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseItemRequestModel {
  @JsonKey(name: 'item_id')
  String? get itemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_id')
  String? get roomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'home_id')
  String? get homeId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseItemRequestModelCopyWith<WarehouseItemRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseItemRequestModelCopyWith<$Res> {
  factory $WarehouseItemRequestModelCopyWith(WarehouseItemRequestModel value,
          $Res Function(WarehouseItemRequestModel) then) =
      _$WarehouseItemRequestModelCopyWithImpl<$Res, WarehouseItemRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'item_id') String? itemId,
      @JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'category_id') String? categoryId,
      @JsonKey(name: 'room_id') String? roomId,
      @JsonKey(name: 'home_id') String? homeId});
}

/// @nodoc
class _$WarehouseItemRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseItemRequestModel>
    implements $WarehouseItemRequestModelCopyWith<$Res> {
  _$WarehouseItemRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = freezed,
    Object? cabinetId = freezed,
    Object? categoryId = freezed,
    Object? roomId = freezed,
    Object? homeId = freezed,
  }) {
    return _then(_value.copyWith(
      itemId: freezed == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String?,
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeId: freezed == homeId
          ? _value.homeId
          : homeId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseItemRequestModelImplCopyWith<$Res>
    implements $WarehouseItemRequestModelCopyWith<$Res> {
  factory _$$WarehouseItemRequestModelImplCopyWith(
          _$WarehouseItemRequestModelImpl value,
          $Res Function(_$WarehouseItemRequestModelImpl) then) =
      __$$WarehouseItemRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'item_id') String? itemId,
      @JsonKey(name: 'cabinet_id') String? cabinetId,
      @JsonKey(name: 'category_id') String? categoryId,
      @JsonKey(name: 'room_id') String? roomId,
      @JsonKey(name: 'home_id') String? homeId});
}

/// @nodoc
class __$$WarehouseItemRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseItemRequestModelCopyWithImpl<$Res,
        _$WarehouseItemRequestModelImpl>
    implements _$$WarehouseItemRequestModelImplCopyWith<$Res> {
  __$$WarehouseItemRequestModelImplCopyWithImpl(
      _$WarehouseItemRequestModelImpl _value,
      $Res Function(_$WarehouseItemRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = freezed,
    Object? cabinetId = freezed,
    Object? categoryId = freezed,
    Object? roomId = freezed,
    Object? homeId = freezed,
  }) {
    return _then(_$WarehouseItemRequestModelImpl(
      itemId: freezed == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String?,
      cabinetId: freezed == cabinetId
          ? _value.cabinetId
          : cabinetId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeId: freezed == homeId
          ? _value.homeId
          : homeId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseItemRequestModelImpl implements _WarehouseItemRequestModel {
  _$WarehouseItemRequestModelImpl(
      {@JsonKey(name: 'item_id') this.itemId,
      @JsonKey(name: 'cabinet_id') this.cabinetId,
      @JsonKey(name: 'category_id') this.categoryId,
      @JsonKey(name: 'room_id') this.roomId,
      @JsonKey(name: 'home_id') this.homeId});

  factory _$WarehouseItemRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WarehouseItemRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'item_id')
  final String? itemId;
  @override
  @JsonKey(name: 'cabinet_id')
  final String? cabinetId;
  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  @JsonKey(name: 'room_id')
  final String? roomId;
  @override
  @JsonKey(name: 'home_id')
  final String? homeId;

  @override
  String toString() {
    return 'WarehouseItemRequestModel(itemId: $itemId, cabinetId: $cabinetId, categoryId: $categoryId, roomId: $roomId, homeId: $homeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseItemRequestModelImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.cabinetId, cabinetId) ||
                other.cabinetId == cabinetId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.homeId, homeId) || other.homeId == homeId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, itemId, cabinetId, categoryId, roomId, homeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseItemRequestModelImplCopyWith<_$WarehouseItemRequestModelImpl>
      get copyWith => __$$WarehouseItemRequestModelImplCopyWithImpl<
          _$WarehouseItemRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseItemRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseItemRequestModel implements WarehouseItemRequestModel {
  factory _WarehouseItemRequestModel(
          {@JsonKey(name: 'item_id') final String? itemId,
          @JsonKey(name: 'cabinet_id') final String? cabinetId,
          @JsonKey(name: 'category_id') final String? categoryId,
          @JsonKey(name: 'room_id') final String? roomId,
          @JsonKey(name: 'home_id') final String? homeId}) =
      _$WarehouseItemRequestModelImpl;

  factory _WarehouseItemRequestModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseItemRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'item_id')
  String? get itemId;
  @override
  @JsonKey(name: 'cabinet_id')
  String? get cabinetId;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  @JsonKey(name: 'room_id')
  String? get roomId;
  @override
  @JsonKey(name: 'home_id')
  String? get homeId;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseItemRequestModelImplCopyWith<_$WarehouseItemRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
