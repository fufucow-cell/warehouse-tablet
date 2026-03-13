part of 'reservation_main_page_controller.dart';

enum EnumReservationMainPageRoute {
  goReservableItemDetailPage,
  goRecordItemDetailPage,
}

extension ReservationMainPageRouteExtension on ReservationMainPageController {
  // ignore: unused_element
  Future<void> _routerHandle(
    EnumReservationMainPageRoute type,
    dynamic data,
  ) async {
    switch (type) {
      case EnumReservationMainPageRoute.goReservableItemDetailPage:
        if (data is ReservableItemModel) {
          await Navigator.push(
            _service.getContext!,
            MaterialPageRoute(
              builder: (context) => ReservationDetailPage(
                routeData: ReservationDetailRouteData(reservableItem: data),
              ),
            ),
          );
        }
      case EnumReservationMainPageRoute.goRecordItemDetailPage:
        if (data is RecordItemModel) {
          await Navigator.push(
            _service.getContext!,
            MaterialPageRoute(
              builder: (context) => ReservationDetailPage(
                routeData: ReservationDetailRouteData(recordItem: data),
              ),
            ),
          );
        }
    }
  }
}
