// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_login_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserLoginResponseModel _$UserLoginResponseModelFromJson(
    Map<String, dynamic> json) {
  return _UserLoginResponseModel.fromJson(json);
}

/// @nodoc
mixin _$UserLoginResponseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  List<Household>? get household => throw _privateConstructorUsedError;
  Preferences? get preferences => throw _privateConstructorUsedError;
  @JsonKey(name: 'access_token')
  String? get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_token')
  String? get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserLoginResponseModelCopyWith<UserLoginResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLoginResponseModelCopyWith<$Res> {
  factory $UserLoginResponseModelCopyWith(UserLoginResponseModel value,
          $Res Function(UserLoginResponseModel) then) =
      _$UserLoginResponseModelCopyWithImpl<$Res, UserLoginResponseModel>;
  @useResult
  $Res call(
      {String? id,
      String? email,
      @JsonKey(name: 'user_name') String? userName,
      List<Household>? household,
      Preferences? preferences,
      @JsonKey(name: 'access_token') String? accessToken,
      @JsonKey(name: 'refresh_token') String? refreshToken});

  $PreferencesCopyWith<$Res>? get preferences;
}

/// @nodoc
class _$UserLoginResponseModelCopyWithImpl<$Res,
        $Val extends UserLoginResponseModel>
    implements $UserLoginResponseModelCopyWith<$Res> {
  _$UserLoginResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? userName = freezed,
    Object? household = freezed,
    Object? preferences = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      household: freezed == household
          ? _value.household
          : household // ignore: cast_nullable_to_non_nullable
              as List<Household>?,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Preferences?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PreferencesCopyWith<$Res>? get preferences {
    if (_value.preferences == null) {
      return null;
    }

    return $PreferencesCopyWith<$Res>(_value.preferences!, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserLoginResponseModelImplCopyWith<$Res>
    implements $UserLoginResponseModelCopyWith<$Res> {
  factory _$$UserLoginResponseModelImplCopyWith(
          _$UserLoginResponseModelImpl value,
          $Res Function(_$UserLoginResponseModelImpl) then) =
      __$$UserLoginResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? email,
      @JsonKey(name: 'user_name') String? userName,
      List<Household>? household,
      Preferences? preferences,
      @JsonKey(name: 'access_token') String? accessToken,
      @JsonKey(name: 'refresh_token') String? refreshToken});

  @override
  $PreferencesCopyWith<$Res>? get preferences;
}

/// @nodoc
class __$$UserLoginResponseModelImplCopyWithImpl<$Res>
    extends _$UserLoginResponseModelCopyWithImpl<$Res,
        _$UserLoginResponseModelImpl>
    implements _$$UserLoginResponseModelImplCopyWith<$Res> {
  __$$UserLoginResponseModelImplCopyWithImpl(
      _$UserLoginResponseModelImpl _value,
      $Res Function(_$UserLoginResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? userName = freezed,
    Object? household = freezed,
    Object? preferences = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_$UserLoginResponseModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      household: freezed == household
          ? _value._household
          : household // ignore: cast_nullable_to_non_nullable
              as List<Household>?,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Preferences?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserLoginResponseModelImpl implements _UserLoginResponseModel {
  _$UserLoginResponseModelImpl(
      {this.id,
      this.email,
      @JsonKey(name: 'user_name') this.userName,
      final List<Household>? household,
      this.preferences,
      @JsonKey(name: 'access_token') this.accessToken,
      @JsonKey(name: 'refresh_token') this.refreshToken})
      : _household = household;

  factory _$UserLoginResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserLoginResponseModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? email;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  final List<Household>? _household;
  @override
  List<Household>? get household {
    final value = _household;
    if (value == null) return null;
    if (_household is EqualUnmodifiableListView) return _household;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Preferences? preferences;
  @override
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @override
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  @override
  String toString() {
    return 'UserLoginResponseModel(id: $id, email: $email, userName: $userName, household: $household, preferences: $preferences, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserLoginResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            const DeepCollectionEquality()
                .equals(other._household, _household) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      userName,
      const DeepCollectionEquality().hash(_household),
      preferences,
      accessToken,
      refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserLoginResponseModelImplCopyWith<_$UserLoginResponseModelImpl>
      get copyWith => __$$UserLoginResponseModelImplCopyWithImpl<
          _$UserLoginResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserLoginResponseModelImplToJson(
      this,
    );
  }
}

abstract class _UserLoginResponseModel implements UserLoginResponseModel {
  factory _UserLoginResponseModel(
          {final String? id,
          final String? email,
          @JsonKey(name: 'user_name') final String? userName,
          final List<Household>? household,
          final Preferences? preferences,
          @JsonKey(name: 'access_token') final String? accessToken,
          @JsonKey(name: 'refresh_token') final String? refreshToken}) =
      _$UserLoginResponseModelImpl;

  factory _UserLoginResponseModel.fromJson(Map<String, dynamic> json) =
      _$UserLoginResponseModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get email;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  List<Household>? get household;
  @override
  Preferences? get preferences;
  @override
  @JsonKey(name: 'access_token')
  String? get accessToken;
  @override
  @JsonKey(name: 'refresh_token')
  String? get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$UserLoginResponseModelImplCopyWith<_$UserLoginResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
