import 'package:json_annotation/json_annotation.dart';

part 'user_login_response_model.g.dart';

@JsonSerializable()
class UserLoginResponseModel {
  String? id;
  String? email;
  @JsonKey(name: 'user_name')
  String? userName;
  String? avatar;
  @JsonKey(name: 'house_id')
  int? houseId;
  String? phone;
  @JsonKey(name: 'is_phone_verify')
  bool? isPhoneVerify;
  @JsonKey(name: 'is_email_verify')
  bool? isEmailVerify;
  @JsonKey(name: 'role_type')
  int? roleType;
  Preferences? preferences;
  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'refresh_token')
  String? refreshToken;

  UserLoginResponseModel({
    this.id,
    this.email,
    this.userName,
    this.avatar,
    this.houseId,
    this.phone,
    this.isPhoneVerify,
    this.isEmailVerify,
    this.roleType,
    this.preferences,
    this.accessToken,
    this.refreshToken,
  });

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) {
    return _$UserLoginResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserLoginResponseModelToJson(this);
}

@JsonSerializable()
class Preferences {
  @JsonKey(name: 'language_code')
  String? languageCode;
  int? theme;

  Preferences({this.languageCode, this.theme});

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return _$PreferencesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PreferencesToJson(this);
}
