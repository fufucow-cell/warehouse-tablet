// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_household_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomeHouseholdResponseModel _$HomeHouseholdResponseModelFromJson(
    Map<String, dynamic> json) {
  return _HomeHouseholdResponseModel.fromJson(json);
}

/// @nodoc
mixin _$HomeHouseholdResponseModel {
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'home_name')
  String? get homeName => throw _privateConstructorUsedError;
  List<User>? get users => throw _privateConstructorUsedError;
  List<Room>? get rooms => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeHouseholdResponseModelCopyWith<HomeHouseholdResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeHouseholdResponseModelCopyWith<$Res> {
  factory $HomeHouseholdResponseModelCopyWith(HomeHouseholdResponseModel value,
          $Res Function(HomeHouseholdResponseModel) then) =
      _$HomeHouseholdResponseModelCopyWithImpl<$Res,
          HomeHouseholdResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'home_name') String? homeName,
      List<User>? users,
      List<Room>? rooms});
}

/// @nodoc
class _$HomeHouseholdResponseModelCopyWithImpl<$Res,
        $Val extends HomeHouseholdResponseModel>
    implements $HomeHouseholdResponseModelCopyWith<$Res> {
  _$HomeHouseholdResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? homeName = freezed,
    Object? users = freezed,
    Object? rooms = freezed,
  }) {
    return _then(_value.copyWith(
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeName: freezed == homeName
          ? _value.homeName
          : homeName // ignore: cast_nullable_to_non_nullable
              as String?,
      users: freezed == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<User>?,
      rooms: freezed == rooms
          ? _value.rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<Room>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeHouseholdResponseModelImplCopyWith<$Res>
    implements $HomeHouseholdResponseModelCopyWith<$Res> {
  factory _$$HomeHouseholdResponseModelImplCopyWith(
          _$HomeHouseholdResponseModelImpl value,
          $Res Function(_$HomeHouseholdResponseModelImpl) then) =
      __$$HomeHouseholdResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'home_name') String? homeName,
      List<User>? users,
      List<Room>? rooms});
}

/// @nodoc
class __$$HomeHouseholdResponseModelImplCopyWithImpl<$Res>
    extends _$HomeHouseholdResponseModelCopyWithImpl<$Res,
        _$HomeHouseholdResponseModelImpl>
    implements _$$HomeHouseholdResponseModelImplCopyWith<$Res> {
  __$$HomeHouseholdResponseModelImplCopyWithImpl(
      _$HomeHouseholdResponseModelImpl _value,
      $Res Function(_$HomeHouseholdResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdId = freezed,
    Object? homeName = freezed,
    Object? users = freezed,
    Object? rooms = freezed,
  }) {
    return _then(_$HomeHouseholdResponseModelImpl(
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeName: freezed == homeName
          ? _value.homeName
          : homeName // ignore: cast_nullable_to_non_nullable
              as String?,
      users: freezed == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<User>?,
      rooms: freezed == rooms
          ? _value._rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<Room>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeHouseholdResponseModelImpl implements _HomeHouseholdResponseModel {
  _$HomeHouseholdResponseModelImpl(
      {@JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'home_name') this.homeName,
      final List<User>? users,
      final List<Room>? rooms})
      : _users = users,
        _rooms = rooms;

  factory _$HomeHouseholdResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$HomeHouseholdResponseModelImplFromJson(json);

  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  @JsonKey(name: 'home_name')
  final String? homeName;
  final List<User>? _users;
  @override
  List<User>? get users {
    final value = _users;
    if (value == null) return null;
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Room>? _rooms;
  @override
  List<Room>? get rooms {
    final value = _rooms;
    if (value == null) return null;
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'HomeHouseholdResponseModel(householdId: $householdId, homeName: $homeName, users: $users, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeHouseholdResponseModelImpl &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.homeName, homeName) ||
                other.homeName == homeName) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      householdId,
      homeName,
      const DeepCollectionEquality().hash(_users),
      const DeepCollectionEquality().hash(_rooms));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeHouseholdResponseModelImplCopyWith<_$HomeHouseholdResponseModelImpl>
      get copyWith => __$$HomeHouseholdResponseModelImplCopyWithImpl<
          _$HomeHouseholdResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeHouseholdResponseModelImplToJson(
      this,
    );
  }
}

abstract class _HomeHouseholdResponseModel
    implements HomeHouseholdResponseModel {
  factory _HomeHouseholdResponseModel(
      {@JsonKey(name: 'household_id') final String? householdId,
      @JsonKey(name: 'home_name') final String? homeName,
      final List<User>? users,
      final List<Room>? rooms}) = _$HomeHouseholdResponseModelImpl;

  factory _HomeHouseholdResponseModel.fromJson(Map<String, dynamic> json) =
      _$HomeHouseholdResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  @JsonKey(name: 'home_name')
  String? get homeName;
  @override
  List<User>? get users;
  @override
  List<Room>? get rooms;
  @override
  @JsonKey(ignore: true)
  _$$HomeHouseholdResponseModelImplCopyWith<_$HomeHouseholdResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
