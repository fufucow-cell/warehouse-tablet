/// 颜色 Key 枚举
/// 自动生成，请勿手动修改
/// 生成时间: 2026-01-13T02:35:43.418362
library;

import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_data.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service_model.dart';
import 'package:flutter/material.dart';

enum EnumColor {
  accentBlue,
  accentGreen,
  accentRed,
  accentYellow,
  backgroundAccentBlue,
  backgroundAccentGreen,
  backgroundAccentRed,
  backgroundAccentYellow,
  backgroundButton,
  backgroundButtonFill,
  backgroundDropdown,
  backgroundGhost,
  backgroundItemGradient,
  backgroundLoadingBase,
  backgroundLoadingHighlight,
  backgroundPrimary,
  backgroundProduct,
  backgroundQuaternary,
  backgroundSecondary,
  backgroundTertiary,
  brand,
  iconPrimary,
  iconSecondary,
  iconWhite,
  lineBorder,
  lineDivider,
  lineDividerDark,
  lineDividerLight,
  lineProduct,
  menuBgFocused,
  menuIconDefault,
  menuIconFocused,
  shadowCard,
  textLink,
  textPrimary,
  textProduct,
  textSecondary,
  textWhite;

  String get key => name;

  Color get color => _getColor(colorDataMap[key]);

  List<Color> get colors {
    final result = <Color>[];

    for (var num = 1; num <= 100; num++) {
      final colorData = colorDataMap['$key$num'];

      if (colorData == null) {
        break;
      }

      result.add(_getColor(colorData));
    }

    return result;
  }

  Color _getColor(ColorData? data) {
    if (data == null) {
      return Colors.transparent;
    }

    final themeService = ThemeService.instance;
    return switch (themeService.currentTheme) {
      EnumThemeMode.light => data.light,
      EnumThemeMode.dark => data.dark,
      EnumThemeMode.system => themeService.getThemeFromSystem == EnumThemeMode.light ? data.light : data.dark,
    };
  }
}
