import 'package:engo_terminal_app3/wh/feature/reservation/page/record/reservation_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/ui/image_viewer.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_rx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'reservation_record_page_interactive.dart';
part 'reservation_record_page_route.dart';

class ReservationRecordPageController extends GetxController {
  // MARK: - Properties

  final _model = ReservationRecordPageModel();
  final _service = ReservationService.instance;
  RecordItemModel get getRecordItem => _model.recordItem;
  RxReadonly<int> get selectedTabIndexRx => _model.selectedTabIndex.readonly;
  RxReadonly<EnumOrderType> get selectedOrderStatusRx => _model.selectedOrderStatus.readonly;
  RxReadonly<EnumRecordPaymentType> get selectedPaymentStatusRx => _model.selectedPaymentStatus.readonly;
  RxReadonly<EnumTicketType> get selectedTicketStatusRx => _model.selectedTicketStatus.readonly;

  // MARK: - Init

  ReservationRecordPageController(RecordItemModel routeData) {
    _model.recordItem = routeData;
    _model.selectedOrderStatus.value = routeData.orderType;
    _model.selectedTicketStatus.value = routeData.ticketType;
  }

  // MARK: - Methods

  String formatDateTime(DateTime dt) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${dt.year}/${two(dt.month)}/${two(dt.day)} ${two(dt.hour)}:${two(dt.minute)}';
  }

  void setOrderStatus(String title) {
    final status = EnumOrderType.values.firstWhere(
      (e) => e.localeTitle == title,
      orElse: () => EnumOrderType.progress,
    );
    _model.selectedOrderStatus.value = status;
  }

  void setPaymentStatus(String title) {
    // final status = EnumRecordPaymentType.values.firstWhere(
    //   (e) => e.title == title,
    //   orElse: () => EnumRecordPaymentType.unpaid,
    // );
    // _model.selectedPaymentStatus.value = status;
  }

  void setTicketStatus(String title) {
    // final status = EnumTicketType.values.firstWhere(
    //   (e) => e.title == title,
    //   orElse: () => EnumTicketType.unissued,
    // );
    // _model.selectedTicketStatus.value = status;
  }
}
