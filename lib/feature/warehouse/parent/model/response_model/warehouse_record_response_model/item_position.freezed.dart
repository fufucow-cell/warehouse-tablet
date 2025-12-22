// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemPosition _$ItemPositionFromJson(Map<String, dynamic> json) {
  return _ItemPosition.fromJson(json);
}

/// @nodoc
mixin _$ItemPosition {
  @JsonKey(name: 'cabinet_name')
  List<String>? get cabinetName => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;

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
  $Res call(
      {@JsonKey(name: 'cabinet_name') List<String>? cabinetName, int? count});
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
    Object? cabinetName = freezed,
    Object? count = freezed,
  }) {
    return _then(_value.copyWith(
      cabinetName: freezed == cabinetName
          ? _value.cabinetName
          : cabinetName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
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
  $Res call(
      {@JsonKey(name: 'cabinet_name') List<String>? cabinetName, int? count});
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
    Object? cabinetName = freezed,
    Object? count = freezed,
  }) {
    return _then(_$ItemPositionImpl(
      cabinetName: freezed == cabinetName
          ? _value._cabinetName
          : cabinetName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemPositionImpl implements _ItemPosition {
  _$ItemPositionImpl(
      {@JsonKey(name: 'cabinet_name') final List<String>? cabinetName,
      this.count})
      : _cabinetName = cabinetName;

  factory _$ItemPositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemPositionImplFromJson(json);

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

  @override
  final int? count;

  @override
  String toString() {
    return 'ItemPosition(cabinetName: $cabinetName, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemPositionImpl &&
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
  factory _ItemPosition(
      {@JsonKey(name: 'cabinet_name') final List<String>? cabinetName,
      final int? count}) = _$ItemPositionImpl;

  factory _ItemPosition.fromJson(Map<String, dynamic> json) =
      _$ItemPositionImpl.fromJson;

  @override
  @JsonKey(name: 'cabinet_name')
  List<String>? get cabinetName;
  @override
  int? get count;
  @override
  @JsonKey(ignore: true)
  _$$ItemPositionImplCopyWith<_$ItemPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
