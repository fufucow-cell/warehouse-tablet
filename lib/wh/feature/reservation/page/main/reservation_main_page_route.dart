part of 'reservation_main_page_controller.dart';

enum EnumReservationMainPageRoute {
  none,
}

extension ReservationMainPageRouteExtension on ReservationMainPageController {
  // ignore: unused_element
  Future<void> _routerHandle(EnumReservationMainPageRoute type) async {
    switch (type) {
      case EnumReservationMainPageRoute.none:
        break;
    }
  }
}