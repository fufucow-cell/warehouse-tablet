// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemRecord _$ItemRecordFromJson(Map<String, dynamic> json) {
  return _ItemRecord.fromJson(json);
}

/// @nodoc
mixin _$ItemRecord {
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
  @JsonKey(name: 'item_name')
  List<String>? get itemName => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_description')
  List<String>? get itemDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_photo')
  List<String>? get itemPhoto => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_min_stock_count')
  List<int>? get itemMinStockCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  List<String>? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'cabinet_name')
  List<String>? get cabinetName => throw _privateConstructorUsedError;
  @JsonKey(name: 'cabinet_room_name')
  List<String>? get cabinetRoomName => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_position')
  List<ItemPosition>? get itemPosition => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_quantity')
  ItemQuantity? get itemQuantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemRecordCopyWith<ItemRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemRecordCopyWith<$Res> {
  factory $ItemRecordCopyWith(
          ItemRecord value, $Res Function(ItemRecord) then) =
      _$ItemRecordCopyWithImpl<$Res, ItemRecord>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'created_at') int? createdAt,
      @JsonKey(name: 'operate_type') int? operateType,
      @JsonKey(name: 'entity_type') int? entityType,
      @JsonKey(name: 'item_name') List<String>? itemName,
      @JsonKey(name: 'item_description') List<String>? itemDescription,
      @JsonKey(name: 'item_photo') List<String>? itemPhoto,
      @JsonKey(name: 'item_min_stock_count') List<int>? itemMinStockCount,
      @JsonKey(name: 'category_name') List<String>? categoryName,
      @JsonKey(name: 'cabinet_name') List<String>? cabinetName,
      @JsonKey(name: 'cabinet_room_name') List<String>? cabinetRoomName,
      @JsonKey(name: 'item_position') List<ItemPosition>? itemPosition,
      @JsonKey(name: 'item_quantity') ItemQuantity? itemQuantity});

  $ItemQuantityCopyWith<$Res>? get itemQuantity;
}

/// @nodoc
class _$ItemRecordCopyWithImpl<$Res, $Val extends ItemRecord>
    implements $ItemRecordCopyWith<$Res> {
  _$ItemRecordCopyWithImpl(this._value, this._then);

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
    Object? itemName = freezed,
    Object? itemDescription = freezed,
    Object? itemPhoto = freezed,
    Object? itemMinStockCount = freezed,
    Object? categoryName = freezed,
    Object? cabinetName = freezed,
    Object? cabinetRoomName = freezed,
    Object? itemPosition = freezed,
    Object? itemQuantity = freezed,
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
      itemName: freezed == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      itemDescription: freezed == itemDescription
          ? _value.itemDescription
          : itemDescription // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      itemPhoto: freezed == itemPhoto
          ? _value.itemPhoto
          : itemPhoto // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      itemMinStockCount: freezed == itemMinStockCount
          ? _value.itemMinStockCount
          : itemMinStockCount // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      cabinetName: freezed == cabinetName
          ? _value.cabinetName
          : cabinetName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      cabinetRoomName: freezed == cabinetRoomName
          ? _value.cabinetRoomName
          : cabinetRoomName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      itemPosition: freezed == itemPosition
          ? _value.itemPosition
          : itemPosition // ignore: cast_nullable_to_non_nullable
              as List<ItemPosition>?,
      itemQuantity: freezed == itemQuantity
          ? _value.itemQuantity
          : itemQuantity // ignore: cast_nullable_to_non_nullable
              as ItemQuantity?,
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
}

/// @nodoc
abstract class _$$ItemRecordImplCopyWith<$Res>
    implements $ItemRecordCopyWith<$Res> {
  factory _$$ItemRecordImplCopyWith(
          _$ItemRecordImpl value, $Res Function(_$ItemRecordImpl) then) =
      __$$ItemRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'created_at') int? createdAt,
      @JsonKey(name: 'operate_type') int? operateType,
      @JsonKey(name: 'entity_type') int? entityType,
      @JsonKey(name: 'item_name') List<String>? itemName,
      @JsonKey(name: 'item_description') List<String>? itemDescription,
      @JsonKey(name: 'item_photo') List<String>? itemPhoto,
      @JsonKey(name: 'item_min_stock_count') List<int>? itemMinStockCount,
      @JsonKey(name: 'category_name') List<String>? categoryName,
      @JsonKey(name: 'cabinet_name') List<String>? cabinetName,
      @JsonKey(name: 'cabinet_room_name') List<String>? cabinetRoomName,
      @JsonKey(name: 'item_position') List<ItemPosition>? itemPosition,
      @JsonKey(name: 'item_quantity') ItemQuantity? itemQuantity});

  @override
  $ItemQuantityCopyWith<$Res>? get itemQuantity;
}

