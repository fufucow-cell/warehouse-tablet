/// 图片 Key 枚举
/// 自动生成，请勿手动修改
/// 生成时间: 2025-12-29T17:18:54.666250
library;

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/theme_util.dart';

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

  ThemeUtil get _themeUtil => ThemeUtil.instance;

  /// 取得圖片路徑
  String get path => _themeUtil.getImagePath(this);

  /// 取得圖片 Widget
  Widget image({Size? size, Color? color}) =>
      _themeUtil.getImageWidget(this, size: size, color: color);

  /// 取得裝飾圖片
  DecorationImage get decorationImage => DecorationImage(
        image: AssetImage(path),
        fit: BoxFit.cover,
      );
}
