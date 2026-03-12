/// 图片 Key 枚举
/// 自动生成，请勿手动修改
/// 生成时间: 2026-03-12T14:27:16.090197
library;

import 'package:flutter/material.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme_service.dart';

enum EnumImage {
  cAdd,
  cAirConditioner,
  cAirConditionerAbnormal,
  cAirConditionerAntiHairdryer,
  cAirConditionerDry,
  cAirConditionerDry2,
  cAirConditionerEco,
  cAirConditionerGear,
  cAirConditionerHeating,
  cAirConditionerLed,
  cAirConditionerLeftAndRight,
  cAirConditionerRapidly,
  cAirConditionerSelfCleaning,
  cAirConditionerSleep,
  cAirConditionerStrongCold,
  cAirConditionerSupplyWind,
  cAirConditionerTiming,
  cAirConditionerUpAndDown,
  cAirConditionerWindDirection,
  cAirConditionerWindHigh,
  cAirConditionerWindLow,
  cAirConditionerWindQuiet,
  cAirFilter,
  cArrowDown,
  cArrowDown2,
  cArrowLeft,
  cArrowRight,
  cArrowUp,
  cArrowUp2,
  cBackgroundWind1,
  cBackgroundWind2,
  cCabinet,
  cCamera,
  cCategory,
  cChangeImage,
  cChart,
  cCheckboxOff,
  cCheckboxOn,
  cCircuit,
  cClock,
  cClose,
  cCo2,
  cCow,
  cEditNormal,
  cEditPosition,
  cEditQuantity,
  cEmpty,
  cEmptyPhoto,
  cGatewayCircle,
  cGatewayDevice,
  cGatewayMore,
  cGatewayStatusOff,
  cGatewayStatusOn,
  cHcho,
  cHelp,
  cHistory,
  cHouse,
  cHumidity,
  cInfo,
  cItem,
  cMenu,
  cMinus,
  cPencilLine,
  cPhoto,
  cPlus,
  cPlus2,
  cPm25,
  cPurifierFliter,
  cRecover,
  cRefresh,
  cRefresh2,
  cReset,
  cSearch,
  cSearch2,
  cSetting,
  cSnowFlake,
  cStockItem,
  cTemperature,
  cTrash,
  cTrash2,
  cTrash3,
  cVoc,
  cWind,
  tAirConditionerWindDirection1,
  tAirConditionerWindDirection10,
  tAirConditionerWindDirection2,
  tAirConditionerWindDirection3,
  tAirConditionerWindDirection4,
  tAirConditionerWindDirection5,
  tAirConditionerWindDirection6,
  tAirConditionerWindDirection7,
  tAirConditionerWindDirection8,
  tAirConditionerWindDirection9,
  tBgContent,
  tCow,
  tWaterValueOff,
  tWaterValueOn;

  ThemeService get _themeService => ThemeService.instance;

  /// 取得圖片路徑
  String get path => _themeService.getImagePath(this);

  /// 取得圖片 Widget
  Widget image({Size? size, Color? color, BoxFit? fit}) =>
      _themeService.getImageWidget(this, size: size, color: color, fit: fit);

  /// 取得裝飾圖片
  DecorationImage get decorationImage => DecorationImage(
        image: AssetImage(path),
        fit: BoxFit.cover,
      );
}
