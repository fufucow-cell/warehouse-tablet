part of 'smart_home_household_page.dart';

enum EnumSmartHomeHouseholdPageInteractive {
  tapSomeWidget,
}

extension SmartHomeHouseholdPageUserEventExtension
    on SmartHomeHouseholdPageController {
  void interactive(EnumSmartHomeHouseholdPageInteractive type,
      {dynamic data}) {
    switch (type) {
      case EnumSmartHomeHouseholdPageInteractive.tapSomeWidget:
        break;
    }
  }
}
