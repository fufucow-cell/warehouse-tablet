/// 图片 Key 枚举
/// 自动生成，请勿手动修改
/// 生成时间: 2026-01-13T02:35:53.049540
library;

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme_service.dart';

enum EnumImage {
  cAdd,
  cArrowDown,
  cArrowDown2,
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
  cHistory,
  cHouse,
  cInfo,
  cItem,
  cMember,
  cMinus,
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
  Widget image({Size? size, Color? color}) =>
      _themeService.getImageWidget(this, size: size, color: color);

  /// 取得裝飾圖片
  DecorationImage get decorationImage => DecorationImage(
        image: AssetImage(path),
        fit: BoxFit.cover,
      );
}
