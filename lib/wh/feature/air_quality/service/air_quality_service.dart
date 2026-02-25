import 'package:engo_terminal_app3/wh/feature/air_quality/page/box/air_quality_box_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/air_quality_purifier_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/service/air_quality_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/device_service/device_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/router_service/router_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/storage_service/storage_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirQualityService extends GetxService {
  // MARK: - Properties

  final _model = AirQualityServiceModel();
  BuildContext? get getRootNavigatorContext => _model.rootNavigatorContext;
  BuildContext? get getNestedNavigatorContext => _model.nestedNavigatorContext;
  static AirQualityService get instance => Get.find<AirQualityService>();

  // MARK: - Init

  AirQualityService._internal();

  /// 注册服务
  static AirQualityService register() {
    if (Get.isRegistered<AirQualityService>()) {
      return instance;
    }

    final AirQualityService service = AirQualityService._internal();
    Get.put<AirQualityService>(service, permanent: true);
    return service;
  }

  /// 注销服务
  static void unregister() {
    if (Get.isRegistered<AirQualityService>()) {
      Get.delete<AirQualityService>(force: true);
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

  void registerServices(AirQualityBoxPageRouterData data) {
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

  void registerServicesForPurifier(AirQualityPurifierPageRouterData data) {
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
