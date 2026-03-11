part of 'reservation_main_page_controller.dart';

enum EnumReservationMainPageInteractive {
  loadItems,
  tapReserve,
}

extension ReservationMainPageUserEventExtension on ReservationMainPageController {
  Future<void> _interactive(EnumReservationMainPageInteractive type, {dynamic data}) async {
    switch (type) {
      case EnumReservationMainPageInteractive.loadItems:
        await loadItems();
        break;
      case EnumReservationMainPageInteractive.tapReserve:
        if (data is! ReservationItemModel) {
          return;
        }
        try {
          final String orderNo = await submitBooking();
          Get.snackbar(
            '預約成功',
            '項目：${data.name}\n訂單：$orderNo',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        } on Object catch (error) {
          Get.snackbar(
            '預約失敗',
            error.toString(),
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        }
        break;
    }
  }
}