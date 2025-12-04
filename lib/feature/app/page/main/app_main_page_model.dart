part of 'app_main_page.dart';

class AppMainPageModel {
  final selectedItem = EnumAppMainTabItem.household.obs;
  static const EnumAppMainRouter rootRouter = EnumAppMainRouter.household;
}

enum EnumAppMainTabItem {
  household(Icons.home, '家庭'),
  scene(Icons.auto_awesome, '場景'),
  message(Icons.message, '訊息'),
  repair(Icons.build, '報修'),
  warehouse(Icons.warehouse, '智能倉儲'),
  setting(Icons.settings, '設置');

  const EnumAppMainTabItem(this.icon, this.title);

  final IconData icon;
  final String title;

  EnumAppMainRouter get router => switch (this) {
        household => EnumAppMainRouter.household,
        scene => EnumAppMainRouter.scene,
        message => EnumAppMainRouter.message,
        repair => EnumAppMainRouter.repair,
        warehouse => EnumAppMainRouter.warehouse,
        setting => EnumAppMainRouter.setting,
      };
}