/// @nodoc
class __$$ItemRecordImplCopyWithImpl<$Res>
    extends _$ItemRecordCopyWithImpl<$Res, _$ItemRecordImpl>
    implements _$$ItemRecordImplCopyWith<$Res> {
  __$$ItemRecordImplCopyWithImpl(
      _$ItemRecordImpl _value, $Res Function(_$ItemRecordImpl) _then)
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
    Object? itemName = freezed,
    Object? itemDescription = freezed,
    Object? itemPhoto = freezed,
    Object? itemMinStockCount = freezed,
    Object? categoryName = freezed,
    Object? cabinetName = freezed,
    Object? cabinetRoomName = freezed,
    Object? itemPosition = freezed,
    Object? itemQuantity = freezed,
  }) {
    return _then(_$ItemRecordImpl(
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
      itemName: freezed == itemName
          ? _value._itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      itemDescription: freezed == itemDescription
          ? _value._itemDescription
          : itemDescription // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      itemPhoto: freezed == itemPhoto
          ? _value._itemPhoto
          : itemPhoto // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      itemMinStockCount: freezed == itemMinStockCount
          ? _value._itemMinStockCount
          : itemMinStockCount // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      categoryName: freezed == categoryName
          ? _value._categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      cabinetName: freezed == cabinetName
          ? _value._cabinetName
          : cabinetName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      cabinetRoomName: freezed == cabinetRoomName
          ? _value._cabinetRoomName
          : cabinetRoomName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      itemPosition: freezed == itemPosition
          ? _value._itemPosition
          : itemPosition // ignore: cast_nullable_to_non_nullable
              as List<ItemPosition>?,
      itemQuantity: freezed == itemQuantity
          ? _value.itemQuantity
          : itemQuantity // ignore: cast_nullable_to_non_nullable
              as ItemQuantity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemRecordImpl implements _ItemRecord {
  _$ItemRecordImpl(
      {this.id,
      @JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'user_name') this.userName,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'operate_type') this.operateType,
      @JsonKey(name: 'entity_type') this.entityType,
      @JsonKey(name: 'item_name') final List<String>? itemName,
      @JsonKey(name: 'item_description') final List<String>? itemDescription,
      @JsonKey(name: 'item_photo') final List<String>? itemPhoto,
      @JsonKey(name: 'item_min_stock_count') final List<int>? itemMinStockCount,
      @JsonKey(name: 'category_name') final List<String>? categoryName,
      @JsonKey(name: 'cabinet_name') final List<String>? cabinetName,
      @JsonKey(name: 'cabinet_room_name') final List<String>? cabinetRoomName,
      @JsonKey(name: 'item_position') final List<ItemPosition>? itemPosition,
      @JsonKey(name: 'item_quantity') this.itemQuantity})
      : _itemName = itemName,
        _itemDescription = itemDescription,
        _itemPhoto = itemPhoto,
        _itemMinStockCount = itemMinStockCount,
        _categoryName = categoryName,
        _cabinetName = cabinetName,
        _cabinetRoomName = cabinetRoomName,
        _itemPosition = itemPosition;

  factory _$ItemRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemRecordImplFromJson(json);

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
  final List<String>? _itemName;
  @override
  @JsonKey(name: 'item_name')
  List<String>? get itemName {
    final value = _itemName;
    if (value == null) return null;
    if (_itemName is EqualUnmodifiableListView) return _itemName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _itemDescription;
  @override
  @JsonKey(name: 'item_description')
  List<String>? get itemDescription {
    final value = _itemDescription;
    if (value == null) return null;
    if (_itemDescription is EqualUnmodifiableListView) return _itemDescription;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _itemPhoto;
  @override
  @JsonKey(name: 'item_photo')
  List<String>? get itemPhoto {
    final value = _itemPhoto;
    if (value == null) return null;
    if (_itemPhoto is EqualUnmodifiableListView) return _itemPhoto;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _itemMinStockCount;
  @override
  @JsonKey(name: 'item_min_stock_count')
  List<int>? get itemMinStockCount {
    final value = _itemMinStockCount;
    if (value == null) return null;
    if (_itemMinStockCount is EqualUnmodifiableListView)
      return _itemMinStockCount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _categoryName;
  @override
  @JsonKey(name: 'category_name')
  List<String>? get categoryName {
    final value = _categoryName;
    if (value == null) return null;
    if (_categoryName is EqualUnmodifiableListView) return _categoryName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _cabinetName;
  @override
  @JsonKey(name: 'cabinet_name')
  List<String>? get cabinetName {
    final value = _cabinetName;
    if (value == null) return null;
    if (_cabinetName is EqualUnmodifiableListView) return _cabinetName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _cabinetRoomName;
  @override
  @JsonKey(name: 'cabinet_room_name')
  List<String>? get cabinetRoomName {
    final value = _cabinetRoomName;
    if (value == null) return null;
    if (_cabinetRoomName is EqualUnmodifiableListView) return _cabinetRoomName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ItemPosition>? _itemPosition;
  @override
  @JsonKey(name: 'item_position')
  List<ItemPosition>? get itemPosition {
    final value = _itemPosition;
    if (value == null) return null;
    if (_itemPosition is EqualUnmodifiableListView) return _itemPosition;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'item_quantity')
  final ItemQuantity? itemQuantity;

  @override
  String toString() {
    return 'ItemRecord(id: $id, householdId: $householdId, userName: $userName, createdAt: $createdAt, operateType: $operateType, entityType: $entityType, itemName: $itemName, itemDescription: $itemDescription, itemPhoto: $itemPhoto, itemMinStockCount: $itemMinStockCount, categoryName: $categoryName, cabinetName: $cabinetName, cabinetRoomName: $cabinetRoomName, itemPosition: $itemPosition, itemQuantity: $itemQuantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemRecordImpl &&
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
            const DeepCollectionEquality().equals(other._itemName, _itemName) &&
            const DeepCollectionEquality()
                .equals(other._itemDescription, _itemDescription) &&
            const DeepCollectionEquality()
                .equals(other._itemPhoto, _itemPhoto) &&
            const DeepCollectionEquality()
                .equals(other._itemMinStockCount, _itemMinStockCount) &&
            const DeepCollectionEquality()
                .equals(other._categoryName, _categoryName) &&
            const DeepCollectionEquality()
                .equals(other._cabinetName, _cabinetName) &&
            const DeepCollectionEquality()
                .equals(other._cabinetRoomName, _cabinetRoomName) &&
            const DeepCollectionEquality()
                .equals(other._itemPosition, _itemPosition) &&
            (identical(other.itemQuantity, itemQuantity) ||
                other.itemQuantity == itemQuantity));
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
      const DeepCollectionEquality().hash(_itemName),
      const DeepCollectionEquality().hash(_itemDescription),
      const DeepCollectionEquality().hash(_itemPhoto),
      const DeepCollectionEquality().hash(_itemMinStockCount),
      const DeepCollectionEquality().hash(_categoryName),
      const DeepCollectionEquality().hash(_cabinetName),
      const DeepCollectionEquality().hash(_cabinetRoomName),
      const DeepCollectionEquality().hash(_itemPosition),
      itemQuantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemRecordImplCopyWith<_$ItemRecordImpl> get copyWith =>
      __$$ItemRecordImplCopyWithImpl<_$ItemRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemRecordImplToJson(
      this,
    );
  }
}

abstract class _ItemRecord implements ItemRecord {
  factory _ItemRecord(
      {final String? id,
      @JsonKey(name: 'household_id') final String? householdId,
      @JsonKey(name: 'user_name') final String? userName,
      @JsonKey(name: 'created_at') final int? createdAt,
      @JsonKey(name: 'operate_type') final int? operateType,
      @JsonKey(name: 'entity_type') final int? entityType,
      @JsonKey(name: 'item_name') final List<String>? itemName,
      @JsonKey(name: 'item_description') final List<String>? itemDescription,
      @JsonKey(name: 'item_photo') final List<String>? itemPhoto,
      @JsonKey(name: 'item_min_stock_count') final List<int>? itemMinStockCount,
      @JsonKey(name: 'category_name') final List<String>? categoryName,
      @JsonKey(name: 'cabinet_name') final List<String>? cabinetName,
      @JsonKey(name: 'cabinet_room_name') final List<String>? cabinetRoomName,
      @JsonKey(name: 'item_position') final List<ItemPosition>? itemPosition,
      @JsonKey(name: 'item_quantity')
      final ItemQuantity? itemQuantity}) = _$ItemRecordImpl;

  factory _ItemRecord.fromJson(Map<String, dynamic> json) =
      _$ItemRecordImpl.fromJson;

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
  @JsonKey(name: 'item_name')
  List<String>? get itemName;
  @override
  @JsonKey(name: 'item_description')
  List<String>? get itemDescription;
  @override
  @JsonKey(name: 'item_photo')
  List<String>? get itemPhoto;
  @override
  @JsonKey(name: 'item_min_stock_count')
  List<int>? get itemMinStockCount;
  @override
  @JsonKey(name: 'category_name')
  List<String>? get categoryName;
  @override
  @JsonKey(name: 'cabinet_name')
  List<String>? get cabinetName;
  @override
  @JsonKey(name: 'cabinet_room_name')
  List<String>? get cabinetRoomName;
  @override
  @JsonKey(name: 'item_position')
  List<ItemPosition>? get itemPosition;
  @override
  @JsonKey(name: 'item_quantity')
  ItemQuantity? get itemQuantity;
  @override
  @JsonKey(ignore: true)
  _$$ItemRecordImplCopyWith<_$ItemRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
