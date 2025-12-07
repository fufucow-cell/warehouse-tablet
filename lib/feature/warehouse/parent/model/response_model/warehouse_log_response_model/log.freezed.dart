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
  @JsonKey(name: 'log_id')
  String? get logId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  int? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'operate_type')
  int? get operateType => throw _privateConstructorUsedError;
  @JsonKey(name: 'entity_type')
  int? get entityType => throw _privateConstructorUsedError;
  @JsonKey(name: 'log_type')
  int? get logType => throw _privateConstructorUsedError;
  @JsonKey(name: 'entity_name')
  List<String?>? get entityName => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_name')
  List<String?>? get descriptionName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  List<String?>? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity_count')
  List<int?>? get quantityCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_stock_count')
  List<int?>? get minStockCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_name')
  List<String?>? get roomName => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_url')
  List<String?>? get photoUrl => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'log_id') String? logId,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'created_at') int? createdAt,
      @JsonKey(name: 'operate_type') int? operateType,
      @JsonKey(name: 'entity_type') int? entityType,
      @JsonKey(name: 'log_type') int? logType,
      @JsonKey(name: 'entity_name') List<String?>? entityName,
      @JsonKey(name: 'description_name') List<String?>? descriptionName,
      @JsonKey(name: 'category_name') List<String?>? categoryName,
      @JsonKey(name: 'quantity_count') List<int?>? quantityCount,
      @JsonKey(name: 'min_stock_count') List<int?>? minStockCount,
      @JsonKey(name: 'room_name') List<String?>? roomName,
      @JsonKey(name: 'photo_url') List<String?>? photoUrl});
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
    Object? logId = freezed,
    Object? userName = freezed,
    Object? createdAt = freezed,
    Object? operateType = freezed,
    Object? entityType = freezed,
    Object? logType = freezed,
    Object? entityName = freezed,
    Object? descriptionName = freezed,
    Object? categoryName = freezed,
    Object? quantityCount = freezed,
    Object? minStockCount = freezed,
    Object? roomName = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      logId: freezed == logId
          ? _value.logId
          : logId // ignore: cast_nullable_to_non_nullable
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
      logType: freezed == logType
          ? _value.logType
          : logType // ignore: cast_nullable_to_non_nullable
              as int?,
      entityName: freezed == entityName
          ? _value.entityName
          : entityName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      descriptionName: freezed == descriptionName
          ? _value.descriptionName
          : descriptionName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      quantityCount: freezed == quantityCount
          ? _value.quantityCount
          : quantityCount // ignore: cast_nullable_to_non_nullable
              as List<int?>?,
      minStockCount: freezed == minStockCount
          ? _value.minStockCount
          : minStockCount // ignore: cast_nullable_to_non_nullable
              as List<int?>?,
      roomName: freezed == roomName
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LogImplCopyWith<$Res> implements $LogCopyWith<$Res> {
  factory _$$LogImplCopyWith(_$LogImpl value, $Res Function(_$LogImpl) then) =
      __$$LogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'log_id') String? logId,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'created_at') int? createdAt,
      @JsonKey(name: 'operate_type') int? operateType,
      @JsonKey(name: 'entity_type') int? entityType,
      @JsonKey(name: 'log_type') int? logType,
      @JsonKey(name: 'entity_name') List<String?>? entityName,
      @JsonKey(name: 'description_name') List<String?>? descriptionName,
      @JsonKey(name: 'category_name') List<String?>? categoryName,
      @JsonKey(name: 'quantity_count') List<int?>? quantityCount,
      @JsonKey(name: 'min_stock_count') List<int?>? minStockCount,
      @JsonKey(name: 'room_name') List<String?>? roomName,
      @JsonKey(name: 'photo_url') List<String?>? photoUrl});
}

