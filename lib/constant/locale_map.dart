/// 多语系 Key 枚举
/// 自动生成，请勿手动修改
/// 生成时间: 2025-12-09T14:45:40.610527
library;

import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_string.dart';
import 'package:get/get.dart';

enum EnumLocale {
  appTitle;

  String get key => name.toSnakeCase();
  String get tr => key.tr;
}
