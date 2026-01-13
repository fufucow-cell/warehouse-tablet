import 'package:freezed_annotation/freezed_annotation.dart';

part 'household.freezed.dart';
part 'household.g.dart';

@freezed
class Household with _$Household {
  factory Household({
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'home_name') String? homeName,
    @JsonKey(name: 'role_type') int? roleType,
  }) = _Household;

  factory Household.fromJson(Map<String, dynamic> json) =>
      _$HouseholdFromJson(json);
}
