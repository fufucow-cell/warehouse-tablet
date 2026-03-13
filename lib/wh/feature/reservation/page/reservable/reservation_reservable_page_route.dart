part of 'reservation_reservable_page_controller.dart';

enum EnumReservationReservablePageRoute {
  goBack,
  openImageViewer,
}

extension ReservationReservablePageRouteExtension on ReservationReservablePageController {
  Future<void> _routerHandle(EnumReservationReservablePageRoute type, {dynamic data}) async {
    switch (type) {
      case EnumReservationReservablePageRoute.goBack:
        Navigator.of(_service.getContext!).pop();
      case EnumReservationReservablePageRoute.openImageViewer:
        if (data is List<String> && data.isNotEmpty) {
          await showDialog<void>(
            context: _service.getContext!,
            barrierColor: Colors.black.withOpacity(0.85),
            builder: (context) => ImageViewer(
              images: List<String>.from(data as List),
            ),
          );
        }
    }
  }
}
