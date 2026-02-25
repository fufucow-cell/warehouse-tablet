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
  airPurifier,
  airConditioner,
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
        airPurifier => const SmartHomeAirPurifierPage(),
        airConditioner => const SmartHomeAirConditionerPage(),
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
  airPurifier(Icons.filter_alt),
  airConditioner(Icons.ac_unit),
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
        airPurifier => EnumLocale.smartHomeTabAirPurifier,
        airConditioner => EnumLocale.smartHomeTabAirConditioner,
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
        airPurifier => EnumAppMainRouter.airPurifier,
        airConditioner => EnumAppMainRouter.airConditioner,
        setting => EnumAppMainRouter.setting,
      };
}
