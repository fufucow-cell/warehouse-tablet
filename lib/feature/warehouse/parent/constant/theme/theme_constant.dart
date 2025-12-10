import 'package:flutter/material.dart';

/// 主題模式枚舉
enum EnumThemeMode {
  system,
  light,
  dark;

  String get displayName => switch (this) {
        EnumThemeMode.system => '跟隨系統',
        EnumThemeMode.light => '淺色模式',
        EnumThemeMode.dark => '深色模式',
      };

  ThemeMode get themeMode => switch (this) {
        EnumThemeMode.system => ThemeMode.system,
        EnumThemeMode.light => ThemeMode.light,
        EnumThemeMode.dark => ThemeMode.dark,
      };
}
