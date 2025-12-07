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
      case EnumSmartHomeHouseholdPageInteractive
            .tapHomeItem:
        if (data is int) {
          // data 是家庭索引
          switchHousehold(data);
        } else if (data is Household) {
          // data 是 Household 对象，查找其索引
          final households = householdList;
          if (households != null) {
            final index = households.indexOf(data);
            if (index >= 0) {
              switchHousehold(index);
            }
          }
        }
        break;
      default:
        break;
    }
  }
}
