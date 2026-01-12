#!/bin/bash

# 批量更新 LogUtil 和 log_constant 的引用

# 查找所有包含 LogUtil 或 log_constant 的 Dart 文件
find lib -type f -name "*.dart" | while read file; do
  # 检查文件是否包含需要替换的内容
  if grep -q "LogUtil\|log_util\|log_constant" "$file"; then
    echo "Updating: $file"

    # 替换 import 语句
    sed -i '' "s|import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';|import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/log_service/log_service.dart';|g" "$file"
    sed -i '' "s|import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';||g" "$file"

    # 替换 LogUtil 为 LogService
    sed -i '' "s/LogUtil\./LogService./g" "$file"
    sed -i '' "s/LogUtil /LogService /g" "$file"
    sed -i '' "s/LogUtil>/LogService>/g" "$file"
    sed -i '' "s/LogUtil)/LogService)/g" "$file"
    sed -i '' "s/LogUtil,/LogService,/g" "$file"
    sed -i '' "s/LogUtil;/LogService;/g" "$file"
    sed -i '' "s/LogUtil\.instance/LogService.instance/g" "$file"
    sed -i '' "s/LogUtil\.register/LogService.register/g" "$file"
    sed -i '' "s/LogUtil\.unregister/LogService.unregister/g" "$file"
    sed -i '' "s/LogUtil\.i/LogService.i/g" "$file"
    sed -i '' "s/LogUtil\.d/LogService.d/g" "$file"
    sed -i '' "s/LogUtil\.e/LogService.e/g" "$file"
    sed -i '' "s/LogUtil\.setEnableLog/LogService.setEnableLog/g" "$file"

    # 替换类型声明
    sed -i '' "s/LogUtil get/LogService get/g" "$file"
    sed -i '' "s/LogUtil service/LogService service/g" "$file"
    sed -i '' "s/Get\.isRegistered<LogUtil>/Get.isRegistered<LogService>/g" "$file"
    sed -i '' "s/Get\.find<LogUtil>/Get.find<LogService>/g" "$file"
    sed -i '' "s/Get\.put<LogUtil>/Get.put<LogService>/g" "$file"
    sed -i '' "s/Get\.delete<LogUtil>/Get.delete<LogService>/g" "$file"
  fi
done

echo "✅ 更新完成！"
