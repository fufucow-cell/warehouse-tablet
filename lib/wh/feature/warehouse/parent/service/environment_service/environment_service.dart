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
  static EnvironmentService register() {
    if (Get.isRegistered<EnvironmentService>()) {
      return Get.find<EnvironmentService>();
    }

    final EnvironmentService service = EnvironmentService._internal();
    final environment = service._getLaunchEnvironment();
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

    if (environment != null) {
      _model.currentEnvironment = EnumEnvironment.fromString(environment);
    }

    if (domainUrl != null) {
      _model.domainUrl = _appendWarehousePath(domainUrl);
    } else if (_model.domainUrl.isEmpty) {
      _model.domainUrl = _appendWarehousePath(_model.currentEnvironment.domainUrl);
    }
  }

  // MARK: - Private Method

  /// 取得啟動環境
  EnumEnvironment _getLaunchEnvironment() {
    const envString = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: 'DEV',
    );

    return EnumEnvironment.fromString(envString);
  }

  String _appendWarehousePath(String domainUrl) {
    final base = domainUrl.endsWith('/') ? domainUrl.substring(0, domainUrl.length - 1) : domainUrl;
    return '$base/${_model.warehousePath}';
  }
}
