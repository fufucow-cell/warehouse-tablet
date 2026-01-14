/// 图片 Key 枚举
/// 自动生成，请勿手动修改
/// 生成时间: 2026-01-14T16:10:15.597536
library;

import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';

enum EnumImage {
  cAdd,
  cArrowDown,
  cArrowDown2,
  cArrowLeft,
  cArrowRight,
  cArrowUp,
  cArrowUp2,
  cCamera,
  cChangeImage,
  cCheckboxOff,
  cCheckboxOn,
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
  cMember,
  cMinus,
  cPencilLine,
  cPhoto,
  cPlus,
  cPlus2,
  cRecover,
  cRefresh,
  cRoom,
  cSearch,
  cSearch2,
  cSetting,
  cStockItem,
  cTrash,
  cTrash2,
  cTrash3,
  tBgContent,
  tCow;

  ThemeService get _themeService => ThemeService.instance;

  /// 取得圖片路徑
  String get path => _themeService.getImagePath(this);

  /// 取得圖片 Widget
  Widget image({Size? size, Color? color, BoxFit? fit}) => _themeService.getImageWidget(this, size: size, color: color, fit: fit);

  /// 取得裝飾圖片
  DecorationImage get decorationImage => DecorationImage(
        image: AssetImage(path),
        fit: BoxFit.cover,
      );
}
