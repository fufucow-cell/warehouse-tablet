part of 'smart_home_setting_page.dart';

enum EnumSmartHomeSettingPageRoute {
  showSnackBar,
}

extension SmartHomeSettingPageRouteExtension on SmartHomeSettingPageController {
  void routerHandle(EnumSmartHomeSettingPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeSettingPageRoute.showSnackBar:
        if (data is SnackBarModel) {
          CustSnackBar.show(
            context: getContext,
            title: data.title,
            message: data.message,
          );
        }
    }
  }
}
