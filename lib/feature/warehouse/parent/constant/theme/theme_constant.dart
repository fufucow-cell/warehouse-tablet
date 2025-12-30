import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';

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
