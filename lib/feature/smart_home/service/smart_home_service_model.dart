part of 'smart_home_service.dart';

class SmartHomeServiceModel {
  HomeHouseholdResponseModel? homeHouseholdData;
  // 保存所有已加载的家庭数据，key 為 householdId
  final Map<String, HomeHouseholdResponseModel> allHouseholdDataMap = {};
}
