part of 'smart_home_room_page.dart';

enum EnumSmartHomeRoomPageInteractive {
  tapSomeWidget,
}

extension SmartHomeRoomPageUserEventExtension on SmartHomeRoomPageController {
  void interactive(EnumSmartHomeRoomPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeRoomPageInteractive.tapSomeWidget:
        break;
    }
  }
}
