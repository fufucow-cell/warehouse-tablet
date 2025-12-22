// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_quantity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemQuantity _$ItemQuantityFromJson(Map<String, dynamic> json) {
  return _ItemQuantity.fromJson(json);
}

/// @nodoc
mixin _$ItemQuantity {
  @JsonKey(name: 'total_count')
  List<int>? get totalCount => throw _privateConstructorUsedError;
  List<Cabinet>? get cabinets => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'total_count') List<int>? totalCount,
      List<Cabinet>? cabinets});
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
              as List<int>?,
      cabinets: freezed == cabinets
          ? _value.cabinets
          : cabinets // ignore: cast_nullable_to_non_nullable
              as List<Cabinet>?,
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
      {@JsonKey(name: 'total_count') List<int>? totalCount,
      List<Cabinet>? cabinets});
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
              as List<int>?,
      cabinets: freezed == cabinets
          ? _value._cabinets
          : cabinets // ignore: cast_nullable_to_non_nullable
              as List<Cabinet>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemQuantityImpl implements _ItemQuantity {
  _$ItemQuantityImpl(
      {@JsonKey(name: 'total_count') final List<int>? totalCount,
      final List<Cabinet>? cabinets})
      : _totalCount = totalCount,
        _cabinets = cabinets;

  factory _$ItemQuantityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemQuantityImplFromJson(json);

  final List<int>? _totalCount;
  @override
  @JsonKey(name: 'total_count')
  List<int>? get totalCount {
    final value = _totalCount;
    if (value == null) return null;
    if (_totalCount is EqualUnmodifiableListView) return _totalCount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Cabinet>? _cabinets;
  @override
  List<Cabinet>? get cabinets {
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
      {@JsonKey(name: 'total_count') final List<int>? totalCount,
      final List<Cabinet>? cabinets}) = _$ItemQuantityImpl;

  factory _ItemQuantity.fromJson(Map<String, dynamic> json) =
      _$ItemQuantityImpl.fromJson;

  @override
  @JsonKey(name: 'total_count')
  List<int>? get totalCount;
  @override
  List<Cabinet>? get cabinets;
  @override
  @JsonKey(ignore: true)
  _$$ItemQuantityImplCopyWith<_$ItemQuantityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
