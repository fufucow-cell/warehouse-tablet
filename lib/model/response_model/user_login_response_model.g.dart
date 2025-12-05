// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginResponseModel _$UserLoginResponseModelFromJson(
        Map<String, dynamic> json) =>
    UserLoginResponseModel(
      userName: json['user_name'] as String?,
      houseId: (json['house_id'] as num?)?.toInt(),
      isPhoneVerify: json['is_phone_verify'] as bool?,
      isEmailVerify: json['is_email_verify'] as bool?,
      roleType: (json['role_type'] as num?)?.toInt(),
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$UserLoginResponseModelToJson(
        UserLoginResponseModel instance) =>
    <String, dynamic>{
      'user_name': instance.userName,
      'house_id': instance.houseId,
      'is_phone_verify': instance.isPhoneVerify,
      'is_email_verify': instance.isEmailVerify,
      'role_type': instance.roleType,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };

Preferences _$PreferencesFromJson(Map<String, dynamic> json) => Preferences(
      languageCode: json['language_code'] as String?,
    );

Map<String, dynamic> _$PreferencesToJson(Preferences instance) =>
    <String, dynamic>{
      'language_code': instance.languageCode,
    };
