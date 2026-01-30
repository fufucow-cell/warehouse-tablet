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
  'textPrimary': ColorData(
    light: Color(0xFF292929),
    dark: Color(0xFFFFFFFF),
  ),
  'textSecondary': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0xFFDCDCDC),
  ),
  'textWhite': ColorData(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFFFFFFFF),
  ),
  'textProduct': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFFFDB874),
  ),
  'textLink': ColorData(
    light: Color(0xFF2791F3),
    dark: Color(0xFF2791F3),
  ),
  'accentRed': ColorData(
    light: Color(0xFFF04526),
    dark: Color(0xFFF04526),
  ),
  'accentGreen': ColorData(
    light: Color(0xFF41CF5F),
    dark: Color(0xFF41CF5F),
  ),
  'accentBlue': ColorData(
    light: Color(0xFF366FB6),
    dark: Color(0xFF96B7E3),
  ),
  'accentYellow': ColorData(
    light: Color(0xFFFFCF21),
    dark: Color(0xFFFFCF21),
  ),
  'backgroundPrimary': ColorData(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFF242632),
  ),
  'backgroundSecondary': ColorData(
    light: Color(0xFFF6F6F6),
    dark: Color(0xFF2F333F),
  ),
  'backgroundTertiary': ColorData(
    light: Color(0xFFE4E4E4),
    dark: Color(0xFF444651),
  ),
  'backgroundQuaternary': ColorData(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFF3F434E),
  ),
  'backgroundGhost': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0x00FFFFFF),
  ),
  'backgroundProduct': ColorData(
    light: Color(0x80FDB874),
    dark: Color(0x80FDB874),
  ),
  'backgroundItemGradient1': ColorData(
    light: Color(0x66FFFFFF),
    dark: Color(0x66FFFFFF),
  ),
  'backgroundItemGradient2': ColorData(
    light: Color(0x00FBBB84),
    dark: Color(0x00FBBB84),
  ),
  'backgroundAccentGreen': ColorData(
    light: Color(0x1F41CF5F),
    dark: Color(0x3D41CF5F),
  ),
  'backgroundAccentBlue': ColorData(
    light: Color(0x1F366FB6),
    dark: Color(0x3D96B7E3),
  ),
  'backgroundAccentRed': ColorData(
    light: Color(0x1FF04526),
    dark: Color(0x3DF04526),
  ),
  'backgroundAccentYellow': ColorData(
    light: Color(0x1FFFCF21),
    dark: Color(0x3DFFCF21),
  ),
  'backgroundDropdown': ColorData(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFF35384A),
  ),
  'backgroundButton': ColorData(
    light: Color(0xFFFDB874),
    dark: Color(0xFFFDB874),
  ),
  'backgroundLoadingBase': ColorData(
    light: Color(0xFFE4E4E4),
    dark: Color(0xFF2F333F),
  ),
  'backgroundLoadingHighlight': ColorData(
    light: Color(0xFFF6F6F6),
    dark: Color(0xFF444651),
  ),
  'lineDivider': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0xFFDCDCDC),
  ),
  'lineDividerLight': ColorData(
    light: Color(0xFFDCDCDC),
    dark: Color(0xFF7C7C7C),
  ),
  'lineDividerDark': ColorData(
    light: Color(0xFF292929),
    dark: Color(0xFFEFEFEF),
  ),
  'lineBorder': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0xFF989898),
  ),
  'lineProduct': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFFFDB874),
  ),
  'iconPrimary': ColorData(
    light: Color(0xFF292929),
    dark: Color(0xFFFFFFFF),
  ),
  'iconSecondary': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0xFFEFEFEF),
  ),
  'iconWhite': ColorData(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFFFFFFFF),
  ),
  'menuIconDefault': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0xFFDCDCDC),
  ),
  'menuIconFocused': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFFFDB874),
  ),
  'menuBgFocused': ColorData(
    light: Color(0x4DF1D0AD),
    dark: Color(0x4DF1D0AD),
  ),
  'progressTrack': ColorData(
    light: Color(0xFFD9D9D9),
    dark: Color(0xFFD9D9D9),
  ),
  'shadowCard': ColorData(
    light: Color(0x1F292929),
    dark: Color(0x1F292929),
  ),
  'engoTextPrimary': ColorData(
    light: Color(0xFF292929),
    dark: Color(0xFFFFFFFF),
  ),
  'engoTextSecondary': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0xFFDCDCDC),
  ),
  'engoDeviceCardBackgroundGradient1': ColorData(
    light: Color(0x99FFFFFF),
    dark: Color(0x99FFFFFF),
  ),
  'engoDeviceCardBackgroundGradient2': ColorData(
    light: Color(0x00FBBB84),
    dark: Color(0x00FBBB84),
  ),
  'engoButtonBackground': ColorData(
    light: Color(0xFFFDB874),
    dark: Color(0xFFFB9B51),
  ),
  'engoBottomSheetBackground': ColorData(
    light: Color(0xFFEFEFEF),
    dark: Color(0xFF7C7C7C),
  ),
  'engoButtonBorder': ColorData(
    light: Color(0xFFFDB874),
    dark: Color(0xFFFFFFFF),
  ),
  'engoButtonBorderReverse': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFFFDB874),
  ),
  'engoCircuitBreakerSwitchOffThumbBackground': ColorData(
    light: Color(0xFFDCDCDC),
    dark: Color(0xFFDCDCDC),
  ),
  'engoCircuitBreakerSwitchBackgroundGradient1': ColorData(
    light: Color(0x99FFFFFF),
    dark: Color(0x99FFFFFF),
  ),
  'engoCircuitBreakerSwitchBackgroundGradient2': ColorData(
    light: Color(0x00FBBB84),
    dark: Color(0x00FBBB84),
  ),
  'engoCircuitBreakerAlertCardBorder': ColorData(
    light: Color(0xFFFDB874),
    dark: Color(0xFFFFB880),
  ),
  'engoCircuitBreakerAlertCardGradient1': ColorData(
    light: Color(0x99FFFFFF),
    dark: Color(0x99424242),
  ),
  'engoCircuitBreakerAlertCardGradient2': ColorData(
    light: Color(0x00FBBB84),
    dark: Color(0x00FFC28A),
  ),
  'engoCircuitBreakerInputValue': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFFFFA86B),
  ),
  'engoBackgroundOrange400': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFFFB9B51),
  ),
  'engoBackgroundButton': ColorData(
    light: Color(0xFFFDB874),
    dark: Color(0xFFFB9B51),
  ),
  'engoWaterValueFunctionCardBorder': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFFFDB874),
  ),
  'engoWaterValueFunctionCardGradient1': ColorData(
    light: Color(0x99FFFFFF),
    dark: Color(0x99FFFFFF),
  ),
  'engoWaterValueFunctionCardGradient2': ColorData(
    light: Color(0x00FBBB84),
    dark: Color(0x00FBBB84),
  ),
  'engoWaterValueButtonBorder': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFFFB9B51),
  ),
  'engoWaterValueStatusOpening': ColorData(
    light: Color(0xFFFB9B51),
    dark: Color(0xFFFB9B51),
  ),
  'engoWaterValueStatusClosing': ColorData(
    light: Color(0xFF7C7C7C),
    dark: Color(0xFFDCDCDC),
  ),
  'airBoxDataCardGradient1': ColorData(
    light: Color(0x99FFFFFF),
    dark: Color(0x4DFFFFFF),
  ),
  'airBoxDataCardGradient2': ColorData(
    light: Color(0x00FBBB84),
    dark: Color(0x00FBBB84),
  ),
  'engoTabBarBackground': ColorData(
    light: Color(0x80FFFFFF),
    dark: Color(0x80FFFFFF),
  ),
  'airBoxStatusGood': ColorData(
    light: Color(0xFF40CE5F),
    dark: Color(0xFF40CE5F),
  ),
  'airBoxStatusBad': ColorData(
    light: Color(0xFFF88125),
    dark: Color(0xFFF88125),
  ),
  'airBoxStatusVeryBad': ColorData(
    light: Color(0xFFEF4425),
    dark: Color(0xFFEF4425),
  ),
  'engoPurifierPopupBgGradient1': ColorData(
    light: Color(0xF0EEEEEE),
    dark: Color(0xF0BBBBBB),
  ),
  'engoPurifierPopupBgGradient2': ColorData(
    light: Color(0xF0FBBB84),
    dark: Color(0xF0000000),
  ),
};
