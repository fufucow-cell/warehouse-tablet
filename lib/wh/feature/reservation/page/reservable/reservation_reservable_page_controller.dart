import 'package:engo_terminal_app3/wh/feature/reservation/page/main/reservation_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/reservable/reservation_reservable_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/reservable/ui/image_viewer.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_rx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'reservation_reservable_page_interactive.dart';
part 'reservation_reservable_page_route.dart';

class ReservationReservablePageController extends GetxController {
  // MARK: - Properties

  final _model = ReservationReservablePageModel();
  ReservationService get _service => ReservationService.instance;
  ReservableItemModel? get getReservableItem => _model.reservableItem;
  RxReadonly<DateTime?> get dateRx => _model.date.readonly;
  RxReadonly<TimeOfDay?> get startTimeRx => _model.startTime.readonly;
  RxReadonly<TimeOfDay?> get endTimeRx => _model.endTime.readonly;
  RxReadonly<double> get durationHoursRx => _model.durationHours.readonly;
  RxReadonly<int> get totalAmountRx => _model.totalAmount.readonly;
  DateTime get firstDate => _model.firstDate;
  DateTime get lastDate => _model.lastDate;
  final TextEditingController adultTextController = TextEditingController(text: '1');
  final TextEditingController childTextController = TextEditingController(text: '0');

  // MARK: - Init

  ReservationReservablePageController(ReservableItemModel routeData) {
    _model.reservableItem = routeData;
  }

  // MARK: - Methods

  @override
  void onClose() {
    adultTextController.dispose();
    childTextController.dispose();
    super.onClose();
  }

  void setDate(DateTime value) {
    _model.date.value = value;
  }

  void cancel() {
    // API cleanup / navigation handled later
    Get.back();
  }

  Future<void> submit() async {
    // API wiring later
    Get.back();
  }
}
