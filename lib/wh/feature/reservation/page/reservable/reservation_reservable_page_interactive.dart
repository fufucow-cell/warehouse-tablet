part of 'reservation_reservable_page_controller.dart';

enum EnumReservationReservablePageInteractive {
  tapSomeWidget,
}

extension ReservationReservablePageUserEventExtension
    on ReservationReservablePageController {
  Future<void> _interactive(EnumReservationReservablePageInteractive type,
      {dynamic data}) async {
    switch (type) {
      case EnumReservationReservablePageInteractive.tapSomeWidget:
        break;
    }
  }
}
