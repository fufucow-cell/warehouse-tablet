// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginResponseModel _$UserLoginResponseModelFromJson(
        Map<String, dynamic> json) =>
    UserLoginResponseModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      userName: json['user_name'] as String?,
      avatar: json['avatar'] as String?,
      houseId: (json['house_id'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      isPhoneVerify: json['is_phone_verify'] as bool?,
      isEmailVerify: json['is_email_verify'] as bool?,
      roleType: (json['role_type'] as num?)?.toInt(),
      preferences: json['preferences'] == null
          ? null
          : Preferences.fromJson(json['preferences'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$UserLoginResponseModelToJson(
        UserLoginResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'user_name': instance.userName,
      'avatar': instance.avatar,
      'house_id': instance.houseId,
      'phone': instance.phone,
      'is_phone_verify': instance.isPhoneVerify,
      'is_email_verify': instance.isEmailVerify,
      'role_type': instance.roleType,
      'preferences': instance.preferences?.toJson(),
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };

Preferences _$PreferencesFromJson(Map<String, dynamic> json) => Preferences(
      languageCode: json['language_code'] as String?,
      theme: (json['theme'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PreferencesToJson(Preferences instance) =>
    <String, dynamic>{
      'language_code': instance.languageCode,
      'theme': instance.theme,
    };
