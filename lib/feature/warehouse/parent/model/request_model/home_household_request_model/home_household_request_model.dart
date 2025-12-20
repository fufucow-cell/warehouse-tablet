import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_household_request_model.freezed.dart';
part 'home_household_request_model.g.dart';

@freezed
class HomeHouseholdRequestModel with _$HomeHouseholdRequestModel {
  factory HomeHouseholdRequestModel({
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'home_name') String? homeName,
  }) = _HomeHouseholdRequestModel;

  factory HomeHouseholdRequestModel.fromJson(Map<String, dynamic> json) =>
      _$HomeHouseholdRequestModelFromJson(json);
}
