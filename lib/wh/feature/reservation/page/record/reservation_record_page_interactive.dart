part of 'reservation_record_page_controller.dart';

enum EnumReservationRecordPageInteractive {
  tapBack,
  orderStatusChanged,
  paymentStatusChanged,
  ticketStatusChanged,
  switchTabItem,
  tapCancelOrder,
  tapConfirm,
  tapImage,
}

extension ReservationRecordPageUserEventExtension on ReservationRecordPageController {
  Future<void> interactive(EnumReservationRecordPageInteractive type, {dynamic data}) async {
    switch (type) {
      case EnumReservationRecordPageInteractive.tapBack:
        await routerHandle(EnumReservationRecordPageRoute.goBack);
      case EnumReservationRecordPageInteractive.orderStatusChanged:
        setOrderStatus(data as String);
        break;
      case EnumReservationRecordPageInteractive.paymentStatusChanged:
        setPaymentStatus(data as String);
        break;
      case EnumReservationRecordPageInteractive.ticketStatusChanged:
        setTicketStatus(data as String);
        break;
      case EnumReservationRecordPageInteractive.tapCancelOrder:
        break;
      case EnumReservationRecordPageInteractive.tapConfirm:
        Get.back();
        break;
      case EnumReservationRecordPageInteractive.tapImage:
        await routerHandle(EnumReservationRecordPageRoute.showImageViewer, data: data);
        break;
      case EnumReservationRecordPageInteractive.switchTabItem:
        if (data is int) {
          _model.selectedTabIndex.value = data;
        }
    }
  }
}
