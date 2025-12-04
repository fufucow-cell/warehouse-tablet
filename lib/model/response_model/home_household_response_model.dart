import 'package:flutter_smart_home_tablet/model/response_model/home_room_response_model.dart';
import 'package:flutter_smart_home_tablet/model/response_model/user_login_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_household_response_model.g.dart';

@JsonSerializable()
class HomeHouseholdResponseModel {
  @JsonKey(name: 'home_id')
  int? homeId;
  @JsonKey(name: 'home_name')
  String? homeName;
  List<UserLoginResponseModel>? users;
  List<HomeRoomResponseModel>? rooms;

  HomeHouseholdResponseModel({
    this.homeId,
    this.homeName,
    this.users,
    this.rooms,
  });

  factory HomeHouseholdResponseModel.fromJson(Map<String, dynamic> json) {
    return _$HomeHouseholdResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeHouseholdResponseModelToJson(this);
}
