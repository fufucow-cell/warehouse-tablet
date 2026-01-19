import 'package:engo_terminal_app3/feature/app/service/app_service.dart';
import 'package:engo_terminal_app3/service/api_service/api_service.dart';
import 'package:engo_terminal_app3/service/api_service/api_service_model.dart' as api_model;
import 'package:engo_terminal_app3/service/router_service/router_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/home_household_request_model/home_household_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/home_household_response_model/home_household_response_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/user_login_response_model/user_login_response_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/api_service/api_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'smart_home_service_model.dart';

typedef ApiErrorHandler = void Function(BaseApiResponseModel<void> error);

class SmartHomeService {
  // MARK: - Properties

  final _model = SmartHomeServiceModel();
  LocaleService get _localeService => LocaleService.instance;
  ThemeService get _themeService => ThemeService.instance;
  LocaleTranslation get getCurrentLocale => _localeService.getCurrentTranslation;
  RouterService get _homeRouterService => RouterService.instance;
  EnvironmentService get _envService => EnvironmentService.instance;
  EnumThemeMode get getCurrentTheme => _themeService.currentTheme;
  List<LocaleTranslation> get getAvalibleLocales => _localeService.getAvalibleLocales;
  UserLoginResponseModel? get getUserData => AppService.instance.getUserData;
  HomeHouseholdResponseModel? get getHouseholdData => _model.homeHouseholdData;
  EnumEnvironment get getCurrentEnvironment => _envService.getCurrentEnvironment;
  String get getCurrentThemeName => _themeService.currentTheme.name;
  String get getCurrentLocaleCode => _localeService.getCurrentLocaleCode;
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

  BuildContext? getContext() {
    return _homeRouterService.rootContext;
  }

  /// 切換語言
  Future<bool> switchLocale(
    LocaleTranslation translation,
  ) async {
    return await _localeService.switchFromTranslation(translation);
  }

  /// 切換主題
  Future<bool> switchTheme(
    EnumThemeMode theme,
  ) async {
    return await _themeService.switchFromMode(theme);
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
