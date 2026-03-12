part of 'reservation_reservable_page_controller.dart';

enum EnumReservationReservablePageRoute {
  goOtherPage,
  showSomeDialog,
}

extension ReservationReservablePageRouteExtension
    on ReservationReservablePageController {
  Future<void> _routerHandle(EnumReservationReservablePageRoute type,
      {dynamic data}) async {
    switch (type) {
      case EnumReservationReservablePageRoute.goOtherPage:
        break;
      case EnumReservationReservablePageRoute.showSomeDialog:
        break;
    }
  }
}
