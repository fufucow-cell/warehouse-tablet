/// 颜色 Key 枚举
/// 自动生成，请勿手动修改
/// 生成时间: 2025-12-10T15:32:12.910145
library;

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_data.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/theme_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_string.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/theme_util.dart';

enum EnumColor {
  accentBlue,
  accentGreen,
  accentRed,
  accentYellow,
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
  testGradient,
  textLink,
  textPrimary,
  textProduct,
  textSecondary,
  textWhite;

  ThemeUtil get _themeUtil => ThemeUtil.instance;

  String get key => name.toSnakeCase();

  Color get color => _getColor(colorDataMap[key]);

  List<Color> get colors {
    final result = <Color>[];

    for (var num = 1; num <= 100; num++) {
      final colorData = colorDataMap['${key}_$num'];

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

    return switch (_themeUtil.currentTheme) {
      EnumThemeMode.light => data.light,
      EnumThemeMode.dark => data.dark,
      EnumThemeMode.system =>
        _themeUtil.getThemeFromSystem == EnumThemeMode.light
            ? data.light
            : data.dark,
    };
  }
}
