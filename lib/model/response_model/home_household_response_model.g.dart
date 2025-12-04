// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_household_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeHouseholdResponseModel _$HomeHouseholdResponseModelFromJson(
        Map<String, dynamic> json) =>
    HomeHouseholdResponseModel(
      homeId: (json['home_id'] as num?)?.toInt(),
      homeName: json['home_name'] as String?,
    );

Map<String, dynamic> _$HomeHouseholdResponseModelToJson(
        HomeHouseholdResponseModel instance) =>
    <String, dynamic>{
      'home_id': instance.homeId,
      'home_name': instance.homeName,
    };
