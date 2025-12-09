/// 支援的裝置類型
enum EnumSupportedDevice {
  mobile,
  tablet;

  String get displayName => switch (this) {
        EnumSupportedDevice.mobile => '行動裝置',
        EnumSupportedDevice.tablet => '平板裝置',
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
