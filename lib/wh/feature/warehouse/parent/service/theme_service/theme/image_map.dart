/// 图片 Key 枚举
/// 自动生成，请勿手动修改
/// 生成时间: 2026-01-22T15:57:13.508115
library;

import 'package:flutter/material.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';

enum EnumImage {
  cAdd,
  cArrowDown,
  cArrowDown2,
  cArrowLeft,
  cArrowRight,
  cArrowUp,
  cArrowUp2,
  cCabinet,
  cCamera,
  cCategory,
  cChangeImage,
  cCheckboxOff,
  cCheckboxOn,
  cCircuit,
  cClock,
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
  cHistory,
  cHouse,
  cInfo,
  cItem,
  cMinus,
  cPencilLine,
  cPhoto,
  cPlus,
  cPlus2,
  cRecover,
  cRefresh,
  cSearch,
  cSearch2,
  cSetting,
  cStockItem,
  cTrash,
  cTrash2,
  cTrash3,
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
