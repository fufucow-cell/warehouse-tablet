part of 'reservation_detail_page_controller.dart';

enum EnumReservationDetailPageRoute {
  goBack,
  openImageViewer,
}

extension ReservationDetailPageRouteExtension on ReservationDetailPageController {
  Future<void> _routerHandle(EnumReservationDetailPageRoute type, {dynamic data}) async {
    switch (type) {
      case EnumReservationDetailPageRoute.goBack:
        Navigator.of(_service.getContext!).pop();
      case EnumReservationDetailPageRoute.openImageViewer:
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
