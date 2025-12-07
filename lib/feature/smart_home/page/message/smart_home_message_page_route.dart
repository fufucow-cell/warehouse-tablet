part of 'smart_home_message_page.dart';

enum EnumSmartHomeMessagePageRoute {
  goOtherPage,
  showSomeDialog,
}

extension SmartHomeMessagePageRouteExtension on SmartHomeMessagePageController {
  void routerHandle(EnumSmartHomeMessagePageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeMessagePageRoute.goOtherPage:
        break;
      case EnumSmartHomeMessagePageRoute.showSomeDialog:
        break;
    }
  }
}
