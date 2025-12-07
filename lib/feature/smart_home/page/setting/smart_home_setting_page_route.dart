part of 'smart_home_setting_page.dart';

enum EnumSmartHomeSettingPageRoute {
  goOtherPage,
  showSomeDialog,
}

extension SmartHomeSettingPageRouteExtension on SmartHomeSettingPageController {
  void routerHandle(EnumSmartHomeSettingPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeSettingPageRoute.goOtherPage:
        break;
      case EnumSmartHomeSettingPageRoute.showSomeDialog:
        break;
    }
  }
}
