import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/device_service/device_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/router_service/router_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/storage_service/storage_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/main/water_value_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/service/water_value_service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterValueService extends GetxService {
  // MARK: - Properties

  final _model = WaterValueServiceModel();
  BuildContext? get getRootNavigatorContext => _model.rootNavigatorContext;
  BuildContext? get getNestedNavigatorContext => _model.nestedNavigatorContext;
  static WaterValueService get instance => Get.find<WaterValueService>();

  // MARK: - Init

  WaterValueService._internal();

  /// 注册服务
  static WaterValueService register() {
    if (Get.isRegistered<WaterValueService>()) {
      return instance;
    }

    final WaterValueService service = WaterValueService._internal();
    Get.put<WaterValueService>(service, permanent: true);
    return service;
  }

  /// 注销服务
  static void unregister() {
    if (Get.isRegistered<WaterValueService>()) {
      Get.delete<WaterValueService>(force: true);
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

  void registerServices(WaterValueMainPageRouterData data) {
    LogService.register();
    EnvironmentService.register().initData(isModuleMode: data.isModuleMode ?? false);
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

  // MARK: - Private Method
}
