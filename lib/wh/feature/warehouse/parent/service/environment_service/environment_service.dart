import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service_model.dart';
import 'package:get/get.dart';

class EnvironmentService extends GetxService {
  // MARK: - Properties

  final _model = EnvironmentServiceModel();
  EnumEnvironment get getCurrentEnvironment => _model.currentEnvironment;
  String get environmentName => _model.currentEnvironment.displayName;
  bool get isDev => _model.currentEnvironment == EnumEnvironment.dev;
  bool get isStg => _model.currentEnvironment == EnumEnvironment.stg;
  bool get isUat => _model.currentEnvironment == EnumEnvironment.uat;
  bool get isPrd => _model.currentEnvironment == EnumEnvironment.prd;
  bool get getEnableMockApi => !isPrd;
  bool get getIsModuleMode => _model.isModuleMode;
  String get getDomainUrl => _model.domainUrl;
  static EnvironmentService get instance => Get.find<EnvironmentService>();

  // MARK: - Init

  EnvironmentService._internal();

  /// 註冊
  static EnvironmentService register([EnumEnvironment? env]) {
    if (Get.isRegistered<EnvironmentService>()) {
      return Get.find<EnvironmentService>();
    }

    final EnvironmentService service = EnvironmentService._internal();
    final environment = env ?? service._getLaunchEnvironment();
    service._model.currentEnvironment = environment;

    Get.put<EnvironmentService>(
      service,
      permanent: true,
    );
    return service;
  }

  /// 註銷
  static void unregister() {
    if (Get.isRegistered<EnvironmentService>()) {
      Get.delete<EnvironmentService>(
        force: true,
      );
    }
  }

  // MARK: - Public Method

  /// 切換環境
  void switchEnvironment(EnumEnvironment? env) {
    if (env != null) {
      _model.currentEnvironment = env;
    }
  }

  void initData({required bool isModuleMode, String? domainUrl, String? environment}) {
    _model.isModuleMode = isModuleMode;
    _model.currentEnvironment = EnumEnvironment.fromString(environment);
    _model.domainUrl = domainUrl ?? _model.currentEnvironment.domainUrl;
  }

  // MARK: - Private Method

  /// 取得啟動環境
  EnumEnvironment _getLaunchEnvironment() {
    final envString = String.fromEnvironment(
      _model.launchEnvironmentKey,
      defaultValue: 'dev',
    ).toLowerCase();

    return _parseEnvironment(envString);
  }

  /// 解析環境字串為 EnumEnvironment
  /// 如果無法解析，預設返回 dev
  EnumEnvironment _parseEnvironment(
    String envString,
  ) {
    return EnumEnvironment.values.firstWhere(
      (e) => e.name == envString,
      orElse: () => EnumEnvironment.dev,
    );
  }
}
