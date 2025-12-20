import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';

class WidgetUtil {
  static Widget textWidget(
    String text, {
    double? size,
    TextAlign align = TextAlign.start,
    EnumFontWeightType weightType = EnumFontWeightType.regular,
    Color? color,
    int? maxLines,
    TextOverflow overflow = TextOverflow.visible,
  }) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: textStyle(
        size: size,
        weightType: weightType,
        color: color ?? EnumColor.textPrimary.color,
      ),
    );
  }

  static TextStyle textStyle({
    double? size,
    EnumFontWeightType weightType = EnumFontWeightType.regular,
    Color? color,
  }) {
    return TextStyle(
      color: color ?? EnumColor.textPrimary.color,
      fontSize: size ?? 32.0.scale,
      fontWeight: weightType.weight,
      height: 1.4,
      letterSpacing: 0,
    );
  }
}
