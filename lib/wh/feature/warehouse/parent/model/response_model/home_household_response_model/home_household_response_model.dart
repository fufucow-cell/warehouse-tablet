import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/home_household_response_model/room.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/home_household_response_model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_household_response_model.freezed.dart';
part 'home_household_response_model.g.dart';

@freezed
class HomeHouseholdResponseModel with _$HomeHouseholdResponseModel {
  factory HomeHouseholdResponseModel({
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'home_name') String? homeName,
    List<User>? users,
    List<Room>? rooms,
  }) = _HomeHouseholdResponseModel;

  factory HomeHouseholdResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$HomeHouseholdResponseModelFromJson(json);
}
