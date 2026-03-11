// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserLoginResponseModelImpl _$$UserLoginResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserLoginResponseModelImpl(
      id: json['id'] as String?,
      email: json['email'] as String?,
      userName: json['user_name'] as String?,
      household: (json['household'] as List<dynamic>?)
          ?.map((e) => Household.fromJson(e as Map<String, dynamic>))
          .toList(),
      preferences: json['preferences'] == null
          ? null
          : Preferences.fromJson(json['preferences'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$$UserLoginResponseModelImplToJson(
        _$UserLoginResponseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'user_name': instance.userName,
      'household': instance.household?.map((e) => e.toJson()).toList(),
      'preferences': instance.preferences?.toJson(),
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
