import 'package:flutter/foundation.dart';
import 'package:flutter_smart_home_tablet/constant/environment_constant.dart';
import 'package:get/get.dart';

class EnvironmentUtil extends GetxService {
  // MARK: - Properties

  /// 運行環境
  final Rx<EnumEnvironment> _currentEnvironment = EnumEnvironment.prd.obs;
  EnumEnvironment get currentEnvironment => _currentEnvironment.value;
  String get apiBaseUrl => _currentEnvironment.value.apiBaseUrl;
  String get environmentName => _currentEnvironment.value.displayName;

  /// 環境判斷
  bool get isDev => _currentEnvironment.value == EnumEnvironment.dev;
  bool get isStg => _currentEnvironment.value == EnumEnvironment.stg;
  bool get isUat => _currentEnvironment.value == EnumEnvironment.uat;
  bool get isPrd => _currentEnvironment.value == EnumEnvironment.prd;

  /// 調試模式判斷
  bool get isDebugMode => kDebugMode;

  /// 是否啟用 Mock API
  bool get enableMockApi => !isPrd;

  // MARK: - Init

  EnvironmentUtil._internal();

  // MARK: - Public Method

  /// 切換環境
  void switchEnvironment(EnumEnvironment? env) {
    if (env != null) {
      _currentEnvironment.value = env;
    }
  }

  /// 註冊
  static EnvironmentUtil register([EnumEnvironment? env]) {
    if (Get.isRegistered<EnvironmentUtil>()) {
      return Get.find<EnvironmentUtil>();
    }

    final EnvironmentUtil service = EnvironmentUtil._internal();
    service.switchEnvironment(env ?? _getLaunchEnvironment());

    Get.put<EnvironmentUtil>(service, permanent: true);
    return service;
  }

  /// 註銷
  static void unregister() {
    if (Get.isRegistered<EnvironmentUtil>()) {
      Get.delete<EnvironmentUtil>(force: true);
    }
  }

  /// 單例
  static EnvironmentUtil get instance {
    if (!Get.isRegistered<EnvironmentUtil>()) {
      register(EnumEnvironment.prd);
    }
    return Get.find<EnvironmentUtil>();
  }

  // MARK: - Private Method

  /// 取得啟動環境
  static EnumEnvironment _getLaunchEnvironment() {
    final envString = const String.fromEnvironment(
      launchEnvironmentKey,
      defaultValue: defaultEnvironment,
    ).toLowerCase();

    return _parseEnvironment(envString);
  }

  /// 解析環境字串為 EnumEnvironment
  /// 如果無法解析，預設返回 dev
  static EnumEnvironment _parseEnvironment(String envString) {
    switch (envString) {
      case 'dev':
        return EnumEnvironment.dev;
      case 'stg':
        return EnumEnvironment.stg;
      case 'uat':
        return EnumEnvironment.uat;
      case 'prd':
        return EnumEnvironment.prd;
      default:
        return EnumEnvironment.dev;
    }
  }
}
