import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/device_service/device_service_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/log_service/log_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DeviceService extends GetxService {
  // MARK: - Properties

  final _model = DeviceServiceModel();
  LogService get _logService => LogService.instance;
  ThemeService get themeService => ThemeService.instance;
  static DeviceService get instance => Get.find<DeviceService>();

  // Public getters for model properties
  bool get isSupportedDevice => _model.isSupportedDevice;
  double get minScale => _model.minScale;
  double get scaleWidthValue => _model.scaleWidth;
  double get scaleHeightValue => _model.scaleHeight;

  // MARK: - Init

  DeviceService._internal();

  static DeviceService register(BuildContext context) {
    if (Get.isRegistered<DeviceService>()) {
      return Get.find<DeviceService>();
    }
    final DeviceService service = DeviceService._internal();
    Get.put<DeviceService>(service, permanent: true);
    service._initDeviceInfo(context);
    // 异步初始化模拟器检测
    service._initSimulatorCheck();
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<DeviceService>()) {
      Get.delete<DeviceService>(force: true);
    }
  }

  // MARK: - Public Method

  /// 是否為模擬器
  bool get isSimulator {
    if (isWeb || isDesktop) {
      return false;
    }
    if (isIOS) {
      // 如果缓存已初始化，直接返回
      if (_model.isSimulatorCache != null) {
        return _model.isSimulatorCache!;
      }
      // 否则使用回退检测方法（同步）
      return _checkIOSSimulatorFallback();
    } else if (isAndroid) {
      return systemVersion.toLowerCase().contains('sdk') ||
          systemVersion.toLowerCase().contains('emulator') ||
          Platform.environment.containsKey('ANDROID_EMULATOR');
    }
    return false;
  }

  Future<String?> openCamera() async {
    // 如果是模擬器，顯示提示並返回
    if (isSimulator) {
      _logService.showSnackBar(
        title: EnumLocale.deviceCameraNotAvailable.tr,
        message: '',
      );
      return null;
    }

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      return image?.path;
    } on Object catch (e) {
      _logService.showSnackBar(
        title: EnumLocale.deviceCameraFailed.tr,
        message: e.toString(),
      );
      return null;
    }
  }

  Future<String?> openGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      return image?.path;
    } on Object catch (e) {
      _logService.showSnackBar(
        title: EnumLocale.deviceGalleryFailed.tr,
        message: e.toString(),
      );
      return null;
    }
  }

  // MARK: - Private Method

  /// 初始化模擬器檢測（異步，使用平台通道）
  Future<void> _initSimulatorCheck() async {
    if (isIOS && _model.isSimulatorCache == null) {
      try {
        const MethodChannel channel = MethodChannel('device_info');
        final bool? result = await channel.invokeMethod<bool>('isSimulator');
        if (result != null) {
          _model.isSimulatorCache = result;
          return;
        }
      } on Object catch (_) {}

      _model.isSimulatorCache = _checkIOSSimulatorFallback();
    }
  }

  /// 檢查 iOS 模擬器（回退方法，同步）
  bool _checkIOSSimulatorFallback() {
    // 回退检测方法
    return Platform.environment.containsKey('SIMULATOR_DEVICE_NAME') ||
        Platform.environment.containsKey('SIMULATOR_ROOT') ||
        Platform.environment.containsKey('SIMULATOR_UDID') ||
        systemVersion.toLowerCase().contains('simulator');
  }

  void _initDeviceInfo(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // 存儲螢幕尺寸（邏輯像素）
    _model.screenSize = mediaQuery.size;

    // 存儲設備像素比
    _model.devicePixelRatio = mediaQuery.devicePixelRatio;

    // 存儲螢幕物理解析度（物理像素）
    _model.physicalSize = Size(
      _model.screenSize.width * _model.devicePixelRatio,
      _model.screenSize.height * _model.devicePixelRatio,
    );

    // 存儲狀態列和底部安全區域高度
    _model.statusBarHeight = mediaQuery.padding.top;
    _model.bottomSafeAreaHeight = mediaQuery.padding.bottom;

    // 存儲螢幕方向
    _model.isPortrait = mediaQuery.orientation == Orientation.portrait;

    // 判斷是否為平板或手機設備（平板通常最短邊 >= 600）
    if (!isWeb && !isDesktop && (isIOS || isAndroid)) {
      _model.isTablet = _model.physicalSize.shortestSide >= 600;
      _model.isIPad = isIOS && _model.isTablet;
      _model.isAndroidPad = isAndroid && _model.isTablet;
      _model.isMobile = !_model.isTablet;
      _model.isIPhone = isIOS && _model.isMobile;
      _model.isAndroidPhone = isAndroid && _model.isMobile;
    }

    // 計算設計與實機寬高比（先判斷平板，再判斷手機）
    if (_model.isTablet) {
      const deviceType = EnumSupportedDevice.tablet;
      _model.scaleWidth = _model.screenSize.width / deviceType.designWidth;
      _model.scaleHeight = _model.screenSize.height / deviceType.designHeight;
    } else if (_model.isMobile) {
      const deviceType = EnumSupportedDevice.mobile;
      _model.scaleWidth = _model.screenSize.width / deviceType.designWidth;
      _model.scaleHeight = _model.screenSize.height / deviceType.designHeight;
    }

    // 計算最小比例
    _model.minScale = _model.scaleWidth < _model.scaleHeight ? _model.scaleWidth : _model.scaleHeight;

    // 確認產品是否支援該裝置
    _model.isSupportedDevice = (_model.isTablet || _model.isMobile) && _model.minScale != 0.0;

    // double_extension.dart 參數設置
    scaleMin = _model.minScale;
    scaleWidth = _model.scaleWidth; // Top-level variable from extension_double.dart
    scaleHeight = _model.scaleHeight; // Top-level variable from extension_double.dart
  }
}
