import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum EnumFontWeightType {
  regular,
  medium,
  semibold,
  bold;

  FontWeight get weight {
    return switch (this) {
      EnumFontWeightType.regular => FontWeight.w400,
      EnumFontWeightType.medium => FontWeight.w500,
      EnumFontWeightType.semibold => FontWeight.w600,
      EnumFontWeightType.bold => FontWeight.w700,
    };
  }
}

enum EnumTextFieldType {
  normal, // 普通文本
  integer, // 整數
  decimal; // 小數

  TextInputType get keyboardType {
    return switch (this) {
      EnumTextFieldType.normal => TextInputType.text,
      EnumTextFieldType.integer => TextInputType.number,
      EnumTextFieldType.decimal => const TextInputType.numberWithOptions(decimal: true),
    };
  }

  List<TextInputFormatter> get inputFormatters {
    return switch (this) {
      EnumTextFieldType.normal => <TextInputFormatter>[],
      EnumTextFieldType.integer => [
          FilteringTextInputFormatter.digitsOnly,
          _RemoveLeadingZerosFormatter(),
        ],
      EnumTextFieldType.decimal => [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        ],
    };
  }
}

/// 自動去掉開頭多餘的 0（如 01 → 1, 00 → 0），空字串時自動補 0
class _RemoveLeadingZerosFormatter extends TextInputFormatter {
  static final _regex = RegExp(r'^0+(.+)$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 如果輸入為空字串，自動補 0
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: '0',
        selection: TextSelection.collapsed(offset: 1),
      );
    }

    // 如果新值以一個或多個 0 開頭，且後面還有字符，去掉開頭的 0
    final match = _regex.firstMatch(newValue.text);
    if (match != null) {
      final newText = match.group(1)!;
      // 如果去掉開頭的 0 後為空字串，補 0
      if (newText.isEmpty) {
        return const TextEditingValue(
          text: '0',
          selection: TextSelection.collapsed(offset: 1),
        );
      }
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    return newValue;
  }
}

/// 创建文本样式
TextStyle CustTextStyle({
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
