// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Log _$LogFromJson(Map<String, dynamic> json) {
  return _Log.fromJson(json);
}

/// @nodoc
mixin _$Log {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'operate_type')
  int? get operateType => throw _privateConstructorUsedError;
  @JsonKey(name: 'entity_type')
  int? get entityType => throw _privateConstructorUsedError;
  @JsonKey(name: 'record_type')
  int? get recordType => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_name')
  List<String?>? get itemName => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_description')
  List<String?>? get itemDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_photo')
  List<String?>? get itemPhoto => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_min_stock_count')
  List<int?>? get itemMinStockCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_quantity')
  ItemQuantity? get itemQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_position')
  ItemPosition? get itemPosition => throw _privateConstructorUsedError;
  @JsonKey(name: 'cabinet_room_name')
  List<String?>? get cabinetRoomName => throw _privateConstructorUsedError;
  @JsonKey(name: 'cabinet_name')
  List<String?>? get cabinetName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  List<String?>? get categoryName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LogCopyWith<Log> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogCopyWith<$Res> {
  factory $LogCopyWith(Log value, $Res Function(Log) then) =
      _$LogCopyWithImpl<$Res, Log>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'created_at') int? createdAt,
      @JsonKey(name: 'operate_type') int? operateType,
      @JsonKey(name: 'entity_type') int? entityType,
      @JsonKey(name: 'record_type') int? recordType,
      @JsonKey(name: 'item_name') List<String?>? itemName,
      @JsonKey(name: 'item_description') List<String?>? itemDescription,
      @JsonKey(name: 'item_photo') List<String?>? itemPhoto,
      @JsonKey(name: 'item_min_stock_count') List<int?>? itemMinStockCount,
      @JsonKey(name: 'item_quantity') ItemQuantity? itemQuantity,
      @JsonKey(name: 'item_position') ItemPosition? itemPosition,
      @JsonKey(name: 'cabinet_room_name') List<String?>? cabinetRoomName,
      @JsonKey(name: 'cabinet_name') List<String?>? cabinetName,
      @JsonKey(name: 'category_name') List<String?>? categoryName});

  $ItemQuantityCopyWith<$Res>? get itemQuantity;
  $ItemPositionCopyWith<$Res>? get itemPosition;
}

