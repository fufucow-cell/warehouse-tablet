// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommunityInfoImpl _$$CommunityInfoImplFromJson(Map<String, dynamic> json) =>
    _$CommunityInfoImpl(
      communityId: json['community_id'] as String?,
      communityName: json['community_name'] as String?,
      householdId: json['household_id'] as String?,
      householdName: json['household_name'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$CommunityInfoImplToJson(_$CommunityInfoImpl instance) =>
    <String, dynamic>{
      'community_id': instance.communityId,
      'community_name': instance.communityName,
      'household_id': instance.householdId,
      'household_name': instance.householdName,
      'address': instance.address,
    };
