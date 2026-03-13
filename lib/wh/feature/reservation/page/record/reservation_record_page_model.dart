import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:get/get.dart';

class ReservationRecordPageModel {
  late RecordItemModel recordItem;
  final selectedTabIndex = 0.obs;
  final selectedOrderStatus = EnumOrderType.progress.obs;
  final selectedPaymentStatus = EnumRecordPaymentType.unpaid.obs;
  final selectedTicketStatus = EnumTicketType.unissued.obs;
}

enum EnumRecordTabIndex {
  userInfo,
  itemInfo;

  String get title => switch (this) {
        userInfo => '客戶資訊',
        itemInfo => '品項資訊',
      };

  static EnumRecordTabIndex fromIndex(int index) {
    return EnumRecordTabIndex.values.firstWhere((e) => e.index == index, orElse: () => EnumRecordTabIndex.userInfo);
  }
}
