part of 'smart_home_scene_page.dart';

enum EnumSmartHomeScenePageInteractive {
  tapSomeWidget,
}

extension SmartHomeScenePageUserEventExtension on SmartHomeScenePageController {
  void interactive(EnumSmartHomeScenePageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeScenePageInteractive.tapSomeWidget:
        break;
    }
  }
}
