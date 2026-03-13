import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/main/reservation_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_open_response_model/datum.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_record_response_model/datum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  List<String> get getTabTitles => EnumMainPageTabIndex.values.map((item) => item.localeTitle).toList();
  List<String> get getRecordTypeTitles => EnumOrderType.values.map((item) => item.localeTitle).toList();

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

  String formatDateTime(int? epoch) {
    if (epoch == null || epoch <= 0) {
      return '-';
    }

    final formatter = DateFormat('yyyy/MM/dd HH:mm');
    return formatter.format(DateTime.fromMillisecondsSinceEpoch(epoch));
  }

  // MARK: - Private Method

  void _addListeners() {
    ever<List<ReservableItem>?>(
      _service.openItemsRx.rx,
      (items) => _model.reservableItems.value = _comvertReservableItemModel(items),
    );
    ever<List<RecordItem>?>(
      _service.recordItemsRx.rx,
      _toRecordItemModel,
    );
  }

  List<ReservableItemModel> _comvertReservableItemModel(List<ReservableItem>? items) {
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
        hourLimit: item.hourLimit ?? 0,
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
        imageUrls: item.imageUrls ?? [],
      );
    }).toList();

    return result;
  }

  void _toRecordItemModel(List<RecordItem>? items) {
    final safe = items ?? <RecordItem>[];
    final result = safe.map((item) {
      final info = item.itemReservableInfo;
      final user = item.userInfo;
      final community = item.communityInfo;

      final reservable = ReservableItemModel(
        name: info?.name ?? '',
        reservationKey: info?.reservationKey ?? '',
        categoryLv1Text: info?.categoryLv1Text ?? '',
        categoryLv2Text: info?.categoryLv2Text ?? '',
        categoryLv3Text: info?.categoryLv3Text ?? '',
        description: info?.description ?? '',
        specification: info?.specification ?? '',
        notice: info?.notice ?? '',
        hourLimit: info?.hourLimit ?? 0,
        startAt: info?.startAt ?? 0,
        endAt: info?.endAt ?? 0,
        cancelTimeRange: info?.cancelTimeRange ?? 0,
        perBookingPeopleLimit: info?.perBookingPeopleLimit ?? 0,
        totalPeopleLimit: info?.totalPeopleLimit ?? 0,
        fee: info?.fee ?? 0,
        paymentType: EnumReservationPaymentType.fromIndex(info?.paymentType ?? 0),
        dateRuleType: EnumReservationDateRuleType.fromIndex(info?.dateRuleType ?? 0),
        bookingLimitType: EnumReservationBookingLimitType.fromIndex(info?.bookingLimitType ?? 0),
        isPublished: info?.isPublished ?? true,
        imageUrls: info?.imageUrls ?? const <String>[],
      );

      return RecordItemModel(
        id: item.id ?? '',
        orderId: item.orderId ?? '',
        controlKey: item.controlKey ?? '',
        bookingStartAt: item.bookingStartAt ?? 0,
        bookingEndAt: item.bookingEndAt ?? 0,
        createdAt: item.createdAt ?? 0,
        updatedAt: item.updatedAt ?? 0,
        orderType: EnumOrderType.fromCustIndex(item.orderType ?? -1),
        ticketType: EnumTicketType.fromIndex(item.ticketType ?? 0),
        paymentType: EnumRecordPaymentType.fromIndex(item.paymentType ?? 0),
        totalAmount: item.totalAmount ?? 0,
        ticketCreatedAt: item.ticketCreatedAt ?? 0,
        paymentCreatedAt: item.paymentCreatedAt ?? 0,
        adultCount: item.adultCount ?? 0,
        childCount: item.childCount ?? 0,
        itemReservableInfo: reservable,
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
