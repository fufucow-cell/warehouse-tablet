part of 'app_main_page.dart';

class AppMainPageModel {
  final selectedItem = EnumAppMainTabItem.household.obs;
  static const EnumAppMainRouter rootRouter = EnumAppMainRouter.household;
}

enum EnumAppMainRouter {
  household,
  gateway,
  warehouse,
  circuitBreaker,
  waterValue,
  airBox,
  setting;

  static EnumAppMainRouter get defaultRouter => EnumAppMainRouter.household;
  String get path => this == defaultRouter ? '/' : '/home_$name';

  Widget Function() get page => () => switch (this) {
        household => const SmartHomeHouseholdPage(),
        gateway => const SmartHomeGatewayPage(),
        warehouse => const SmartHomeWarehousePage(),
        circuitBreaker => const SmartHomeCircuitBreakerPage(),
        waterValue => const SmartHomeWaterValuePage(),
        airBox => const SmartHomeAirBoxPage(),
        setting => const SmartHomeSettingPage(),
      };
}

enum EnumAppMainTabItem {
  household(Icons.home),
  gateway(Icons.gas_meter),
  warehouse(Icons.warehouse),
  circuitBreaker(Icons.power_settings_new),
  waterValue(Icons.water_drop),
  airBox(Icons.air),
  setting(Icons.settings);

  const EnumAppMainTabItem(this.icon);

  final IconData icon;

  EnumLocale get titleLocale => switch (this) {
        household => EnumLocale.smartHomeTabHousehold,
        gateway => EnumLocale.smartHomeTabGateway,
        warehouse => EnumLocale.smartHomeTabWarehouse,
        circuitBreaker => EnumLocale.smartHomeTabCircuitBreaker,
        waterValue => EnumLocale.smartHomeTabWaterValue,
        airBox => EnumLocale.smartHomeTabAirBox,
        setting => EnumLocale.smartHomeTabSetting,
      };

  String get title => titleLocale.tr;

  EnumAppMainRouter get router => switch (this) {
        household => EnumAppMainRouter.household,
        gateway => EnumAppMainRouter.gateway,
        warehouse => EnumAppMainRouter.warehouse,
        circuitBreaker => EnumAppMainRouter.circuitBreaker,
        waterValue => EnumAppMainRouter.waterValue,
        airBox => EnumAppMainRouter.airBox,
        setting => EnumAppMainRouter.setting,
      };
}
