import 'package:flutter_smart_home_tablet/feature/app/service/app_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/home_household_response_model/home_household_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/user_login_response_model/user_login_response_model.dart';
import 'package:get/get.dart';

part 'smart_home_service_model.dart';

class SmartHomeService {
  // MARK: - Properties

  final _model = SmartHomeServiceModel();
  UserLoginResponseModel? get getUserData => AppService.instance.getUserData;
  HomeHouseholdResponseModel? get getHouseholdData => _model.homeHouseholdData;
  Map<String, HomeHouseholdResponseModel> get allHouseholdDataMap =>
      _model.allHouseholdDataMap;

  // MARK: - Init

  SmartHomeService._internal();

  // MARK: - Public Method

  static SmartHomeService register() {
    if (Get.isRegistered<SmartHomeService>()) {
      return Get.find<SmartHomeService>();
    } else {
      final service = SmartHomeService._internal();
      Get.put<SmartHomeService>(service, permanent: true);
      return service;
    }
  }

  static void unregister() {
    if (Get.isRegistered<SmartHomeService>()) {
      Get.delete<SmartHomeService>(force: true);
    }
  }

  static SmartHomeService get instance => register();

  void updateHomeHouseholdData(
    HomeHouseholdResponseModel? data,
  ) {
    _model.homeHouseholdData = data;
    // 同時保存到 Map 中
    if (data?.householdId != null) {
      _model.allHouseholdDataMap[data!.householdId!] = data;
    }
  }

  // 根據 householdId 獲取已保存的家庭數據
  HomeHouseholdResponseModel? getHouseholdDataById(String? householdId) {
    if (householdId == null) return null;
    return _model.allHouseholdDataMap[householdId];
  }
}
