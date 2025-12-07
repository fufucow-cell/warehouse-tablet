part of 'smart_home_household_page.dart';

enum EnumSmartHomeHouseholdPageRoute {
  showSomeDialog,
}

extension SmartHomeHouseholdPageRouteExtension
    on SmartHomeHouseholdPageController {
  void routerHandle(EnumSmartHomeHouseholdPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeHouseholdPageRoute.showSomeDialog:
        break;
    }
  }
}