/// @nodoc
class __$$LogImplCopyWithImpl<$Res> extends _$LogCopyWithImpl<$Res, _$LogImpl>
    implements _$$LogImplCopyWith<$Res> {
  __$$LogImplCopyWithImpl(_$LogImpl _value, $Res Function(_$LogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logId = freezed,
    Object? userName = freezed,
    Object? createdAt = freezed,
    Object? operateType = freezed,
    Object? entityType = freezed,
    Object? logType = freezed,
    Object? entityName = freezed,
    Object? descriptionName = freezed,
    Object? categoryName = freezed,
    Object? quantityCount = freezed,
    Object? minStockCount = freezed,
    Object? roomName = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_$LogImpl(
      logId: freezed == logId
          ? _value.logId
          : logId // ignore: cast_nullable_to_non_nullable
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
      logType: freezed == logType
          ? _value.logType
          : logType // ignore: cast_nullable_to_non_nullable
              as int?,
      entityName: freezed == entityName
          ? _value._entityName
          : entityName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      descriptionName: freezed == descriptionName
          ? _value._descriptionName
          : descriptionName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      categoryName: freezed == categoryName
          ? _value._categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      quantityCount: freezed == quantityCount
          ? _value._quantityCount
          : quantityCount // ignore: cast_nullable_to_non_nullable
              as List<int?>?,
      minStockCount: freezed == minStockCount
          ? _value._minStockCount
          : minStockCount // ignore: cast_nullable_to_non_nullable
              as List<int?>?,
      roomName: freezed == roomName
          ? _value._roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      photoUrl: freezed == photoUrl
          ? _value._photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LogImpl implements _Log {
  _$LogImpl(
      {@JsonKey(name: 'log_id') this.logId,
      @JsonKey(name: 'user_name') this.userName,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'operate_type') this.operateType,
      @JsonKey(name: 'entity_type') this.entityType,
      @JsonKey(name: 'log_type') this.logType,
      @JsonKey(name: 'entity_name') final List<String?>? entityName,
      @JsonKey(name: 'description_name') final List<String?>? descriptionName,
      @JsonKey(name: 'category_name') final List<String?>? categoryName,
      @JsonKey(name: 'quantity_count') final List<int?>? quantityCount,
      @JsonKey(name: 'min_stock_count') final List<int?>? minStockCount,
      @JsonKey(name: 'room_name') final List<String?>? roomName,
      @JsonKey(name: 'photo_url') final List<String?>? photoUrl})
      : _entityName = entityName,
        _descriptionName = descriptionName,
        _categoryName = categoryName,
        _quantityCount = quantityCount,
        _minStockCount = minStockCount,
        _roomName = roomName,
        _photoUrl = photoUrl;

  factory _$LogImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogImplFromJson(json);

  @override
  @JsonKey(name: 'log_id')
  final String? logId;
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
  @JsonKey(name: 'log_type')
  final int? logType;
  final List<String?>? _entityName;
  @override
  @JsonKey(name: 'entity_name')
  List<String?>? get entityName {
    final value = _entityName;
    if (value == null) return null;
    if (_entityName is EqualUnmodifiableListView) return _entityName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String?>? _descriptionName;
  @override
  @JsonKey(name: 'description_name')
  List<String?>? get descriptionName {
    final value = _descriptionName;
    if (value == null) return null;
    if (_descriptionName is EqualUnmodifiableListView) return _descriptionName;
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

  final List<int?>? _quantityCount;
  @override
  @JsonKey(name: 'quantity_count')
  List<int?>? get quantityCount {
    final value = _quantityCount;
    if (value == null) return null;
    if (_quantityCount is EqualUnmodifiableListView) return _quantityCount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int?>? _minStockCount;
  @override
  @JsonKey(name: 'min_stock_count')
  List<int?>? get minStockCount {
    final value = _minStockCount;
    if (value == null) return null;
    if (_minStockCount is EqualUnmodifiableListView) return _minStockCount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String?>? _roomName;
  @override
  @JsonKey(name: 'room_name')
  List<String?>? get roomName {
    final value = _roomName;
    if (value == null) return null;
    if (_roomName is EqualUnmodifiableListView) return _roomName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String?>? _photoUrl;
  @override
  @JsonKey(name: 'photo_url')
  List<String?>? get photoUrl {
    final value = _photoUrl;
    if (value == null) return null;
    if (_photoUrl is EqualUnmodifiableListView) return _photoUrl;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Log(logId: $logId, userName: $userName, createdAt: $createdAt, operateType: $operateType, entityType: $entityType, logType: $logType, entityName: $entityName, descriptionName: $descriptionName, categoryName: $categoryName, quantityCount: $quantityCount, minStockCount: $minStockCount, roomName: $roomName, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogImpl &&
            (identical(other.logId, logId) || other.logId == logId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.operateType, operateType) ||
                other.operateType == operateType) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.logType, logType) || other.logType == logType) &&
            const DeepCollectionEquality()
                .equals(other._entityName, _entityName) &&
            const DeepCollectionEquality()
                .equals(other._descriptionName, _descriptionName) &&
            const DeepCollectionEquality()
                .equals(other._categoryName, _categoryName) &&
            const DeepCollectionEquality()
                .equals(other._quantityCount, _quantityCount) &&
            const DeepCollectionEquality()
                .equals(other._minStockCount, _minStockCount) &&
            const DeepCollectionEquality().equals(other._roomName, _roomName) &&
            const DeepCollectionEquality().equals(other._photoUrl, _photoUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      logId,
      userName,
      createdAt,
      operateType,
      entityType,
      logType,
      const DeepCollectionEquality().hash(_entityName),
      const DeepCollectionEquality().hash(_descriptionName),
      const DeepCollectionEquality().hash(_categoryName),
      const DeepCollectionEquality().hash(_quantityCount),
      const DeepCollectionEquality().hash(_minStockCount),
      const DeepCollectionEquality().hash(_roomName),
      const DeepCollectionEquality().hash(_photoUrl));

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
      {@JsonKey(name: 'log_id') final String? logId,
      @JsonKey(name: 'user_name') final String? userName,
      @JsonKey(name: 'created_at') final int? createdAt,
      @JsonKey(name: 'operate_type') final int? operateType,
      @JsonKey(name: 'entity_type') final int? entityType,
      @JsonKey(name: 'log_type') final int? logType,
      @JsonKey(name: 'entity_name') final List<String?>? entityName,
      @JsonKey(name: 'description_name') final List<String?>? descriptionName,
      @JsonKey(name: 'category_name') final List<String?>? categoryName,
      @JsonKey(name: 'quantity_count') final List<int?>? quantityCount,
      @JsonKey(name: 'min_stock_count') final List<int?>? minStockCount,
      @JsonKey(name: 'room_name') final List<String?>? roomName,
      @JsonKey(name: 'photo_url') final List<String?>? photoUrl}) = _$LogImpl;

  factory _Log.fromJson(Map<String, dynamic> json) = _$LogImpl.fromJson;

  @override
  @JsonKey(name: 'log_id')
  String? get logId;
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
  @JsonKey(name: 'log_type')
  int? get logType;
  @override
  @JsonKey(name: 'entity_name')
  List<String?>? get entityName;
  @override
  @JsonKey(name: 'description_name')
  List<String?>? get descriptionName;
  @override
  @JsonKey(name: 'category_name')
  List<String?>? get categoryName;
  @override
  @JsonKey(name: 'quantity_count')
  List<int?>? get quantityCount;
  @override
  @JsonKey(name: 'min_stock_count')
  List<int?>? get minStockCount;
  @override
  @JsonKey(name: 'room_name')
  List<String?>? get roomName;
  @override
  @JsonKey(name: 'photo_url')
  List<String?>? get photoUrl;
  @override
  @JsonKey(ignore: true)
  _$$LogImplCopyWith<_$LogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
