part of 'reservation_reservable_page_controller.dart';

enum EnumReservationReservablePageInteractive {
  tapBack,
  tapImage,
  tapConfirm,
  dateChanged,
  startTimeChanged,
  endTimeChanged,
}

extension ReservationReservablePageUserEventExtension on ReservationReservablePageController {
  Future<void> interactive(EnumReservationReservablePageInteractive type, {dynamic data}) async {
    switch (type) {
      case EnumReservationReservablePageInteractive.tapBack:
        await _routerHandle(EnumReservationReservablePageRoute.goBack);
      case EnumReservationReservablePageInteractive.tapImage:
        await _routerHandle(EnumReservationReservablePageRoute.openImageViewer, data: data);
      case EnumReservationReservablePageInteractive.tapConfirm:
        break;
      case EnumReservationReservablePageInteractive.dateChanged:
        if (data is DateTime) {
          _model.date.value = data;
        }
      case EnumReservationReservablePageInteractive.startTimeChanged:
        if (data is TimeOfDay) {
          _model.startTime.value = data;
        }
      case EnumReservationReservablePageInteractive.endTimeChanged:
        if (data is TimeOfDay) {
          _model.endTime.value = data;
        }
    }
  }
}
