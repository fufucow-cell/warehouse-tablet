part of 'smart_home_household_page.dart';

enum EnumSmartHomeHouseholdPageInteractive {
  nothing,
}

extension SmartHomeHouseholdPageUserEventExtension on SmartHomeHouseholdPageController {
  void interactive(
    EnumSmartHomeHouseholdPageInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumSmartHomeHouseholdPageInteractive.nothing:
        break;
    }
  }
}
