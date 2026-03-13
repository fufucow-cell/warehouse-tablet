part of 'reservation_main_page_controller.dart';

enum EnumReservationMainPageInteractive {
  switchTabItem,
  switchRecordTypeItem,
  tapReservableItem,
  tapRecordItem,
  tapRefresh,
}

extension ReservationMainPageUserEventExtension on ReservationMainPageController {
  Future<void> interactive(EnumReservationMainPageInteractive type, {dynamic data}) async {
    switch (type) {
      case EnumReservationMainPageInteractive.switchTabItem:
        if (data is int) {
          _model.selectedTabIndex.value = EnumMainPageTabIndex.fromIndex(data);
          switch (_model.selectedTabIndex.value) {
            case EnumMainPageTabIndex.reservable:
              _queryReservableItems();
            case EnumMainPageTabIndex.record:
              _queryRecordItems();
          }
        }
      case EnumReservationMainPageInteractive.switchRecordTypeItem:
        if (data is int) {
          _model.selectedRecordType.value = EnumOrderType.fromIndex(data);
          _filterRecordItems();
        }
      case EnumReservationMainPageInteractive.tapReservableItem:
        await _routerHandle(EnumReservationMainPageRoute.goReservableItemDetailPage, data);
      case EnumReservationMainPageInteractive.tapRefresh:
        switch (_model.selectedTabIndex.value) {
          case EnumMainPageTabIndex.reservable:
            _queryReservableItems(isCache: false);
          case EnumMainPageTabIndex.record:
            _queryRecordItems(isCache: false);
        }
      case EnumReservationMainPageInteractive.tapRecordItem:
        await _routerHandle(EnumReservationMainPageRoute.goRecordItemDetailPage, data);
    }
  }
}
