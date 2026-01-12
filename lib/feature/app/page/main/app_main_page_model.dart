part of 'app_main_page.dart';

class AppMainPageModel {
  final selectedItem = EnumAppMainTabItem.household.obs;
  static const EnumAppMainRouter rootRouter = EnumAppMainRouter.household;
}

enum EnumAppMainRouter {
  household,
  gateway,
  warehouse,
  setting;

  static EnumAppMainRouter get defaultRouter => EnumAppMainRouter.household;
  String get path => this == defaultRouter ? '/' : '/home_$name';

  Widget Function() get page => () => switch (this) {
        household => const SmartHomeHouseholdPage(),
        gateway => const SmartHomeGatewayPage(),
        warehouse => const SmartHomeWarehousePage(),
        setting => const SmartHomeSettingPage(),
      };
}

enum EnumAppMainTabItem {
  household(Icons.home),
  gateway(Icons.gas_meter),
  warehouse(Icons.warehouse),
  setting(Icons.settings);

  const EnumAppMainTabItem(this.icon);

  final IconData icon;

  EnumLocale get titleLocale => switch (this) {
        household => EnumLocale.smartHomeTabHousehold,
        gateway => EnumLocale.smartHomeTabGateway,
        warehouse => EnumLocale.smartHomeTabWarehouse,
        setting => EnumLocale.smartHomeTabSetting,
      };

  String get title => titleLocale.tr;

  EnumAppMainRouter get router => switch (this) {
        household => EnumAppMainRouter.household,
        gateway => EnumAppMainRouter.gateway,
        warehouse => EnumAppMainRouter.warehouse,
        setting => EnumAppMainRouter.setting,
      };
}
