import 'package:engo_terminal_app3/wh/feature/reservation/page/main/reservation_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/reservable/reservation_reservable_page.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_open_response_model/datum.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_record_response_model/datum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'reservation_main_page_interactive.dart';
part 'reservation_main_page_route.dart';

class ReservationMainPageController extends GetxController {
  // MARK: - Properties

  final _model = ReservationMainPageModel();
  ReservationService get _service => ReservationService.instance;

  RxReadonly<List<ReservableItemModel>?> get reservableItemsRx => _model.reservableItems.readonly;
  RxReadonly<List<RecordItemModel>?> get recordItemsRx => _model.recordItems.readonly;
  RxReadonly<List<RecordItemModel>?> get recordFilterItemsRx => _model.recordFilterItems.readonly;
  RxReadonly<EnumMainPageTabIndex> get selectedTabIndexRx => _model.selectedTabIndex.readonly;
  RxReadonly<EnumOrderType> get selectedRecordTypeRx => _model.selectedRecordType.readonly;

  List<String> get getTabTitles => EnumMainPageTabIndex.values.map((item) => item.title).toList();
  List<String> get getRecordTypeTitles => EnumOrderType.values.map((item) => item.title).toList();

  // MARK: - Init

  ReservationMainPageController() {
    ReservationService.register();
  }

  @override
  void onInit() {
    super.onInit();
    _addListeners();
    _queryReservableItems();
  }

  // MARK: - Public Method

  void setContext(BuildContext context) {
    _service.setContext(context);
  }

  EnumDataLoadStatus get dataLoadStatus {
    switch (selectedTabIndexRx.value) {
      case EnumMainPageTabIndex.reservable:
        final items = reservableItemsRx.value;
        if (items == null) {
          return EnumDataLoadStatus.loading;
        } else if (items.isEmpty) {
          return EnumDataLoadStatus.empty;
        }
        return EnumDataLoadStatus.success;
      case EnumMainPageTabIndex.record:
        final items = _filterRecordItems();

        if (items == null) {
          return EnumDataLoadStatus.loading;
        } else if (items.isEmpty) {
          return EnumDataLoadStatus.empty;
        }

        return EnumDataLoadStatus.success;
    }
  }

  // MARK: - Private Method

  void _addListeners() {
    ever<List<ReservableItem>?>(
      _service.openItemsRx.rx,
      _toReservableItemModel,
    );
    ever<List<RecordItem>?>(
      _service.recordItemsRx.rx,
      _toRecordItemModel,
    );
  }

  void _toReservableItemModel(List<ReservableItem>? items) {
    final List<ReservableItem> safe = items ?? <ReservableItem>[];
    final List<ReservableItemModel> result = safe.map((item) {
      return ReservableItemModel(
        name: item.name ?? '',
        reservationKey: item.reservationKey ?? '',
        categoryLv1Text: item.categoryLv1Text ?? '',
        categoryLv2Text: item.categoryLv2Text ?? '',
        categoryLv3Text: item.categoryLv3Text ?? '',
        description: item.description ?? '',
        specification: item.specification ?? '',
        notice: item.notice ?? '',
        durationMinutes: item.durationMinutes ?? 0,
        startAt: item.startAt ?? 0,
        endAt: item.endAt ?? 0,
        cancelTimeRange: item.cancelTimeRange ?? 0,
        perBookingPeopleLimit: item.perBookingPeopleLimit ?? 0,
        totalPeopleLimit: item.totalPeopleLimit ?? 0,
        fee: item.fee ?? 0,
        paymentType: EnumReservationPaymentType.fromIndex(item.paymentType ?? 0),
        dateRuleType: EnumReservationDateRuleType.fromIndex(item.dateRuleType ?? 0),
        bookingLimitType: EnumReservationBookingLimitType.fromIndex(item.bookingLimitType ?? 0),
        isPublished: item.isPublished ?? true,
      );
    }).toList();

    _model.reservableItems.value = result;
  }

