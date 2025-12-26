/// 图片 Key 枚举
/// 自动生成，请勿手动修改
/// 生成时间: 2025-12-26T12:49:40.811364
library;

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/theme_util.dart';

enum EnumImage {
  cAdd,
  cArrowDown,
  cArrowUp,
  cCamera,
  cChangeImage,
  cCheckboxOff,
  cCheckboxOn,
  cCow,
  cEditNormal,
  cEditPosition,
  cEditQuantity,
  cHistory,
  cHouse,
  cInfo,
  cItem,
  cMember,
  cMinus,
  cPhoto,
  cPlus,
  cRefresh,
  cRoom,
  cSearch,
  cSearch2,
  cSetting,
  cStockItem,
  cTrash,
  cTrash2,
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
