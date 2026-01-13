import 'dart:io';

import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Device Service Model
class DeviceServiceModel {
  // MARK: - Platform Properties

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

  // MARK: - Device Properties
  /// 是否為產品支援裝置
  bool isSupportedDevice = false;

  /// 是否為手機設備
  bool isMobile = false;

  /// 是否為 iPhone
  bool isIPhone = false;

  /// 是否為 Android 手機
  bool isAndroidPhone = false;

  /// 是否為平板設備
  bool isTablet = false;

  /// 是否為 iPad
  bool isIPad = false;

  /// 是否為 Android Pad
  bool isAndroidPad = false;

  /// 是否為模擬器
  bool? isSimulatorCache;

  /// 螢幕尺寸資訊（邏輯像素）
  Size screenSize = Size.zero;

  /// 設備像素比
  double devicePixelRatio = 1.0;

  /// 螢幕物理解析度（物理像素）
  Size physicalSize = Size.zero;

  /// 狀態列高度
  double statusBarHeight = 0.0;

  /// 底部安全區域高度
  double bottomSafeAreaHeight = 0.0;

  /// 是否為豎屏
  bool isPortrait = false;

  /// 設計與實機寬度比
  double scaleWidth = 0.0;

  /// 設計與實機高度比
  double scaleHeight = 0.0;

  /// 取得最小比例
  double minScale = 0.0;
}

/// 支援的裝置類型
enum EnumSupportedDevice {
  mobile,
  tablet;

  String get displayName => switch (this) {
        EnumSupportedDevice.mobile => EnumLocale.deviceMobile.tr,
        EnumSupportedDevice.tablet => EnumLocale.deviceTablet.tr,
      };

  /// 設計稿寬度（單位：px）
  double get designWidth => switch (this) {
        EnumSupportedDevice.mobile => 440.0,
        EnumSupportedDevice.tablet => 2000.0,
      };

  /// 設計稿高度（單位：px）
  double get designHeight => switch (this) {
        EnumSupportedDevice.mobile => 956.0,
        EnumSupportedDevice.tablet => 1200.0,
      };
}
