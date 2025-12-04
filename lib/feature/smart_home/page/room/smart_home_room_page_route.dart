part of 'smart_home_room_page.dart';

enum EnumSmartHomeRoomPageRoute {
  goOtherPage,
  showSomeDialog,
}

extension SmartHomeRoomPageRouteExtension on SmartHomeRoomPageController {
  void routerHandle(EnumSmartHomeRoomPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeRoomPageRoute.goOtherPage:
        break;
      case EnumSmartHomeRoomPageRoute.showSomeDialog:
        break;
    }
  }
}