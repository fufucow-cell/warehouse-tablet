import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';

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
