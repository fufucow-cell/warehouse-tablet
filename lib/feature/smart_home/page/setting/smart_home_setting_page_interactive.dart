part of 'smart_home_setting_page.dart';

enum EnumSmartHomeSettingPageInteractive {
  tapSomeWidget,
}

extension SmartHomeSettingPageUserEventExtension
    on SmartHomeSettingPageController {
  void interactive(EnumSmartHomeSettingPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeSettingPageInteractive.tapSomeWidget:
        break;
    }
  }
}
