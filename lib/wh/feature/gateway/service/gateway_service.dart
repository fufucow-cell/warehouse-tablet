import 'package:engo_terminal_app3/wh/feature/gateway/page/main/gateway_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/service/gateway_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/router_service/router_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GatewayService extends GetxService {
  // MARK: - Properties

  final _model = GatewayServiceModel();
  RouterService get _routerService => RouterService.instance;
  BuildContext? get getRootNavigatorContext => _model.rootNavigatorContext;
  BuildContext? get getNestedNavigatorContext => _model.nestedNavigatorContext;
  static GatewayService get instance => Get.find<GatewayService>();

  // MARK: - Init

  GatewayService._internal();

  static GatewayService register() {
    if (Get.isRegistered<GatewayService>()) {
      return instance;
    }

    RouterService.register();
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
    _routerService.findRootNavigatorContext(context);
    _routerService.findNestedNavigatorContext(context);
    _model.rootNavigatorContext = _routerService.getRootNavigatorContext;
    _model.nestedNavigatorContext = _routerService.getNestedNavigatorContext;
  }

  void initRouterData(GatewayMainPageRouterData data) {
    EnvironmentService.register().setModuleMode(false);
    RouterService.register();
    LocaleService.register().then((value) => value.switchFromCode(data.language));
    ThemeService.register().switchFromString(data.theme);
  }
}