/// @nodoc
class _$LogCopyWithImpl<$Res, $Val extends Log> implements $LogCopyWith<$Res> {
  _$LogCopyWithImpl(this._value, this._then);

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
    Object? createdAt = freezed,
    Object? operateType = freezed,
    Object? entityType = freezed,
    Object? recordType = freezed,
    Object? itemName = freezed,
    Object? itemDescription = freezed,
    Object? itemPhoto = freezed,
    Object? itemMinStockCount = freezed,
    Object? itemQuantity = freezed,
    Object? itemPosition = freezed,
    Object? cabinetRoomName = freezed,
    Object? cabinetName = freezed,
    Object? categoryName = freezed,
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
      operateType: freezed == operateType
          ? _value.operateType
          : operateType // ignore: cast_nullable_to_non_nullable
              as int?,
      entityType: freezed == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as int?,
      recordType: freezed == recordType
          ? _value.recordType
          : recordType // ignore: cast_nullable_to_non_nullable
              as int?,
      itemName: freezed == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      itemDescription: freezed == itemDescription
          ? _value.itemDescription
          : itemDescription // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      itemPhoto: freezed == itemPhoto
          ? _value.itemPhoto
          : itemPhoto // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      itemMinStockCount: freezed == itemMinStockCount
          ? _value.itemMinStockCount
          : itemMinStockCount // ignore: cast_nullable_to_non_nullable
              as List<int?>?,
      itemQuantity: freezed == itemQuantity
          ? _value.itemQuantity
          : itemQuantity // ignore: cast_nullable_to_non_nullable
              as ItemQuantity?,
      itemPosition: freezed == itemPosition
          ? _value.itemPosition
          : itemPosition // ignore: cast_nullable_to_non_nullable
              as ItemPosition?,
      cabinetRoomName: freezed == cabinetRoomName
          ? _value.cabinetRoomName
          : cabinetRoomName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      cabinetName: freezed == cabinetName
          ? _value.cabinetName
          : cabinetName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ItemQuantityCopyWith<$Res>? get itemQuantity {
    if (_value.itemQuantity == null) {
      return null;
    }

    return $ItemQuantityCopyWith<$Res>(_value.itemQuantity!, (value) {
      return _then(_value.copyWith(itemQuantity: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ItemPositionCopyWith<$Res>? get itemPosition {
    if (_value.itemPosition == null) {
      return null;
    }

    return $ItemPositionCopyWith<$Res>(_value.itemPosition!, (value) {
      return _then(_value.copyWith(itemPosition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LogImplCopyWith<$Res> implements $LogCopyWith<$Res> {
  factory _$$LogImplCopyWith(_$LogImpl value, $Res Function(_$LogImpl) then) =
      __$$LogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'created_at') int? createdAt,
      @JsonKey(name: 'operate_type') int? operateType,
      @JsonKey(name: 'entity_type') int? entityType,
      @JsonKey(name: 'record_type') int? recordType,
      @JsonKey(name: 'item_name') List<String?>? itemName,
      @JsonKey(name: 'item_description') List<String?>? itemDescription,
      @JsonKey(name: 'item_photo') List<String?>? itemPhoto,
      @JsonKey(name: 'item_min_stock_count') List<int?>? itemMinStockCount,
      @JsonKey(name: 'item_quantity') ItemQuantity? itemQuantity,
      @JsonKey(name: 'item_position') ItemPosition? itemPosition,
      @JsonKey(name: 'cabinet_room_name') List<String?>? cabinetRoomName,
      @JsonKey(name: 'cabinet_name') List<String?>? cabinetName,
      @JsonKey(name: 'category_name') List<String?>? categoryName});

  @override
  $ItemQuantityCopyWith<$Res>? get itemQuantity;
  @override
  $ItemPositionCopyWith<$Res>? get itemPosition;
}

/// @nodoc
class __$$LogImplCopyWithImpl<$Res> extends _$LogCopyWithImpl<$Res, _$LogImpl>
    implements _$$LogImplCopyWith<$Res> {
  __$$LogImplCopyWithImpl(_$LogImpl _value, $Res Function(_$LogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? householdId = freezed,
    Object? userName = freezed,
    Object? createdAt = freezed,
    Object? operateType = freezed,
    Object? entityType = freezed,
    Object? recordType = freezed,
    Object? itemName = freezed,
    Object? itemDescription = freezed,
    Object? itemPhoto = freezed,
    Object? itemMinStockCount = freezed,
    Object? itemQuantity = freezed,
    Object? itemPosition = freezed,
    Object? cabinetRoomName = freezed,
    Object? cabinetName = freezed,
    Object? categoryName = freezed,
  }) {
    return _then(_$LogImpl(
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
      operateType: freezed == operateType
          ? _value.operateType
          : operateType // ignore: cast_nullable_to_non_nullable
              as int?,
      entityType: freezed == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as int?,
      recordType: freezed == recordType
          ? _value.recordType
          : recordType // ignore: cast_nullable_to_non_nullable
              as int?,
      itemName: freezed == itemName
          ? _value._itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      itemDescription: freezed == itemDescription
          ? _value._itemDescription
          : itemDescription // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      itemPhoto: freezed == itemPhoto
          ? _value._itemPhoto
          : itemPhoto // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      itemMinStockCount: freezed == itemMinStockCount
          ? _value._itemMinStockCount
          : itemMinStockCount // ignore: cast_nullable_to_non_nullable
              as List<int?>?,
      itemQuantity: freezed == itemQuantity
          ? _value.itemQuantity
          : itemQuantity // ignore: cast_nullable_to_non_nullable
              as ItemQuantity?,
      itemPosition: freezed == itemPosition
          ? _value.itemPosition
          : itemPosition // ignore: cast_nullable_to_non_nullable
              as ItemPosition?,
      cabinetRoomName: freezed == cabinetRoomName
          ? _value._cabinetRoomName
          : cabinetRoomName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      cabinetName: freezed == cabinetName
          ? _value._cabinetName
          : cabinetName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      categoryName: freezed == categoryName
          ? _value._categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LogImpl implements _Log {
  _$LogImpl(
      {this.id,
      @JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'user_name') this.userName,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'operate_type') this.operateType,
      @JsonKey(name: 'entity_type') this.entityType,
      @JsonKey(name: 'record_type') this.recordType,
      @JsonKey(name: 'item_name') final List<String?>? itemName,
      @JsonKey(name: 'item_description') final List<String?>? itemDescription,
      @JsonKey(name: 'item_photo') final List<String?>? itemPhoto,
      @JsonKey(name: 'item_min_stock_count')
      final List<int?>? itemMinStockCount,
      @JsonKey(name: 'item_quantity') this.itemQuantity,
      @JsonKey(name: 'item_position') this.itemPosition,
      @JsonKey(name: 'cabinet_room_name') final List<String?>? cabinetRoomName,
      @JsonKey(name: 'cabinet_name') final List<String?>? cabinetName,
      @JsonKey(name: 'category_name') final List<String?>? categoryName})
      : _itemName = itemName,
        _itemDescription = itemDescription,
        _itemPhoto = itemPhoto,
        _itemMinStockCount = itemMinStockCount,
        _cabinetRoomName = cabinetRoomName,
        _cabinetName = cabinetName,
        _categoryName = categoryName;

  factory _$LogImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  @override
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @override
  @JsonKey(name: 'operate_type')
  final int? operateType;
  @override
  @JsonKey(name: 'entity_type')
  final int? entityType;
  @override
  @JsonKey(name: 'record_type')
  final int? recordType;
  final List<String?>? _itemName;
  @override
  @JsonKey(name: 'item_name')
  List<String?>? get itemName {
    final value = _itemName;
    if (value == null) return null;
    if (_itemName is EqualUnmodifiableListView) return _itemName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String?>? _itemDescription;
  @override
  @JsonKey(name: 'item_description')
  List<String?>? get itemDescription {
    final value = _itemDescription;
    if (value == null) return null;
    if (_itemDescription is EqualUnmodifiableListView) return _itemDescription;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String?>? _itemPhoto;
  @override
  @JsonKey(name: 'item_photo')
  List<String?>? get itemPhoto {
    final value = _itemPhoto;
    if (value == null) return null;
    if (_itemPhoto is EqualUnmodifiableListView) return _itemPhoto;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int?>? _itemMinStockCount;
  @override
  @JsonKey(name: 'item_min_stock_count')
  List<int?>? get itemMinStockCount {
    final value = _itemMinStockCount;
    if (value == null) return null;
    if (_itemMinStockCount is EqualUnmodifiableListView)
      return _itemMinStockCount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'item_quantity')
  final ItemQuantity? itemQuantity;
  @override
  @JsonKey(name: 'item_position')
  final ItemPosition? itemPosition;
  final List<String?>? _cabinetRoomName;
  @override
  @JsonKey(name: 'cabinet_room_name')
  List<String?>? get cabinetRoomName {
    final value = _cabinetRoomName;
    if (value == null) return null;
    if (_cabinetRoomName is EqualUnmodifiableListView) return _cabinetRoomName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String?>? _cabinetName;
  @override
  @JsonKey(name: 'cabinet_name')
  List<String?>? get cabinetName {
    final value = _cabinetName;
    if (value == null) return null;
    if (_cabinetName is EqualUnmodifiableListView) return _cabinetName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String?>? _categoryName;
  @override
  @JsonKey(name: 'category_name')
  List<String?>? get categoryName {
    final value = _categoryName;
    if (value == null) return null;
    if (_categoryName is EqualUnmodifiableListView) return _categoryName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Log(id: $id, householdId: $householdId, userName: $userName, createdAt: $createdAt, operateType: $operateType, entityType: $entityType, recordType: $recordType, itemName: $itemName, itemDescription: $itemDescription, itemPhoto: $itemPhoto, itemMinStockCount: $itemMinStockCount, itemQuantity: $itemQuantity, itemPosition: $itemPosition, cabinetRoomName: $cabinetRoomName, cabinetName: $cabinetName, categoryName: $categoryName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.operateType, operateType) ||
                other.operateType == operateType) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.recordType, recordType) ||
                other.recordType == recordType) &&
            const DeepCollectionEquality().equals(other._itemName, _itemName) &&
            const DeepCollectionEquality()
                .equals(other._itemDescription, _itemDescription) &&
            const DeepCollectionEquality()
                .equals(other._itemPhoto, _itemPhoto) &&
            const DeepCollectionEquality()
                .equals(other._itemMinStockCount, _itemMinStockCount) &&
            (identical(other.itemQuantity, itemQuantity) ||
                other.itemQuantity == itemQuantity) &&
            (identical(other.itemPosition, itemPosition) ||
                other.itemPosition == itemPosition) &&
            const DeepCollectionEquality()
                .equals(other._cabinetRoomName, _cabinetRoomName) &&
            const DeepCollectionEquality()
                .equals(other._cabinetName, _cabinetName) &&
            const DeepCollectionEquality()
                .equals(other._categoryName, _categoryName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      householdId,
      userName,
      createdAt,
      operateType,
      entityType,
      recordType,
      const DeepCollectionEquality().hash(_itemName),
      const DeepCollectionEquality().hash(_itemDescription),
      const DeepCollectionEquality().hash(_itemPhoto),
      const DeepCollectionEquality().hash(_itemMinStockCount),
      itemQuantity,
      itemPosition,
      const DeepCollectionEquality().hash(_cabinetRoomName),
      const DeepCollectionEquality().hash(_cabinetName),
      const DeepCollectionEquality().hash(_categoryName));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LogImplCopyWith<_$LogImpl> get copyWith =>
      __$$LogImplCopyWithImpl<_$LogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LogImplToJson(
      this,
    );
  }
}

abstract class _Log implements Log {
  factory _Log(
      {final String? id,
      @JsonKey(name: 'household_id') final String? householdId,
      @JsonKey(name: 'user_name') final String? userName,
      @JsonKey(name: 'created_at') final int? createdAt,
      @JsonKey(name: 'operate_type') final int? operateType,
      @JsonKey(name: 'entity_type') final int? entityType,
      @JsonKey(name: 'record_type') final int? recordType,
      @JsonKey(name: 'item_name') final List<String?>? itemName,
      @JsonKey(name: 'item_description') final List<String?>? itemDescription,
      @JsonKey(name: 'item_photo') final List<String?>? itemPhoto,
      @JsonKey(name: 'item_min_stock_count')
      final List<int?>? itemMinStockCount,
      @JsonKey(name: 'item_quantity') final ItemQuantity? itemQuantity,
      @JsonKey(name: 'item_position') final ItemPosition? itemPosition,
      @JsonKey(name: 'cabinet_room_name') final List<String?>? cabinetRoomName,
      @JsonKey(name: 'cabinet_name') final List<String?>? cabinetName,
      @JsonKey(name: 'category_name')
      final List<String?>? categoryName}) = _$LogImpl;

  factory _Log.fromJson(Map<String, dynamic> json) = _$LogImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  @JsonKey(name: 'created_at')
  int? get createdAt;
  @override
  @JsonKey(name: 'operate_type')
  int? get operateType;
  @override
  @JsonKey(name: 'entity_type')
  int? get entityType;
  @override
  @JsonKey(name: 'record_type')
  int? get recordType;
  @override
  @JsonKey(name: 'item_name')
  List<String?>? get itemName;
  @override
  @JsonKey(name: 'item_description')
  List<String?>? get itemDescription;
  @override
  @JsonKey(name: 'item_photo')
  List<String?>? get itemPhoto;
  @override
  @JsonKey(name: 'item_min_stock_count')
  List<int?>? get itemMinStockCount;
  @override
  @JsonKey(name: 'item_quantity')
  ItemQuantity? get itemQuantity;
  @override
  @JsonKey(name: 'item_position')
  ItemPosition? get itemPosition;
  @override
  @JsonKey(name: 'cabinet_room_name')
  List<String?>? get cabinetRoomName;
  @override
  @JsonKey(name: 'cabinet_name')
  List<String?>? get cabinetName;
  @override
  @JsonKey(name: 'category_name')
  List<String?>? get categoryName;
  @override
  @JsonKey(ignore: true)
  _$$LogImplCopyWith<_$LogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemQuantity _$ItemQuantityFromJson(Map<String, dynamic> json) {
  return _ItemQuantity.fromJson(json);
}

/// @nodoc
mixin _$ItemQuantity {
  @JsonKey(name: 'total_count')
  List<int?>? get totalCount => throw _privateConstructorUsedError;
  List<ItemQuantityCabinet>? get cabinets => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemQuantityCopyWith<ItemQuantity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemQuantityCopyWith<$Res> {
  factory $ItemQuantityCopyWith(
          ItemQuantity value, $Res Function(ItemQuantity) then) =
      _$ItemQuantityCopyWithImpl<$Res, ItemQuantity>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_count') List<int?>? totalCount,
      List<ItemQuantityCabinet>? cabinets});
}

/// @nodoc
class _$ItemQuantityCopyWithImpl<$Res, $Val extends ItemQuantity>
    implements $ItemQuantityCopyWith<$Res> {
  _$ItemQuantityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = freezed,
    Object? cabinets = freezed,
  }) {
    return _then(_value.copyWith(
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as List<int?>?,
      cabinets: freezed == cabinets
          ? _value.cabinets
          : cabinets // ignore: cast_nullable_to_non_nullable
              as List<ItemQuantityCabinet>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemQuantityImplCopyWith<$Res>
    implements $ItemQuantityCopyWith<$Res> {
  factory _$$ItemQuantityImplCopyWith(
          _$ItemQuantityImpl value, $Res Function(_$ItemQuantityImpl) then) =
      __$$ItemQuantityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_count') List<int?>? totalCount,
      List<ItemQuantityCabinet>? cabinets});
}

/// @nodoc
class __$$ItemQuantityImplCopyWithImpl<$Res>
    extends _$ItemQuantityCopyWithImpl<$Res, _$ItemQuantityImpl>
    implements _$$ItemQuantityImplCopyWith<$Res> {
  __$$ItemQuantityImplCopyWithImpl(
      _$ItemQuantityImpl _value, $Res Function(_$ItemQuantityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = freezed,
    Object? cabinets = freezed,
  }) {
    return _then(_$ItemQuantityImpl(
      totalCount: freezed == totalCount
          ? _value._totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as List<int?>?,
      cabinets: freezed == cabinets
          ? _value._cabinets
          : cabinets // ignore: cast_nullable_to_non_nullable
              as List<ItemQuantityCabinet>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemQuantityImpl implements _ItemQuantity {
  _$ItemQuantityImpl(
      {@JsonKey(name: 'total_count') final List<int?>? totalCount,
      final List<ItemQuantityCabinet>? cabinets})
      : _totalCount = totalCount,
        _cabinets = cabinets;

  factory _$ItemQuantityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemQuantityImplFromJson(json);

  final List<int?>? _totalCount;
  @override
  @JsonKey(name: 'total_count')
  List<int?>? get totalCount {
    final value = _totalCount;
    if (value == null) return null;
    if (_totalCount is EqualUnmodifiableListView) return _totalCount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ItemQuantityCabinet>? _cabinets;
  @override
  List<ItemQuantityCabinet>? get cabinets {
    final value = _cabinets;
    if (value == null) return null;
    if (_cabinets is EqualUnmodifiableListView) return _cabinets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ItemQuantity(totalCount: $totalCount, cabinets: $cabinets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemQuantityImpl &&
            const DeepCollectionEquality()
                .equals(other._totalCount, _totalCount) &&
            const DeepCollectionEquality().equals(other._cabinets, _cabinets));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_totalCount),
      const DeepCollectionEquality().hash(_cabinets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemQuantityImplCopyWith<_$ItemQuantityImpl> get copyWith =>
      __$$ItemQuantityImplCopyWithImpl<_$ItemQuantityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemQuantityImplToJson(
      this,
    );
  }
}

abstract class _ItemQuantity implements ItemQuantity {
  factory _ItemQuantity(
      {@JsonKey(name: 'total_count') final List<int?>? totalCount,
      final List<ItemQuantityCabinet>? cabinets}) = _$ItemQuantityImpl;

  factory _ItemQuantity.fromJson(Map<String, dynamic> json) =
      _$ItemQuantityImpl.fromJson;

  @override
  @JsonKey(name: 'total_count')
  List<int?>? get totalCount;
  @override
  List<ItemQuantityCabinet>? get cabinets;
  @override
  @JsonKey(ignore: true)
  _$$ItemQuantityImplCopyWith<_$ItemQuantityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemQuantityCabinet _$ItemQuantityCabinetFromJson(Map<String, dynamic> json) {
  return _ItemQuantityCabinet.fromJson(json);
}

/// @nodoc
mixin _$ItemQuantityCabinet {
  @JsonKey(name: 'cabinet_name')
  String? get cabinetName => throw _privateConstructorUsedError;
  List<int?>? get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemQuantityCabinetCopyWith<ItemQuantityCabinet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemQuantityCabinetCopyWith<$Res> {
  factory $ItemQuantityCabinetCopyWith(
          ItemQuantityCabinet value, $Res Function(ItemQuantityCabinet) then) =
      _$ItemQuantityCabinetCopyWithImpl<$Res, ItemQuantityCabinet>;
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_name') String? cabinetName, List<int?>? count});
}

/// @nodoc
class _$ItemQuantityCabinetCopyWithImpl<$Res, $Val extends ItemQuantityCabinet>
    implements $ItemQuantityCabinetCopyWith<$Res> {
  _$ItemQuantityCabinetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetName = freezed,
    Object? count = freezed,
  }) {
    return _then(_value.copyWith(
      cabinetName: freezed == cabinetName
          ? _value.cabinetName
          : cabinetName // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as List<int?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemQuantityCabinetImplCopyWith<$Res>
    implements $ItemQuantityCabinetCopyWith<$Res> {
  factory _$$ItemQuantityCabinetImplCopyWith(_$ItemQuantityCabinetImpl value,
          $Res Function(_$ItemQuantityCabinetImpl) then) =
      __$$ItemQuantityCabinetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_name') String? cabinetName, List<int?>? count});
}

/// @nodoc
class __$$ItemQuantityCabinetImplCopyWithImpl<$Res>
    extends _$ItemQuantityCabinetCopyWithImpl<$Res, _$ItemQuantityCabinetImpl>
    implements _$$ItemQuantityCabinetImplCopyWith<$Res> {
  __$$ItemQuantityCabinetImplCopyWithImpl(_$ItemQuantityCabinetImpl _value,
      $Res Function(_$ItemQuantityCabinetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetName = freezed,
    Object? count = freezed,
  }) {
    return _then(_$ItemQuantityCabinetImpl(
      cabinetName: freezed == cabinetName
          ? _value.cabinetName
          : cabinetName // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _value._count
          : count // ignore: cast_nullable_to_non_nullable
              as List<int?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemQuantityCabinetImpl implements _ItemQuantityCabinet {
  _$ItemQuantityCabinetImpl(
      {@JsonKey(name: 'cabinet_name') this.cabinetName,
      final List<int?>? count})
      : _count = count;

  factory _$ItemQuantityCabinetImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemQuantityCabinetImplFromJson(json);

  @override
  @JsonKey(name: 'cabinet_name')
  final String? cabinetName;
  final List<int?>? _count;
  @override
  List<int?>? get count {
    final value = _count;
    if (value == null) return null;
    if (_count is EqualUnmodifiableListView) return _count;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ItemQuantityCabinet(cabinetName: $cabinetName, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemQuantityCabinetImpl &&
            (identical(other.cabinetName, cabinetName) ||
                other.cabinetName == cabinetName) &&
            const DeepCollectionEquality().equals(other._count, _count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, cabinetName, const DeepCollectionEquality().hash(_count));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemQuantityCabinetImplCopyWith<_$ItemQuantityCabinetImpl> get copyWith =>
      __$$ItemQuantityCabinetImplCopyWithImpl<_$ItemQuantityCabinetImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemQuantityCabinetImplToJson(
      this,
    );
  }
}

abstract class _ItemQuantityCabinet implements ItemQuantityCabinet {
  factory _ItemQuantityCabinet(
      {@JsonKey(name: 'cabinet_name') final String? cabinetName,
      final List<int?>? count}) = _$ItemQuantityCabinetImpl;

  factory _ItemQuantityCabinet.fromJson(Map<String, dynamic> json) =
      _$ItemQuantityCabinetImpl.fromJson;

  @override
  @JsonKey(name: 'cabinet_name')
  String? get cabinetName;
  @override
  List<int?>? get count;
  @override
  @JsonKey(ignore: true)
  _$$ItemQuantityCabinetImplCopyWith<_$ItemQuantityCabinetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemPosition _$ItemPositionFromJson(Map<String, dynamic> json) {
  return _ItemPosition.fromJson(json);
}

/// @nodoc
mixin _$ItemPosition {
  List<ItemPositionCabinet>? get cabinets => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemPositionCopyWith<ItemPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemPositionCopyWith<$Res> {
  factory $ItemPositionCopyWith(
          ItemPosition value, $Res Function(ItemPosition) then) =
      _$ItemPositionCopyWithImpl<$Res, ItemPosition>;
  @useResult
  $Res call({List<ItemPositionCabinet>? cabinets});
}

/// @nodoc
class _$ItemPositionCopyWithImpl<$Res, $Val extends ItemPosition>
    implements $ItemPositionCopyWith<$Res> {
  _$ItemPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinets = freezed,
  }) {
    return _then(_value.copyWith(
      cabinets: freezed == cabinets
          ? _value.cabinets
          : cabinets // ignore: cast_nullable_to_non_nullable
              as List<ItemPositionCabinet>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemPositionImplCopyWith<$Res>
    implements $ItemPositionCopyWith<$Res> {
  factory _$$ItemPositionImplCopyWith(
          _$ItemPositionImpl value, $Res Function(_$ItemPositionImpl) then) =
      __$$ItemPositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ItemPositionCabinet>? cabinets});
}

/// @nodoc
class __$$ItemPositionImplCopyWithImpl<$Res>
    extends _$ItemPositionCopyWithImpl<$Res, _$ItemPositionImpl>
    implements _$$ItemPositionImplCopyWith<$Res> {
  __$$ItemPositionImplCopyWithImpl(
      _$ItemPositionImpl _value, $Res Function(_$ItemPositionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinets = freezed,
  }) {
    return _then(_$ItemPositionImpl(
      cabinets: freezed == cabinets
          ? _value._cabinets
          : cabinets // ignore: cast_nullable_to_non_nullable
              as List<ItemPositionCabinet>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemPositionImpl implements _ItemPosition {
  _$ItemPositionImpl({final List<ItemPositionCabinet>? cabinets})
      : _cabinets = cabinets;

  factory _$ItemPositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemPositionImplFromJson(json);

  final List<ItemPositionCabinet>? _cabinets;
  @override
  List<ItemPositionCabinet>? get cabinets {
    final value = _cabinets;
    if (value == null) return null;
    if (_cabinets is EqualUnmodifiableListView) return _cabinets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ItemPosition(cabinets: $cabinets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemPositionImpl &&
            const DeepCollectionEquality().equals(other._cabinets, _cabinets));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cabinets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemPositionImplCopyWith<_$ItemPositionImpl> get copyWith =>
      __$$ItemPositionImplCopyWithImpl<_$ItemPositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemPositionImplToJson(
      this,
    );
  }
}

abstract class _ItemPosition implements ItemPosition {
  factory _ItemPosition({final List<ItemPositionCabinet>? cabinets}) =
      _$ItemPositionImpl;

  factory _ItemPosition.fromJson(Map<String, dynamic> json) =
      _$ItemPositionImpl.fromJson;

  @override
  List<ItemPositionCabinet>? get cabinets;
  @override
  @JsonKey(ignore: true)
  _$$ItemPositionImplCopyWith<_$ItemPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemPositionCabinet _$ItemPositionCabinetFromJson(Map<String, dynamic> json) {
  return _ItemPositionCabinet.fromJson(json);
}

/// @nodoc
mixin _$ItemPositionCabinet {
  @JsonKey(name: 'cabinet_name')
  List<String?>? get cabinetName => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemPositionCabinetCopyWith<ItemPositionCabinet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemPositionCabinetCopyWith<$Res> {
  factory $ItemPositionCabinetCopyWith(
          ItemPositionCabinet value, $Res Function(ItemPositionCabinet) then) =
      _$ItemPositionCabinetCopyWithImpl<$Res, ItemPositionCabinet>;
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_name') List<String?>? cabinetName, int? count});
}

/// @nodoc
class _$ItemPositionCabinetCopyWithImpl<$Res, $Val extends ItemPositionCabinet>
    implements $ItemPositionCabinetCopyWith<$Res> {
  _$ItemPositionCabinetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetName = freezed,
    Object? count = freezed,
  }) {
    return _then(_value.copyWith(
      cabinetName: freezed == cabinetName
          ? _value.cabinetName
          : cabinetName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemPositionCabinetImplCopyWith<$Res>
    implements $ItemPositionCabinetCopyWith<$Res> {
  factory _$$ItemPositionCabinetImplCopyWith(_$ItemPositionCabinetImpl value,
          $Res Function(_$ItemPositionCabinetImpl) then) =
      __$$ItemPositionCabinetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_name') List<String?>? cabinetName, int? count});
}

/// @nodoc
class __$$ItemPositionCabinetImplCopyWithImpl<$Res>
    extends _$ItemPositionCabinetCopyWithImpl<$Res, _$ItemPositionCabinetImpl>
    implements _$$ItemPositionCabinetImplCopyWith<$Res> {
  __$$ItemPositionCabinetImplCopyWithImpl(_$ItemPositionCabinetImpl _value,
      $Res Function(_$ItemPositionCabinetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetName = freezed,
    Object? count = freezed,
  }) {
    return _then(_$ItemPositionCabinetImpl(
      cabinetName: freezed == cabinetName
          ? _value._cabinetName
          : cabinetName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemPositionCabinetImpl implements _ItemPositionCabinet {
  _$ItemPositionCabinetImpl(
      {@JsonKey(name: 'cabinet_name') final List<String?>? cabinetName,
      this.count})
      : _cabinetName = cabinetName;

  factory _$ItemPositionCabinetImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemPositionCabinetImplFromJson(json);

  final List<String?>? _cabinetName;
  @override
  @JsonKey(name: 'cabinet_name')
  List<String?>? get cabinetName {
    final value = _cabinetName;
    if (value == null) return null;
    if (_cabinetName is EqualUnmodifiableListView) return _cabinetName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? count;

  @override
  String toString() {
    return 'ItemPositionCabinet(cabinetName: $cabinetName, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemPositionCabinetImpl &&
            const DeepCollectionEquality()
                .equals(other._cabinetName, _cabinetName) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cabinetName), count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemPositionCabinetImplCopyWith<_$ItemPositionCabinetImpl> get copyWith =>
      __$$ItemPositionCabinetImplCopyWithImpl<_$ItemPositionCabinetImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemPositionCabinetImplToJson(
      this,
    );
  }
}

abstract class _ItemPositionCabinet implements ItemPositionCabinet {
  factory _ItemPositionCabinet(
      {@JsonKey(name: 'cabinet_name') final List<String?>? cabinetName,
      final int? count}) = _$ItemPositionCabinetImpl;

  factory _ItemPositionCabinet.fromJson(Map<String, dynamic> json) =
      _$ItemPositionCabinetImpl.fromJson;

  @override
  @JsonKey(name: 'cabinet_name')
  List<String?>? get cabinetName;
  @override
  int? get count;
  @override
  @JsonKey(ignore: true)
  _$$ItemPositionCabinetImplCopyWith<_$ItemPositionCabinetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
