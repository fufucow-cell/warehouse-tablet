import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/device_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/theme_util.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DeviceUtil extends GetxService {
  // MARK: - Properties

  LogUtil get _logService => LogUtil.instance;
  ThemeUtil get themeService => ThemeUtil.instance;

  /// 系統平台判斷
  bool get isIOS => Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;
  bool get isWeb => kIsWeb;
  bool get isDesktop => Platform.isMacOS || Platform.isWindows || Platform.isLinux;

  /// 取得設備語言
  Locale? get deviceLocale => Get.deviceLocale;

  /// 取得設備語言代碼
  String? get deviceLanguageCode => Get.deviceLocale?.languageCode;

  /// 取得國家代碼
  String? get deviceCountryCode => Get.deviceLocale?.countryCode;

  /// 取得系統版本資訊
  String get systemVersion {
    if (isWeb) {
      return 'Web not supported';
    }

    return Platform.operatingSystemVersion;
  }

  /// 是否為產品支援裝置
  bool _isSupportedDevice = false;
  bool get isSupportedDevice => _isSupportedDevice;

  /// 是否為手機設備
  bool _isMobile = false;
  bool get isMobile => _isMobile;

  /// 是否為 iPhone
  bool _isIPhone = false;
  bool get isIPhone => _isIPhone;

  /// 是否為 Android 手機
  bool _isAndroidPhone = false;
  bool get isAndroidPhone => _isAndroidPhone;

  /// 是否為平板設備
  bool _isTablet = false;
  bool get isTablet => _isTablet;

  /// 是否為 iPad
  bool _isIPad = false;
  bool get isIPad => _isIPad;

  /// 是否為 Android Pad
  bool _isAndroidPad = false;
  bool get isAndroidPad => _isAndroidPad;

  /// 是否為模擬器
  bool? _isSimulatorCache;
  bool get isSimulator {
    if (isWeb || isDesktop) {
      return false;
    }
    if (isIOS) {
      // 如果缓存已初始化，直接返回
      if (_isSimulatorCache != null) {
        return _isSimulatorCache!;
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

  /// 初始化模擬器檢測（異步，使用平台通道）
  Future<void> _initSimulatorCheck() async {
    if (isIOS && _isSimulatorCache == null) {
      try {
        const MethodChannel channel = MethodChannel('device_info');
        final bool? result = await channel.invokeMethod<bool>('isSimulator');
        if (result != null) {
          _isSimulatorCache = result;
          return;
        }
      } on Object catch (_) {}

      _isSimulatorCache = _checkIOSSimulatorFallback();
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

  /// 螢幕尺寸資訊（邏輯像素）
  Size _screenSize = Size.zero;
  Size get screenSize => _screenSize;

  /// 設備像素比
  double _devicePixelRatio = 1.0;
  double get devicePixelRatio => _devicePixelRatio;

  /// 螢幕物理解析度（物理像素）
  Size _physicalSize = Size.zero;
  Size get physicalSize => _physicalSize;

  /// 狀態列高度
  double _statusBarHeight = 0.0;
  double get statusBarHeight => _statusBarHeight;

  /// 底部安全區域高度
  double _bottomSafeAreaHeight = 0.0;
  double get bottomSafeAreaHeight => _bottomSafeAreaHeight;

  /// 是否為豎屏
  bool _isPortrait = false;
  bool get isPortrait => _isPortrait;

  /// 設計與實機寬度比
  double _scaleWidth = 0.0;
  double get scaleWidget => _scaleWidth;

  /// 設計與實機高度比
  double _scaleHeight = 0.0;
  double get scaleWidgetHeight => _scaleHeight;

  /// 取得最小比例
  double _minScale = 0.0;
  double get minScale => _minScale;

  // MARK: - Init

  DeviceUtil._internal();

  static DeviceUtil register(BuildContext context) {
    if (Get.isRegistered<DeviceUtil>()) {
      return Get.find<DeviceUtil>();
    }
    final DeviceUtil service = DeviceUtil._internal();
    Get.put<DeviceUtil>(service, permanent: true);
    service._initDeviceInfo(context);
    // 异步初始化模拟器检测
    service._initSimulatorCheck();
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<DeviceUtil>()) {
      Get.delete<DeviceUtil>(force: true);
    }
  }

  static DeviceUtil get instance => Get.find<DeviceUtil>();

  // MARK: - Public Method

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

  void _initDeviceInfo(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // 存儲螢幕尺寸（邏輯像素）
    _screenSize = mediaQuery.size;

    // 存儲設備像素比
    _devicePixelRatio = mediaQuery.devicePixelRatio;

    // 存儲螢幕物理解析度（物理像素）
    _physicalSize = Size(
      _screenSize.width * _devicePixelRatio,
      _screenSize.height * _devicePixelRatio,
    );

    // 存儲狀態列和底部安全區域高度
    _statusBarHeight = mediaQuery.padding.top;
    _bottomSafeAreaHeight = mediaQuery.padding.bottom;

    // 存儲螢幕方向
    _isPortrait = mediaQuery.orientation == Orientation.portrait;

    // 判斷是否為平板或手機設備（平板通常最短邊 >= 600）
    if (!isWeb && !isDesktop && (isIOS || isAndroid)) {
      _isTablet = _physicalSize.shortestSide >= 600;
      _isIPad = isIOS && isTablet;
      _isAndroidPad = isAndroid && isTablet;
      _isMobile = !isTablet;
      _isIPhone = isIOS && isMobile;
      _isAndroidPhone = isAndroid && isMobile;
    }

    // 計算設計與實機寬高比（先判斷平板，再判斷手機）
    if (isTablet) {
      const deviceType = EnumSupportedDevice.tablet;
      _scaleWidth = _screenSize.width / deviceType.designWidth;
      _scaleHeight = _screenSize.height / deviceType.designHeight;
    } else if (isMobile) {
      const deviceType = EnumSupportedDevice.mobile;
      _scaleWidth = _screenSize.width / deviceType.designWidth;
      _scaleHeight = _screenSize.height / deviceType.designHeight;
    }

    // 計算最小比例
    _minScale = _scaleWidth < _scaleHeight ? _scaleWidth : _scaleHeight;

    // 確認產品是否支援該裝置
    _isSupportedDevice = (isTablet || isMobile) && _minScale != 0.0;

    // double_extension.dart 參數設置
    scaleMin = _minScale;
    scaleWidth = _scaleWidth;
    scaleHeight = _scaleHeight;
  }
}
