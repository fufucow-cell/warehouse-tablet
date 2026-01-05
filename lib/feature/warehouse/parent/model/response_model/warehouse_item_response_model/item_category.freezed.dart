// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemCategory _$ItemCategoryFromJson(Map<String, dynamic> json) {
  return _ItemCategory.fromJson(json);
}

/// @nodoc
mixin _$ItemCategory {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_id')
  String? get parentId => throw _privateConstructorUsedError;
  ItemCategory? get child => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemCategoryCopyWith<ItemCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCategoryCopyWith<$Res> {
  factory $ItemCategoryCopyWith(
          ItemCategory value, $Res Function(ItemCategory) then) =
      _$ItemCategoryCopyWithImpl<$Res, ItemCategory>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      @JsonKey(name: 'parent_id') String? parentId,
      ItemCategory? child});

  $ItemCategoryCopyWith<$Res>? get child;
}

/// @nodoc
class _$ItemCategoryCopyWithImpl<$Res, $Val extends ItemCategory>
    implements $ItemCategoryCopyWith<$Res> {
  _$ItemCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? parentId = freezed,
    Object? child = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      child: freezed == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as ItemCategory?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ItemCategoryCopyWith<$Res>? get child {
    if (_value.child == null) {
      return null;
    }

    return $ItemCategoryCopyWith<$Res>(_value.child!, (value) {
      return _then(_value.copyWith(child: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ItemCategoryImplCopyWith<$Res>
    implements $ItemCategoryCopyWith<$Res> {
  factory _$$ItemCategoryImplCopyWith(
          _$ItemCategoryImpl value, $Res Function(_$ItemCategoryImpl) then) =
      __$$ItemCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      @JsonKey(name: 'parent_id') String? parentId,
      ItemCategory? child});

  @override
  $ItemCategoryCopyWith<$Res>? get child;
}

/// @nodoc
class __$$ItemCategoryImplCopyWithImpl<$Res>
    extends _$ItemCategoryCopyWithImpl<$Res, _$ItemCategoryImpl>
    implements _$$ItemCategoryImplCopyWith<$Res> {
  __$$ItemCategoryImplCopyWithImpl(
      _$ItemCategoryImpl _value, $Res Function(_$ItemCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? parentId = freezed,
    Object? child = freezed,
  }) {
    return _then(_$ItemCategoryImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      child: freezed == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as ItemCategory?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemCategoryImpl implements _ItemCategory {
  _$ItemCategoryImpl(
      {this.id,
      this.name,
      @JsonKey(name: 'parent_id') this.parentId,
      this.child});

  factory _$ItemCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemCategoryImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  @JsonKey(name: 'parent_id')
  final String? parentId;
  @override
  final ItemCategory? child;

  @override
  String toString() {
    return 'ItemCategory(id: $id, name: $name, parentId: $parentId, child: $child)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.child, child) || other.child == child));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, parentId, child);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemCategoryImplCopyWith<_$ItemCategoryImpl> get copyWith =>
      __$$ItemCategoryImplCopyWithImpl<_$ItemCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemCategoryImplToJson(
      this,
    );
  }
}

abstract class _ItemCategory implements ItemCategory {
  factory _ItemCategory(
      {final String? id,
      final String? name,
      @JsonKey(name: 'parent_id') final String? parentId,
      final ItemCategory? child}) = _$ItemCategoryImpl;

  factory _ItemCategory.fromJson(Map<String, dynamic> json) =
      _$ItemCategoryImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  @JsonKey(name: 'parent_id')
  String? get parentId;
  @override
  ItemCategory? get child;
  @override
  @JsonKey(ignore: true)
  _$$ItemCategoryImplCopyWith<_$ItemCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
