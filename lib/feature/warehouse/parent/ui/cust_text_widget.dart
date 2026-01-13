import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';

/// 自定义文本 Widget
class CustTextWidget extends StatelessWidget {
  final String text;
  final double? size;
  final TextAlign align;
  final EnumFontWeightType weightType;
  final Color? color;
  final int? maxLines;
  final TextOverflow overflow;

  const CustTextWidget(
    this.text, {
    super.key,
    this.size,
    this.align = TextAlign.start,
    this.weightType = EnumFontWeightType.regular,
    this.color,
    this.maxLines,
    this.overflow = TextOverflow.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: _textStyle(
        size: size,
        weightType: weightType,
        color: color ?? EnumColor.textPrimary.color,
      ),
    );
  }
}

/// 自定义带必填标记的文本 Widget
class CustTextRequiredWidget extends StatelessWidget {
  final String text;
  final double? size;
  final TextAlign align;
  final EnumFontWeightType weightType;
  final Color? color;
  final int? maxLines;
  final TextOverflow overflow;

  const CustTextRequiredWidget(
    this.text, {
    super.key,
    this.size,
    this.align = TextAlign.start,
    this.weightType = EnumFontWeightType.regular,
    this.color,
    this.maxLines,
    this.overflow = TextOverflow.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '*',
          style: _textStyle(
            size: size,
            weightType: weightType,
            color: EnumColor.accentRed.color,
          ),
        ),
        Text(
          text,
          textAlign: align,
          maxLines: maxLines,
          overflow: overflow,
          style: _textStyle(
            size: size,
            weightType: weightType,
            color: color ?? EnumColor.textPrimary.color,
          ),
        ),
      ],
    );
  }
}

/// 创建文本样式（私有方法）
TextStyle _textStyle({
  double? size,
  EnumFontWeightType weightType = EnumFontWeightType.regular,
  Color? color,
}) {
  return CustTextStyle(
    size: size,
    weightType: weightType,
    color: color,
  );
}
