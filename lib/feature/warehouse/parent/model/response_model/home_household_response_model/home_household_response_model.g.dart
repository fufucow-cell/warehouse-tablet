// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_household_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeHouseholdResponseModelImpl _$$HomeHouseholdResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeHouseholdResponseModelImpl(
      householdId: json['household_id'] as String?,
      homeName: json['home_name'] as String?,
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      rooms: (json['rooms'] as List<dynamic>?)
          ?.map((e) => Room.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HomeHouseholdResponseModelImplToJson(
        _$HomeHouseholdResponseModelImpl instance) =>
    <String, dynamic>{
      'household_id': instance.householdId,
      'home_name': instance.homeName,
      'users': instance.users?.map((e) => e.toJson()).toList(),
      'rooms': instance.rooms?.map((e) => e.toJson()).toList(),
    };
