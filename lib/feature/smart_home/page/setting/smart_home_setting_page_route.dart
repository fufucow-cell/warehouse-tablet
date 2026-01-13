part of 'smart_home_setting_page.dart';

enum EnumSmartHomeSettingPageRoute {
  showSnackBar,
}

extension SmartHomeSettingPageRouteExtension on SmartHomeSettingPageController {
  void routerHandle(EnumSmartHomeSettingPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeSettingPageRoute.showSnackBar:
        if (data is Map && data['title'] is String && data['message'] is String) {
          CustSnackBar.show(
            context: data['context'] as BuildContext?,
            title: data['title'] as String,
            message: data['message'] as String,
          );
        }
        break;
    }
  }
}
