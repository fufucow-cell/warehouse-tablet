import 'package:engo_terminal_app3/wh/feature/gateway/page/main/gateway_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/service/gateway_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/device_service/device_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/router_service/router_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/storage_service/storage_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GatewayService extends GetxService {
  // MARK: - Properties

  final _model = GatewayServiceModel();
  BuildContext? get getRootNavigatorContext => _model.rootNavigatorContext;
  BuildContext? get getNestedNavigatorContext => _model.nestedNavigatorContext;
  static GatewayService get instance => Get.find<GatewayService>();

  // MARK: - Init

  GatewayService._internal();

  static GatewayService register() {
    if (Get.isRegistered<GatewayService>()) {
      return instance;
    }

    final GatewayService service = GatewayService._internal();
    Get.put<GatewayService>(service, permanent: true);
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<GatewayService>()) {
      Get.delete<GatewayService>(force: true);
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

  void registerServices(GatewayMainPageRouterData data) {
    LogService.register();
    EnvironmentService.register().initData(isModuleMode: data.isModuleMode);
    ThemeService.register();
    LocaleService.register();
    StorageService.register();

    if (data.isModuleMode) {
      LocaleService.instance.switchFromCode(data.language);
      ThemeService.instance.switchFromString(data.theme);
    }
  }
}
