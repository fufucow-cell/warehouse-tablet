part of 'smart_home_repair_page.dart';

enum EnumSmartHomeRepairPageRoute {
  goOtherPage,
  showSomeDialog,
}

extension SmartHomeRepairPageRouteExtension on SmartHomeRepairPageController {
  void routerHandle(EnumSmartHomeRepairPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeRepairPageRoute.goOtherPage:
        break;
      case EnumSmartHomeRepairPageRoute.showSomeDialog:
        break;
    }
  }
}
