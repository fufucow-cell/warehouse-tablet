import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';

/// 主題版本
const themeVersion = '1.0.0';

/// 圖片根路徑
const String imageRootPath = 'lib/feature/warehouse/parent/assets/images';

/// 預設主題
const EnumThemeMode defaultTheme = EnumThemeMode.system;

/// 主題模式枚舉
enum EnumThemeMode {
  system,
  light,
  dark;

  String get displayName => switch (this) {
        EnumThemeMode.system => EnumLocale.themeFollowSystem.tr,
        EnumThemeMode.light => EnumLocale.themeLightMode.tr,
        EnumThemeMode.dark => EnumLocale.themeDarkMode.tr,
      };

  ThemeMode get themeMode => switch (this) {
        EnumThemeMode.system => ThemeMode.system,
        EnumThemeMode.light => ThemeMode.light,
        EnumThemeMode.dark => ThemeMode.dark,
      };
}
