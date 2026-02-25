part of 'smart_home_water_value_page_controller.dart';

enum EnumSmartHomeWaterValuePageInteractive {
  // 如果需要添加交互事件，在这里定义
  placeholder,
}

extension SmartHomeWaterValuePageUserEventExtension on SmartHomeWaterValuePageController {
  void interactive(
    EnumSmartHomeWaterValuePageInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumSmartHomeWaterValuePageInteractive.placeholder:
        // 处理交互事件
        break;
    }
  }
}
