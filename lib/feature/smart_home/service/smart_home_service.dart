import 'package:flutter_smart_home_tablet/feature/app/service/app_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/home_household_request_model/home_household_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/home_household_response_model/home_household_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/user_login_response_model/user_login_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/api_service/api_service_model.dart';
import 'package:flutter_smart_home_tablet/service/api_service/api_service.dart';
import 'package:flutter_smart_home_tablet/service/api_service/api_service_model.dart' as api_model;
import 'package:get/get.dart';

part 'smart_home_service_model.dart';

typedef ApiErrorHandler = void Function(BaseApiResponseModel<void> error);

class SmartHomeService {
  // MARK: - Properties

  final _model = SmartHomeServiceModel();
  UserLoginResponseModel? get getUserData => AppService.instance.getUserData;
  HomeHouseholdResponseModel? get getHouseholdData => _model.homeHouseholdData;
  static SmartHomeService get instance => Get.find<SmartHomeService>();

  // MARK: - Init

  SmartHomeService._internal();

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

  // MARK: - Public Method

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
    if (householdId == null) {
      return null;
    }
    return _model.allHouseholdDataMap[householdId];
  }

  String get getDomain => api_model.ApiServiceModel.instance.dio.options.baseUrl;

  // MARK: - API Request

  /// 讀取家庭數據
  Future<HomeHouseholdResponseModel?> apiReqReadHomeHousehold(
    String? householdId, {
    ApiErrorHandler? onError,
  }) async {
    final response = await ApiService.sendRequest<HomeHouseholdResponseModel>(
      EnumApiInfo.homeRead,
      requestModel: HomeHouseholdRequestModel(
        householdId: householdId?.toString(),
      ),
      fromJson: HomeHouseholdResponseModel.fromJson,
    );

    updateHomeHouseholdData(response);
    return response;
  }
}
