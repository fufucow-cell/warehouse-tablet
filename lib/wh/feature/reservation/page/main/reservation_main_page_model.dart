import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:get/get.dart';

class ReservationMainPageModel {
  final reservableItems = Rxn<List<ReservableItemModel>>();
  final recordItems = Rxn<List<RecordItemModel>>();
  final recordFilterItems = Rxn<List<RecordItemModel>>();
  final selectedTabIndex = EnumMainPageTabIndex.reservable.obs;
  final selectedRecordType = EnumOrderType.progress.obs;
}

enum EnumMainPageTabIndex {
  reservable,
  record;

  static EnumMainPageTabIndex fromIndex(int index) {
    if (index < 0 || index >= EnumMainPageTabIndex.values.length) {
      return EnumMainPageTabIndex.reservable;
    }
    return EnumMainPageTabIndex.values[index];
  }

  String get localeTitle => switch (this) {
        reservable => '預約項目',
        record => '預約紀錄',
      };
}

enum EnumDataLoadStatus {
  loading,
  empty,
  success;
}
