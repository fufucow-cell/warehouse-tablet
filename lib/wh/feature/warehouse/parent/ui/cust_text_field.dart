import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustTextField extends StatelessWidget {
  const CustTextField({
    super.key,
    required this.controller,
    this.height,
    this.textFieldType = EnumTextFieldType.normal,
    this.hintText,
    this.fontSize,
    this.textColor,
    this.hintColor,
    this.keyboardType,
    this.maxLines,
    this.expands,
    this.textAlignVertical,
    this.textAlign = TextAlign.start,
    this.padding,
    this.maxLength,
    this.prefixIcon,
    this.prefixIconSize,
    this.isReadOnly = false,
  });

  final TextEditingController controller;
  final double? height;
  final EnumTextFieldType textFieldType;
  final String? hintText;
  final double? fontSize;
  final Color? textColor;
  final Color? hintColor;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool? expands;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? padding;
  final int? maxLength;
  final Widget? prefixIcon;
  final double? prefixIconSize;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 32.0.scale,
          ),
      height: height ?? 70.0.scale,
      decoration: BoxDecoration(
        color: isReadOnly ? EnumColor.backgroundSecondary.color : EnumColor.backgroundDropdown.color,
        border: Border.all(
          width: 1.0.scale,
          color: EnumColor.lineBorder.color,
        ),
        borderRadius: BorderRadius.circular(16.0.scale),
      ),
      child: TextField(
        readOnly: isReadOnly,
        controller: controller,
        keyboardType: keyboardType ?? textFieldType.keyboardType,
        maxLines: maxLines ?? (expands == true ? null : 1),
        expands: expands ?? false,
        textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
        textAlign: textAlign,
        maxLength: maxLength,
        inputFormatters: () {
          final formatters = textFieldType.inputFormatters;

          if (maxLength != null) {
            formatters.add(LengthLimitingTextInputFormatter(maxLength));
          }

          return formatters.isNotEmpty ? formatters : null;
        }(),
        style: TextStyle(
          fontSize: fontSize ?? 32.0.scale,
          color: textColor ?? EnumColor.textPrimary.color,
        ),
        decoration: InputDecoration(
          hintText: hintText ?? EnumLocale.commonInputHint.tr,
          hintStyle: TextStyle(
            fontSize: fontSize ?? 32.0.scale,
            color: hintColor ?? EnumColor.textSecondary.color,
          ),
          prefixIcon: prefixIcon != null
              ? Container(
                  width: prefixIconSize,
                  height: prefixIconSize,
                  margin: EdgeInsets.only(right: 16.0.scale),
                  alignment: Alignment.center,
                  child: prefixIcon,
                )
              : null,
          border: InputBorder.none,
          isDense: true,
          counterText: '', // 隱藏字符計數器
        ),
      ),
    );
  }
}
