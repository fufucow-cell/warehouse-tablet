import 'package:json_annotation/json_annotation.dart';

part 'home_household_request_model.g.dart';

@JsonSerializable()
class HomeHouseholdRequestModel {
  @JsonKey(name: 'home_id')
  int? homeId;
  @JsonKey(name: 'home_name')
  String? homeName;

  HomeHouseholdRequestModel({this.homeId, this.homeName});

  factory HomeHouseholdRequestModel.fromJson(Map<String, dynamic> json) {
    return _$HomeHouseholdRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeHouseholdRequestModelToJson(this);
}
