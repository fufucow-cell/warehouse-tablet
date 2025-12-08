import 'package:flutter/foundation.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/environment_constant.dart';
import 'package:get/get.dart';

class EnvironmentUtil extends GetxService {
  // MARK: - Properties

  static const String tagName = 'warehouse';

  /// 運行環境
  final Rx<EnumEnvironment> _currentEnvironment;
  EnumEnvironment get currentEnvironment =>
      _currentEnvironment.value;
  String get apiBaseUrl =>
      _currentEnvironment.value.apiBaseUrl;
  String get environmentName =>
      _currentEnvironment.value.displayName;

  /// 環境判斷
  bool get isDev =>
      _currentEnvironment.value == EnumEnvironment.dev;
  bool get isStg =>
      _currentEnvironment.value == EnumEnvironment.stg;
  bool get isUat =>
      _currentEnvironment.value == EnumEnvironment.uat;
  bool get isPrd =>
      _currentEnvironment.value == EnumEnvironment.prd;

  /// 調試模式判斷
  bool get isDebugMode => kDebugMode;

  /// 是否啟用 Mock API
  bool get enableMockApi => !isPrd;

  // MARK: - Init

  EnvironmentUtil._internal({EnumEnvironment? environment})
      : _currentEnvironment =
            (environment ?? EnumEnvironment.prd).obs;

  // MARK: - Public Method

  /// 切換環境
  void switchEnvironment(EnumEnvironment? env) {
    if (env != null) {
      _currentEnvironment.value = env;
    }
  }

  /// 註冊
  static EnvironmentUtil register([EnumEnvironment? env]) {
    if (Get.isRegistered<EnvironmentUtil>(tag: tagName)) {
      return Get.find<EnvironmentUtil>(tag: tagName);
    }

    final EnvironmentUtil service =
        EnvironmentUtil._internal(
      environment: env ?? _getLaunchEnvironment(),
    );

    Get.put<EnvironmentUtil>(
      service,
      permanent: true,
      tag: tagName,
    );
    return service;
  }

  /// 註銷
  static void unregister() {
    if (Get.isRegistered<EnvironmentUtil>(tag: tagName)) {
      Get.delete<EnvironmentUtil>(
        tag: tagName,
        force: true,
      );
    }
  }

  /// 單例
  static EnvironmentUtil get instance {
    if (!Get.isRegistered<EnvironmentUtil>(tag: tagName)) {
      register(EnumEnvironment.prd);
    }
    return Get.find<EnvironmentUtil>(tag: tagName);
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
  static EnumEnvironment _parseEnvironment(
    String envString,
  ) {
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
