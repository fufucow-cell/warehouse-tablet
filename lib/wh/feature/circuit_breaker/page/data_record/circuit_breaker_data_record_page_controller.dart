import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/data_record/circuit_breaker_data_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/service/circuit_breaker_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

part 'circuit_breaker_data_record_page_interactive.dart';
part 'circuit_breaker_data_record_page_route.dart';

class CircuitBreakerDataRecordPageController extends GetxController {
  // MARK: - Properties

  final _model = CircuitBreakerDataRecordPageModel();
  final _service = CircuitBreakerService.instance;
  RxReadonly<EnumTimeFilter> get selectedTimeFilterRx => _model.selectedTimeFilter.readonly;
  RxReadonly<DateTime> get selectedDateRx => _model.selectedDate.readonly;
  RxReadonly<List<ChartDataModel>?> get chartDataRx => _model.chartData.readonly;

  // MARK: - Init

  CircuitBreakerDataRecordPageController(CircuitBreakerDataRecordPageRouterData routerData) {
    _model.routerData = routerData;
    _fetchChartData();
  }

  // MARK: - Public Method

  String? get getTotalPower {
    final chartData = chartDataRx.value;

    if (chartData == null) {
      return null;
    }

    if (chartData.isEmpty) {
      return '0.00';
    }
    return chartData.map((e) => e.number).reduce((a, b) => a + b).toStringAsFixed(2);
  }

  String get getDateText {
    final selectedDate = selectedDateRx.value;
    final timeFilter = selectedTimeFilterRx.value;

    if (timeFilter == EnumTimeFilter.day) {
      return DateFormat('yyyy/MM/dd').format(selectedDate);
    } else if (timeFilter == EnumTimeFilter.month) {
      return DateFormat('yyyy/MM').format(selectedDate);
    } else {
      return DateFormat('yyyy').format(selectedDate);
    }
  }

  double? get getMaxYAxisValue {
    final chartData = chartDataRx.value;
    if (chartData == null) {
      return null;
    }
    return chartData.map((e) => e.number).reduce((a, b) => a > b ? a : b);
  }

  List<BarChartGroupData> get getBarGroups {
    final chartData = chartDataRx.value;

    if (chartData == null) {
      return [];
    }
    return chartData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data.number,
            color: EnumColor.textProduct.color,
            width: 20.0.scale,
            borderRadius: BorderRadius.circular(4.0.scale),
          ),
        ],
      );
    }).toList();
  }

  // MARK: - Private Method

  Future<void> _updateTimeFilter(String newFilter) async {
    final newFilterEnum = EnumTimeFilter.fromString(newFilter);

    if (_model.selectedTimeFilter.value == newFilterEnum) {
      return;
    }

    _model.selectedTimeFilter.value = newFilterEnum;
    await _fetchChartData();
  }

  Future<void> _updateDate(DateTime? newDate) async {
    if (newDate == null) {
      return;
    }

    if (newDate != _model.selectedDate.value) {
      _model.selectedDate.value = newDate;
      unawaited(_fetchChartData());
    }
  }

  Future<void> _fetchChartData() async {
    _model.chartData.value = null;
    final result = await _model.routerData?.onDataFilterChanged?.call(_model.selectedTimeFilter.value, _model.selectedDate.value);
    _model.chartData.value = result?.chartData;
  }
}
