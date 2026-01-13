import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeServiceModel {
  /// 主題版本
  final String themeVersion = '1.0.0';

  /// 圖片根路徑
  final String imageRootPath = 'lib/wh/feature/warehouse/parent/assets/images';

  /// 預設主題
  final EnumThemeMode defaultTheme = EnumThemeMode.system;

  /// 當前主題
  final currentTheme = EnumThemeMode.system.obs;
}

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
