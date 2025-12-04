// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_household_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeHouseholdRequestModel _$HomeHouseholdRequestModelFromJson(
        Map<String, dynamic> json) =>
    HomeHouseholdRequestModel(
      homeId: (json['home_id'] as num?)?.toInt(),
      homeName: json['home_name'] as String?,
    );

Map<String, dynamic> _$HomeHouseholdRequestModelToJson(
        HomeHouseholdRequestModel instance) =>
    <String, dynamic>{
      'home_id': instance.homeId,
      'home_name': instance.homeName,
    };
