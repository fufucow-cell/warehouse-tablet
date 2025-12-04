import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/constant/device_constant.dart';
import 'package:flutter_smart_home_tablet/inherit/double_extension.dart';
import 'package:get/get.dart';

class DeviceUtil extends GetxService {
  // MARK: - Properties

  /// 系統平台判斷
  bool get isIOS => Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;
  bool get isWeb => kIsWeb;
  bool get isDesktop =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;

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

  /// 螢幕尺寸資訊
  Size _screenSize = Size.zero;
  Size get screenSize => _screenSize;

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

  // MARK: - Public Method

  /// 註冊
  static DeviceUtil register(BuildContext context) {
    if (Get.isRegistered<DeviceUtil>()) {
      return Get.find<DeviceUtil>();
    }
    final DeviceUtil service = DeviceUtil._internal();
    Get.put<DeviceUtil>(service, permanent: true);
    service._initDeviceInfo(context);
    return service;
  }

  /// 註銷
  static void unregister() {
    if (Get.isRegistered<DeviceUtil>()) {
      Get.delete<DeviceUtil>(force: true);
    }
  }

  /// 取得實例
  static DeviceUtil get instance => Get.find<DeviceUtil>();

  // MARK: - Private Method

  void _initDeviceInfo(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // 存儲螢幕尺寸
    _screenSize = mediaQuery.size;

    // 存儲狀態列和底部安全區域高度
    _statusBarHeight = mediaQuery.padding.top;
    _bottomSafeAreaHeight = mediaQuery.padding.bottom;

    // 存儲螢幕方向
    _isPortrait = mediaQuery.orientation == Orientation.portrait;

    // 判斷是否為平板或手機設備（平板通常最短邊 >= 600）
    if (!isWeb && !isDesktop && (isIOS || isAndroid)) {
      _isTablet = _screenSize.shortestSide >= 600;
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
    _minScale =
        _scaleWidth < _scaleHeight ? _scaleWidth : _scaleHeight;

    // 確認產品是否支援該裝置
    _isSupportedDevice = (isTablet || isMobile) && _minScale != 0.0;

    // double_extension.dart 參數設置
    scaleMin = _minScale;
    scaleWidth = _scaleWidth;
    scaleHeight = _scaleHeight;
  }
}
