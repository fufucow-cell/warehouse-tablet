import 'package:flutter/material.dart';

class ColorData {
  // MARK: - Properties

  final Color light;
  final Color dark;

  // MARK: - Init

  const ColorData({
    required this.light,
    required this.dark,
  });
}

const Map<String, ColorData> colorDataMap = {
  'brand': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFF0000FF),
  ),
  'text_primary': ColorData(
    light: Color(0xFF292929),
    dark: Color(0xFFFFFFFF),
  ),
  'text_secondary': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0xFFDCDCDC),
  ),
  'text_white': ColorData(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFFFFFFFF),
  ),
  'text_product': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFFFDB874),
  ),
  'text_link': ColorData(
    light: Color(0xFF2791F3),
    dark: Color(0xFF2791F3),
  ),
  'accent_red': ColorData(
    light: Color(0xFFF04526),
    dark: Color(0xFFF04526),
  ),
  'accent_green': ColorData(
    light: Color(0xFF41CF5F),
    dark: Color(0xFF41CF5F),
  ),
  'accent_blue': ColorData(
    light: Color(0xFF366FB6),
    dark: Color(0xFF96B7E3),
  ),
  'accent_yellow': ColorData(
    light: Color(0xFFFFCF21),
    dark: Color(0xFFFFCF21),
  ),
  'background_primary': ColorData(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFF242632),
  ),
  'background_secondary': ColorData(
    light: Color(0xFFF6F6F6),
    dark: Color(0xFF2F333F),
  ),
  'background_ghost': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0x00FFFFFF),
  ),
  'background_product': ColorData(
    light: Color(0x80FDB874),
    dark: Color(0x80FDB874),
  ),
  'background_item_gradient_1': ColorData(
    light: Color(0x66FFFFFF),
    dark: Color(0x66FFFFFF),
  ),
  'background_item_gradient_2': ColorData(
    light: Color(0x00FBBB84),
    dark: Color(0x00FBBB84),
  ),
  'line_divider': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0xFFDCDCDC),
  ),
  'line_divider_light': ColorData(
    light: Color(0xFFDCDCDC),
    dark: Color(0xFF7C7C7C),
  ),
  'line_divider_dark': ColorData(
    light: Color(0xFF292929),
    dark: Color(0xFFEFEFEF),
  ),
  'line_border': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0xFF989898),
  ),
  'line_product': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFFDCDCDC),
  ),
  'icon_primary': ColorData(
    light: Color(0xFF292929),
    dark: Color(0xFFFFFFFF),
  ),
  'icon_secondary': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0xFFEFEFEF),
  ),
  'icon_white': ColorData(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFFFFFFFF),
  ),
  'menu_icon_default': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0xFFDCDCDC),
  ),
  'menu_icon_focused': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFFFDB874),
  ),
  'menu_bg_focused': ColorData(
    light: Color(0x4DF1D0AD),
    dark: Color(0x4DF1D0AD),
  ),
};
