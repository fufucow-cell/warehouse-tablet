part of 'smart_home_scene_page.dart';

enum EnumSmartHomeScenePageRoute {
  goOtherPage,
  showSomeDialog,
}

extension SmartHomeScenePageRouteExtension on SmartHomeScenePageController {
  void routerHandle(EnumSmartHomeScenePageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeScenePageRoute.goOtherPage:
        break;
      case EnumSmartHomeScenePageRoute.showSomeDialog:
        break;
    }
  }
}