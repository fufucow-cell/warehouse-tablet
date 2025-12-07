import 'package:flutter_smart_home_tablet/model/response_model/user_login_response_model/household.dart';
import 'package:flutter_smart_home_tablet/model/response_model/user_login_response_model/preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login_response_model.freezed.dart';
part 'user_login_response_model.g.dart';

@freezed
class UserLoginResponseModel with _$UserLoginResponseModel {
  factory UserLoginResponseModel({
    String? id,
    String? email,
    @JsonKey(name: 'user_name') String? userName,
    List<Household>? household,
    Preferences? preferences,
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
  }) = _UserLoginResponseModel;

  factory UserLoginResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$UserLoginResponseModelFromJson(json);
}
