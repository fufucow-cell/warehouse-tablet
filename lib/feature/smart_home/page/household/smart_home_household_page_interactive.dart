part of 'smart_home_household_page.dart';

enum EnumSmartHomeHouseholdPageInteractive {
  tapHomeItem,
  createHome,
}

extension SmartHomeHouseholdPageUserEventExtension
    on SmartHomeHouseholdPageController {
  void interactive(
    EnumSmartHomeHouseholdPageInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      default:
        break;
    }
  }
}
