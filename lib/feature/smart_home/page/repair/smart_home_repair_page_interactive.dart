part of 'smart_home_repair_page.dart';

enum EnumSmartHomeRepairPageInteractive {
  tapSomeWidget,
}

extension SmartHomeRepairPageUserEventExtension
    on SmartHomeRepairPageController {
  void interactive(EnumSmartHomeRepairPageInteractive type,
      {dynamic data}) {
    switch (type) {
      case EnumSmartHomeRepairPageInteractive.tapSomeWidget:
        break;
    }
  }
}
