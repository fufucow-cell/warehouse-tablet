part of 'reservation_detail_page_controller.dart';

enum EnumReservationDetailPageInteractive {
  tapBack,
  tapImage,
  tapConfirm,
  dateChanged,
  startTimeChanged,
  endTimeChanged,
  tapInfoTabItem,
}

extension ReservationDetailPageUserEventExtension on ReservationDetailPageController {
  Future<void> interactive(EnumReservationDetailPageInteractive type, {dynamic data}) async {
    switch (type) {
      case EnumReservationDetailPageInteractive.tapBack:
        await _routerHandle(EnumReservationDetailPageRoute.goBack);
      case EnumReservationDetailPageInteractive.tapImage:
        await _routerHandle(EnumReservationDetailPageRoute.openImageViewer, data: data);
      case EnumReservationDetailPageInteractive.tapConfirm:
        break;
      case EnumReservationDetailPageInteractive.dateChanged:
        if (data is DateTime) {
          _model.date.value = data;
        }
      case EnumReservationDetailPageInteractive.startTimeChanged:
        if (data is TimeOfDay) {
          _model.startTime.value = data;
          _checkTotalBillingText();
        }
      case EnumReservationDetailPageInteractive.endTimeChanged:
        if (data is TimeOfDay) {
          _model.endTime.value = data;
          _checkTotalBillingText();
        }
      case EnumReservationDetailPageInteractive.tapInfoTabItem:
        if (data is int) {
          _model.infoTabType.value = EnumReservationInfoTabType.fromIndex(data);
        }
    }
  }
}
