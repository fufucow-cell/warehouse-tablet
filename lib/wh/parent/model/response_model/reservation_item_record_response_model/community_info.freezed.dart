// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommunityInfo _$CommunityInfoFromJson(Map<String, dynamic> json) {
  return _CommunityInfo.fromJson(json);
}

/// @nodoc
mixin _$CommunityInfo {
  @JsonKey(name: 'community_id')
  String? get communityId => throw _privateConstructorUsedError;
  @JsonKey(name: 'community_name')
  String? get communityName => throw _privateConstructorUsedError;
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'household_name')
  String? get householdName => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommunityInfoCopyWith<CommunityInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityInfoCopyWith<$Res> {
  factory $CommunityInfoCopyWith(
          CommunityInfo value, $Res Function(CommunityInfo) then) =
      _$CommunityInfoCopyWithImpl<$Res, CommunityInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'community_id') String? communityId,
      @JsonKey(name: 'community_name') String? communityName,
      @JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'household_name') String? householdName,
      String? address});
}

/// @nodoc
class _$CommunityInfoCopyWithImpl<$Res, $Val extends CommunityInfo>
    implements $CommunityInfoCopyWith<$Res> {
  _$CommunityInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communityId = freezed,
    Object? communityName = freezed,
    Object? householdId = freezed,
    Object? householdName = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      communityId: freezed == communityId
          ? _value.communityId
          : communityId // ignore: cast_nullable_to_non_nullable
              as String?,
      communityName: freezed == communityName
          ? _value.communityName
          : communityName // ignore: cast_nullable_to_non_nullable
              as String?,
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      householdName: freezed == householdName
          ? _value.householdName
          : householdName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommunityInfoImplCopyWith<$Res>
    implements $CommunityInfoCopyWith<$Res> {
  factory _$$CommunityInfoImplCopyWith(
          _$CommunityInfoImpl value, $Res Function(_$CommunityInfoImpl) then) =
      __$$CommunityInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'community_id') String? communityId,
      @JsonKey(name: 'community_name') String? communityName,
      @JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'household_name') String? householdName,
      String? address});
}

/// @nodoc
class __$$CommunityInfoImplCopyWithImpl<$Res>
    extends _$CommunityInfoCopyWithImpl<$Res, _$CommunityInfoImpl>
    implements _$$CommunityInfoImplCopyWith<$Res> {
  __$$CommunityInfoImplCopyWithImpl(
      _$CommunityInfoImpl _value, $Res Function(_$CommunityInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communityId = freezed,
    Object? communityName = freezed,
    Object? householdId = freezed,
    Object? householdName = freezed,
    Object? address = freezed,
  }) {
    return _then(_$CommunityInfoImpl(
      communityId: freezed == communityId
          ? _value.communityId
          : communityId // ignore: cast_nullable_to_non_nullable
              as String?,
      communityName: freezed == communityName
          ? _value.communityName
          : communityName // ignore: cast_nullable_to_non_nullable
              as String?,
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      householdName: freezed == householdName
          ? _value.householdName
          : householdName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommunityInfoImpl implements _CommunityInfo {
  _$CommunityInfoImpl(
      {@JsonKey(name: 'community_id') this.communityId,
      @JsonKey(name: 'community_name') this.communityName,
      @JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'household_name') this.householdName,
      this.address});

  factory _$CommunityInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityInfoImplFromJson(json);

  @override
  @JsonKey(name: 'community_id')
  final String? communityId;
  @override
  @JsonKey(name: 'community_name')
  final String? communityName;
  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  @JsonKey(name: 'household_name')
  final String? householdName;
  @override
  final String? address;

  @override
  String toString() {
    return 'CommunityInfo(communityId: $communityId, communityName: $communityName, householdId: $householdId, householdName: $householdName, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityInfoImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.communityName, communityName) ||
                other.communityName == communityName) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.householdName, householdName) ||
                other.householdName == householdName) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, communityId, communityName,
      householdId, householdName, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityInfoImplCopyWith<_$CommunityInfoImpl> get copyWith =>
      __$$CommunityInfoImplCopyWithImpl<_$CommunityInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityInfoImplToJson(
      this,
    );
  }
}

abstract class _CommunityInfo implements CommunityInfo {
  factory _CommunityInfo(
      {@JsonKey(name: 'community_id') final String? communityId,
      @JsonKey(name: 'community_name') final String? communityName,
      @JsonKey(name: 'household_id') final String? householdId,
      @JsonKey(name: 'household_name') final String? householdName,
      final String? address}) = _$CommunityInfoImpl;

  factory _CommunityInfo.fromJson(Map<String, dynamic> json) =
      _$CommunityInfoImpl.fromJson;

  @override
  @JsonKey(name: 'community_id')
  String? get communityId;
  @override
  @JsonKey(name: 'community_name')
  String? get communityName;
  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  @JsonKey(name: 'household_name')
  String? get householdName;
  @override
  String? get address;
  @override
  @JsonKey(ignore: true)
  _$$CommunityInfoImplCopyWith<_$CommunityInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
