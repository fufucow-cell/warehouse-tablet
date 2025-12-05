import 'package:flutter_smart_home_tablet/inherit/base_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_login_request_model.g.dart';

@JsonSerializable()
class UserLoginRequestModel extends BaseApiRequestModel {
  String? email;
  String? password;

  UserLoginRequestModel({this.email, this.password});

  factory UserLoginRequestModel.fromJson(Map<String, dynamic> json) {
    return _$UserLoginRequestModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$UserLoginRequestModelToJson(this);
}
