part of 'reservation_record_page_controller.dart';

enum EnumReservationRecordPageRoute {
  goBack,
  showImageViewer,
}

extension ReservationRecordPageRouteExtension on ReservationRecordPageController {
  Future<void> routerHandle(EnumReservationRecordPageRoute type, {dynamic data}) async {
    switch (type) {
      case EnumReservationRecordPageRoute.goBack:
        Navigator.pop(_service.getContext!);
      case EnumReservationRecordPageRoute.showImageViewer:
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
