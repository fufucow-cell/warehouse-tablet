part of 'reservation_main_page_controller.dart';

enum EnumReservationMainPageRoute {
  goReservableItemDetailPage,
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
              builder: (context) => ReservationReservablePage(
                routeData: data,
              ),
            ),
          );
        }
    }
  }
}
