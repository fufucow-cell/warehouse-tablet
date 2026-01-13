import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login_request_model.freezed.dart';
part 'user_login_request_model.g.dart';

@freezed
class UserLoginRequestModel with _$UserLoginRequestModel {
  factory UserLoginRequestModel({
    String? email,
    String? password,
  }) = _UserLoginRequestModel;

  factory UserLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginRequestModelFromJson(json);
}
