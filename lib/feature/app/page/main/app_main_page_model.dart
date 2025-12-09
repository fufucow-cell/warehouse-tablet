part of 'app_main_page.dart';

class AppMainPageModel {
  final selectedItem = EnumAppMainTabItem.household.obs;
  static const EnumAppMainRouter rootRouter =
      EnumAppMainRouter.household;
}

enum EnumAppMainTabItem {
  household(Icons.home),
  scene(Icons.auto_awesome),
  message(Icons.message),
  repair(Icons.build),
  warehouse(Icons.warehouse),
  setting(Icons.settings);

  const EnumAppMainTabItem(this.icon);

  final IconData icon;

  EnumLocale get titleLocale => switch (this) {
        household => EnumLocale.smartHomeTabHousehold,
        scene => EnumLocale.smartHomeTabScene,
        message => EnumLocale.smartHomeTabMessage,
        repair => EnumLocale.smartHomeTabRepair,
        warehouse => EnumLocale.smartHomeTabWarehouse,
        setting => EnumLocale.smartHomeTabSetting,
      };

  String get title => titleLocale.tr;

  EnumAppMainRouter get router => switch (this) {
        household => EnumAppMainRouter.household,
        scene => EnumAppMainRouter.scene,
        message => EnumAppMainRouter.message,
        repair => EnumAppMainRouter.repair,
        warehouse => EnumAppMainRouter.warehouse,
        setting => EnumAppMainRouter.setting,
      };
}
