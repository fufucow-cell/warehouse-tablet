// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HouseholdImpl _$$HouseholdImplFromJson(Map<String, dynamic> json) =>
    _$HouseholdImpl(
      homeId: json['home_id'] as String?,
      homeName: json['home_name'] as String?,
      roleType: (json['role_type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$HouseholdImplToJson(_$HouseholdImpl instance) =>
    <String, dynamic>{
      'home_id': instance.homeId,
      'home_name': instance.homeName,
      'role_type': instance.roleType,
    };
