import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_info.freezed.dart';
part 'community_info.g.dart';

@freezed
class CommunityInfo with _$CommunityInfo {
  factory CommunityInfo({
    @JsonKey(name: 'community_id') String? communityId,
    @JsonKey(name: 'community_name') String? communityName,
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'household_name') String? householdName,
    String? address,
  }) = _CommunityInfo;

  factory CommunityInfo.fromJson(Map<String, dynamic> json) => _$CommunityInfoFromJson(json);
}
