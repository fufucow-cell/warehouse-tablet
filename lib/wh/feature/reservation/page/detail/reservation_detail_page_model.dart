import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationDetailPageModel {
  ReservationDetailRouteData? routeData;
  final Rxn<DateTime> date = Rxn<DateTime>();
  final Rxn<String> selectedDate = Rxn<String>();
  final DateTime firstDate = DateTime.now();
  final DateTime lastDate = DateTime.now().add(const Duration(days: 30));
  final Rxn<TimeOfDay> startTime = Rxn<TimeOfDay>();
  final Rxn<TimeOfDay> endTime = Rxn<TimeOfDay>();
  final totalBilling = '-'.obs;
  final totalDuration = '-'.obs;
  final infoTabType = EnumReservationInfoTabType.order.obs;
}

class ReservationDetailRouteData {
  final ReservableItemModel? reservableItem;
  final RecordItemModel? recordItem;

  ReservationDetailRouteData({this.reservableItem, this.recordItem});
}

enum EnumReservationInfoTabType {
  order,
  item;

  String get title => switch (this) {
        order => '訂單資訊',
        item => '品項資訊',
      };

  static EnumReservationInfoTabType fromIndex(int index) {
    return EnumReservationInfoTabType.values[index];
  }
}
