// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cabinet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Cabinet _$CabinetFromJson(Map<String, dynamic> json) {
  return _Cabinet.fromJson(json);
}

/// @nodoc
mixin _$Cabinet {
  @JsonKey(name: 'cabinet_name')
  String? get cabinetName => throw _privateConstructorUsedError;
  List<int>? get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CabinetCopyWith<Cabinet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CabinetCopyWith<$Res> {
  factory $CabinetCopyWith(Cabinet value, $Res Function(Cabinet) then) =
      _$CabinetCopyWithImpl<$Res, Cabinet>;
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_name') String? cabinetName, List<int>? count});
}

/// @nodoc
class _$CabinetCopyWithImpl<$Res, $Val extends Cabinet>
    implements $CabinetCopyWith<$Res> {
  _$CabinetCopyWithImpl(this._value, this._then);

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
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CabinetImplCopyWith<$Res> implements $CabinetCopyWith<$Res> {
  factory _$$CabinetImplCopyWith(
          _$CabinetImpl value, $Res Function(_$CabinetImpl) then) =
      __$$CabinetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cabinet_name') String? cabinetName, List<int>? count});
}

/// @nodoc
class __$$CabinetImplCopyWithImpl<$Res>
    extends _$CabinetCopyWithImpl<$Res, _$CabinetImpl>
    implements _$$CabinetImplCopyWith<$Res> {
  __$$CabinetImplCopyWithImpl(
      _$CabinetImpl _value, $Res Function(_$CabinetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cabinetName = freezed,
    Object? count = freezed,
  }) {
    return _then(_$CabinetImpl(
      cabinetName: freezed == cabinetName
          ? _value.cabinetName
          : cabinetName // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _value._count
          : count // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CabinetImpl implements _Cabinet {
  _$CabinetImpl(
      {@JsonKey(name: 'cabinet_name') this.cabinetName, final List<int>? count})
      : _count = count;

  factory _$CabinetImpl.fromJson(Map<String, dynamic> json) =>
      _$$CabinetImplFromJson(json);

  @override
  @JsonKey(name: 'cabinet_name')
  final String? cabinetName;
  final List<int>? _count;
  @override
  List<int>? get count {
    final value = _count;
    if (value == null) return null;
    if (_count is EqualUnmodifiableListView) return _count;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Cabinet(cabinetName: $cabinetName, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CabinetImpl &&
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
  _$$CabinetImplCopyWith<_$CabinetImpl> get copyWith =>
      __$$CabinetImplCopyWithImpl<_$CabinetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CabinetImplToJson(
      this,
    );
  }
}

abstract class _Cabinet implements Cabinet {
  factory _Cabinet(
      {@JsonKey(name: 'cabinet_name') final String? cabinetName,
      final List<int>? count}) = _$CabinetImpl;

  factory _Cabinet.fromJson(Map<String, dynamic> json) = _$CabinetImpl.fromJson;

  @override
  @JsonKey(name: 'cabinet_name')
  String? get cabinetName;
  @override
  List<int>? get count;
  @override
  @JsonKey(ignore: true)
  _$$CabinetImplCopyWith<_$CabinetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
