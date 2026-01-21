import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/main/circuit_breaker_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/service/circuit_breaker_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/device_service/device_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/router_service/router_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/storage_service/storage_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircuitBreakerService extends GetxService {
  // MARK: - Properties

  final _model = CircuitBreakerServiceModel();
  BuildContext? get getRootNavigatorContext => _model.rootNavigatorContext;
  BuildContext? get getNestedNavigatorContext => _model.nestedNavigatorContext;
  static CircuitBreakerService get instance => Get.find<CircuitBreakerService>();

  // MARK: - Init

  CircuitBreakerService._internal();

  /// 注册服务
  static CircuitBreakerService register() {
    if (Get.isRegistered<CircuitBreakerService>()) {
      return instance;
    }

    final CircuitBreakerService service = CircuitBreakerService._internal();
    Get.put<CircuitBreakerService>(service, permanent: true);
    return service;
  }

  /// 注销服务
  static void unregister() {
    if (Get.isRegistered<CircuitBreakerService>()) {
      Get.delete<CircuitBreakerService>(force: true);
    }
  }

  @override
  void onClose() {
    unregister();
    super.onClose();
  }

  // MARK: - Public Method

  void setContext(BuildContext context) {
    final service = RouterService.register();
    _model.rootNavigatorContext = service.findRootNavigatorContext(context);
    _model.nestedNavigatorContext = service.findNestedNavigatorContext(context);
    DeviceService.register(context);
  }

  void registerServices(CircuitBreakerMainPageRouterData data) {
    LogService.register();
    if (data.isModuleMode != null) {
      EnvironmentService.register().initData(isModuleMode: data.isModuleMode!);
    }
    ThemeService.register();
    LocaleService.register();
    StorageService.register();

    if (data.isModuleMode == true) {
      if (data.language != null) {
        LocaleService.instance.switchFromCode(data.language!);
      }
      if (data.theme != null) {
        ThemeService.instance.switchFromString(data.theme!);
      }
    }
  }
}
