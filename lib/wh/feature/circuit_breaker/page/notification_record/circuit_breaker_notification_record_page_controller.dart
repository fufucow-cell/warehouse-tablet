import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/notification_record/circuit_breaker_notification_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/service/circuit_breaker_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

part 'circuit_breaker_notification_record_page_interactive.dart';
part 'circuit_breaker_notification_record_page_route.dart';

class CircuitBreakerNotificationRecordPageController extends GetxController {
  // MARK: - Properties

  final _model = CircuitBreakerNotificationRecordPageModel();
  final _service = CircuitBreakerService.instance;
  RxReadonly<EnumRecordType> get selectedTabRx => _model.selectedTab.readonly;
  RxReadonly<Map<String, List<RecordModel>>?> get currentRecordsRx => _model.currentRecords.readonly;

  // MARK: - Init

  CircuitBreakerNotificationRecordPageController(CircuitBreakerNotificationRecordPageRouterData routerData) {
    _model.routerData = routerData;
    _fetchRecords();
  }

  // MARK: - Public Method

  String convertTime(DateTime date) {
    return DateFormat('hh:mm').format(date);
  }

  // MARK: - Private Method

  Future<void> _fetchRecords() async {
    _model.currentRecords.value = null;
    final records = await _model.routerData!.onTabChanged!(_model.selectedTab.value);
    _group(records);
  }

  void _group(List<RecordModel> records) {
    records.sort((a, b) => b.date.compareTo(a.date));

    final groupedRecords = <String, List<RecordModel>>{};
    for (final record in records) {
      final dateKey = DateFormat('yyyy/MM/dd').format(record.date);
      groupedRecords.putIfAbsent(dateKey, () => []).add(record);
    }

    final sortedDates = groupedRecords.keys.toList()..sort((a, b) => b.compareTo(a));

    final sortedGroupedRecords = <String, List<RecordModel>>{};
    for (final dateKey in sortedDates) {
      sortedGroupedRecords[dateKey] = groupedRecords[dateKey]!;
    }

    _model.currentRecords.value = sortedGroupedRecords;
  }
}