  void _toRecordItemModel(List<RecordItem>? items) {
    final List<RecordItem> safe = items ?? <RecordItem>[];
    final List<RecordItemModel> result = safe.map((item) {
      final itemInfo = item.itemReservableInfo;
      final user = item.userInfo;
      final community = item.communityInfo;

      return RecordItemModel(
        id: item.id ?? '',
        orderId: item.orderId ?? '',
        controlKey: item.controlKey ?? '',
        bookingStartAt: DateTime.fromMillisecondsSinceEpoch(item.bookingStartAt ?? 0),
        bookingEndAt: DateTime.fromMillisecondsSinceEpoch(item.bookingEndAt ?? 0),
        createdAt: DateTime.fromMillisecondsSinceEpoch(item.createdAt ?? 0),
        orderType: EnumOrderType.fromCustIndex(item.orderType ?? -1),
        ticketType: EnumTicketType.fromIndex(item.ticketType ?? 0),
        totalAmount: item.totalAmount ?? 0,
        itemReservableInfo: ReservableItemModel(
          name: itemInfo?.name ?? '',
          reservationKey: itemInfo?.reservationKey ?? '',
          categoryLv1Text: itemInfo?.categoryLv1Text ?? '',
          categoryLv2Text: itemInfo?.categoryLv2Text ?? '',
          categoryLv3Text: itemInfo?.categoryLv3Text ?? '',
          description: itemInfo?.description ?? '',
          specification: itemInfo?.specification ?? '',
          notice: itemInfo?.notice ?? '',
          durationMinutes: itemInfo?.durationMinutes ?? 0,
          startAt: itemInfo?.startAt ?? 0,
          endAt: itemInfo?.endAt ?? 0,
          cancelTimeRange: itemInfo?.cancelTimeRange ?? 0,
          perBookingPeopleLimit: itemInfo?.perBookingPeopleLimit ?? 0,
          totalPeopleLimit: itemInfo?.totalPeopleLimit ?? 0,
          fee: itemInfo?.fee ?? 0,
          paymentType: EnumReservationPaymentType.fromIndex(
            itemInfo?.paymentType ?? 0,
          ),
          dateRuleType: EnumReservationDateRuleType.fromIndex(
            itemInfo?.dateRuleType ?? 0,
          ),
          bookingLimitType: EnumReservationBookingLimitType.fromIndex(
            itemInfo?.bookingLimitType ?? 0,
          ),
          isPublished: itemInfo?.isPublished ?? true,
        ),
        userInfo: RecordUserInfoModel(
          id: user?.id ?? '',
          name: user?.name ?? '',
          phone: user?.phone ?? '',
          email: user?.email ?? '',
        ),
        communityInfo: RecordCommunityInfoModel(
          communityId: community?.communityId ?? '',
          communityName: community?.communityName ?? '',
          householdId: community?.householdId ?? '',
          householdName: community?.householdName ?? '',
          address: community?.address ?? '',
        ),
      );
    }).toList();

    _model.recordItems.value = result;
    _model.recordFilterItems.value = _filterRecordItems();
  }

  List<RecordItemModel>? _filterRecordItems() {
    final items = recordItemsRx.value;

    if (items == null) {
      _model.recordFilterItems.value = null;
    } else if (items.isEmpty) {
      _model.recordFilterItems.value = [];
    }

    final recordType = selectedRecordTypeRx.value;

    if (recordType == EnumOrderType.all) {
      _model.recordFilterItems.value = items;
    } else {
      _model.recordFilterItems.value = items!.where((item) => item.orderType == recordType).toList();
    }

    return _model.recordFilterItems.value;
  }

  void _queryReservableItems({bool isCache = true}) {
    _service.fetchOpenItems(isCache: isCache);
  }

  void _queryRecordItems({bool isCache = true}) {
    _service.fetchRecordItems(isCache: isCache);
  }
}
