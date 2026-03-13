import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 預約詳情頁的動態狀態（不再存放 ReservableItemModel 本體）。
class ReservationReservablePageModel {
  ReservableItemModel? reservableItem;
  final Rxn<DateTime> date = Rxn<DateTime>();
  final DateTime firstDate = DateTime.now();
  final DateTime lastDate = DateTime.now().add(const Duration(days: 30));
  final Rxn<TimeOfDay> startTime = Rxn<TimeOfDay>();
  final Rxn<TimeOfDay> endTime = Rxn<TimeOfDay>();
  final RxDouble durationHours = 0.0.obs;
  final RxInt totalAmount = 0.obs;
}
