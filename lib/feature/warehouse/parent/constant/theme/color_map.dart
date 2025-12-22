/// 颜色 Key 枚举
/// 自动生成，请勿手动修改
/// 生成时间: 2025-12-22T14:34:47.549944
library;

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_data.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/theme_constant.dart';

import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/theme_util.dart';

enum EnumColor {
  accentBlue,
  accentGreen,
  accentRed,
  accentYellow,
  backgroundAccentBlue,
  backgroundAccentGreen,
  backgroundAccentRed,
  backgroundAccentYellow,
  backgroundGhost,
  backgroundItemGradient,
  backgroundPrimary,
  backgroundProduct,
  backgroundSecondary,
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
      final colorData = colorDataMap['${key}$num'];

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

    final themeUtil = ThemeUtil.instance;
    return switch (themeUtil.currentTheme) {
      EnumThemeMode.light => data.light,
      EnumThemeMode.dark => data.dark,
      EnumThemeMode.system =>
        themeUtil.getThemeFromSystem == EnumThemeMode.light
            ? data.light
            : data.dark,
    };
  }
}
