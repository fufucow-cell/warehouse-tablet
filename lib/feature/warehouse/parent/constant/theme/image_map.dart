/// 图片 Key 枚举
/// 自动生成，请勿手动修改
/// 生成时间: 2025-12-10T17:11:25.852383
library;

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/theme_util.dart';

enum EnumImage {
  cCow,
  cHouse,
  cTest,
  tCow,
  tTest;

  ThemeUtil get _themeUtil => ThemeUtil.instance;

  /// 取得圖片路徑
  String get path => _themeUtil.getImagePath(this);

  /// 取得圖片 Widget
  Widget image({Size? size, Color? color}) => _themeUtil
      .getImageWidget(this, size: size, color: color);
}
