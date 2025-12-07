// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'children.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Children _$ChildrenFromJson(Map<String, dynamic> json) {
  return _Children.fromJson(json);
}

/// @nodoc
mixin _$Children {
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_id')
  String? get parentId => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;
  dynamic get children => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChildrenCopyWith<Children> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildrenCopyWith<$Res> {
  factory $ChildrenCopyWith(Children value, $Res Function(Children) then) =
      _$ChildrenCopyWithImpl<$Res, Children>;
  @useResult
  $Res call(
      {@JsonKey(name: 'category_id') String? categoryId,
      String? name,
      @JsonKey(name: 'parent_id') String? parentId,
      int? level,
      dynamic children});
}

/// @nodoc
class _$ChildrenCopyWithImpl<$Res, $Val extends Children>
    implements $ChildrenCopyWith<$Res> {
  _$ChildrenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
    Object? name = freezed,
    Object? parentId = freezed,
    Object? level = freezed,
    Object? children = freezed,
  }) {
    return _then(_value.copyWith(
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      children: freezed == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChildrenImplCopyWith<$Res>
    implements $ChildrenCopyWith<$Res> {
  factory _$$ChildrenImplCopyWith(
          _$ChildrenImpl value, $Res Function(_$ChildrenImpl) then) =
      __$$ChildrenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'category_id') String? categoryId,
      String? name,
      @JsonKey(name: 'parent_id') String? parentId,
      int? level,
      dynamic children});
}

/// @nodoc
class __$$ChildrenImplCopyWithImpl<$Res>
    extends _$ChildrenCopyWithImpl<$Res, _$ChildrenImpl>
    implements _$$ChildrenImplCopyWith<$Res> {
  __$$ChildrenImplCopyWithImpl(
      _$ChildrenImpl _value, $Res Function(_$ChildrenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
    Object? name = freezed,
    Object? parentId = freezed,
    Object? level = freezed,
    Object? children = freezed,
  }) {
    return _then(_$ChildrenImpl(
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      children: freezed == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChildrenImpl implements _Children {
  _$ChildrenImpl(
      {@JsonKey(name: 'category_id') this.categoryId,
      this.name,
      @JsonKey(name: 'parent_id') this.parentId,
      this.level,
      this.children});

  factory _$ChildrenImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChildrenImplFromJson(json);

  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  final String? name;
  @override
  @JsonKey(name: 'parent_id')
  final String? parentId;
  @override
  final int? level;
  @override
  final dynamic children;

  @override
  String toString() {
    return 'Children(categoryId: $categoryId, name: $name, parentId: $parentId, level: $level, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChildrenImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality().equals(other.children, children));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, categoryId, name, parentId,
      level, const DeepCollectionEquality().hash(children));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChildrenImplCopyWith<_$ChildrenImpl> get copyWith =>
      __$$ChildrenImplCopyWithImpl<_$ChildrenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChildrenImplToJson(
      this,
    );
  }
}

abstract class _Children implements Children {
  factory _Children(
      {@JsonKey(name: 'category_id') final String? categoryId,
      final String? name,
      @JsonKey(name: 'parent_id') final String? parentId,
      final int? level,
      final dynamic children}) = _$ChildrenImpl;

  factory _Children.fromJson(Map<String, dynamic> json) =
      _$ChildrenImpl.fromJson;

  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  String? get name;
  @override
  @JsonKey(name: 'parent_id')
  String? get parentId;
  @override
  int? get level;
  @override
  dynamic get children;
  @override
  @JsonKey(ignore: true)
  _$$ChildrenImplCopyWith<_$ChildrenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
