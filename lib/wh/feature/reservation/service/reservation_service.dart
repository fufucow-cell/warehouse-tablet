import 'package:engo_terminal_app3/wh/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_open_response_model/datum.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_open_response_model/reservation_item_open_response_model.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_record_response_model/datum.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_record_response_model/reservation_item_record_response_model.dart';
import 'package:engo_terminal_app3/wh/parent/service/api_service/api_service.dart';
import 'package:engo_terminal_app3/wh/parent/service/api_service/api_service_model.dart';
import 'package:engo_terminal_app3/wh/parent/service/device_service/device_service.dart';
import 'package:engo_terminal_app3/wh/parent/service/router_service/router_service.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'reservation_service_model.dart';

class ReservationService {
  // MARK: - Properties

  final _model = ReservationServiceModel();
  RxReadonly<List<ReservableItem>?> get openItemsRx => _model.openItems.readonly;
  RxReadonly<List<RecordItem>?> get recordItemsRx => _model.recordItems.readonly;
  BuildContext? get getContext => _model.nestedNavigatorContext;

  // MARK: - Init

  ReservationService._internal();

  static ReservationService register() {
    if (Get.isRegistered<ReservationService>()) {
      return Get.find<ReservationService>();
    }
    ApiService.register();
    final service = ReservationService._internal();
    Get.put<ReservationService>(service, permanent: true);
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<ReservationService>()) {
      Get.delete<ReservationService>(force: true);
    }
  }

  static ReservationService get instance {
    if (!Get.isRegistered<ReservationService>()) {
      return register();
    }
    return Get.find<ReservationService>();
  }

  // MARK: - Public Method

  void setContext(BuildContext context) {
    final router = RouterService.register();
    _model.nestedNavigatorContext = router.findNestedNavigatorContext(context);
    DeviceService.register(context);
  }

  // MARK: - Private Method

  // MARK: - Api Method

  Future<List<ReservableItem>> fetchOpenItems({bool isCache = true}) async {
    if (isCache && _model.openItems.value != null) {
      return _model.openItems.value ?? <ReservableItem>[];
    }

    _model.openItems.value = null;
    final ReservationItemOpenResponseModel? response = await ApiService.sendRequest<ReservationItemOpenResponseModel>(
      EnumApiInfo.reservationItemOpen,
      fromJson: (json) {
        return ReservationItemOpenResponseModel.fromJson(json);
      },
    );

    if (response == null) {
      _model.openItems.value = <ReservableItem>[];
      return <ReservableItem>[];
    }

    final List<ReservableItem> list = response.data ?? <ReservableItem>[];
    _model.openItems.value = list;
    return list;
  }

  Future<List<RecordItem>> fetchRecordItems({bool isCache = true}) async {
    if (isCache && _model.recordItems.value != null) {
      return _model.recordItems.value ?? <RecordItem>[];
    }

    _model.recordItems.value = null;
    final ReservationItemRecordResponseModel? response = await ApiService.sendRequest<ReservationItemRecordResponseModel>(
      EnumApiInfo.reservationItemRecord,
      fromJson: (json) {
        return ReservationItemRecordResponseModel.fromJson(json);
      },
    );

    if (response == null) {
      _model.recordItems.value = <RecordItem>[];
      return <RecordItem>[];
    }

    final List<RecordItem> list = response.data ?? <RecordItem>[];
    _model.recordItems.value = list;
    return list;
  }

  Future<String> createBookingOrder({
    required String itemId,
    required int bookingStartAt,
    required int bookingEndAt,
    required int peopleCount,
    required String userName,
    required String userPhone,
    required String note,
  }) async {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return 'MOCK-RSV-$itemId-$ts';
  }
}
