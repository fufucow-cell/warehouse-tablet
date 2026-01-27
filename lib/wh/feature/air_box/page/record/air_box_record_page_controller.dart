import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/air_box/page/record/air_box_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/reference/air_box_reference_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/reference/air_box_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/service/air_box_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_date_format.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'air_box_record_page_interactive.dart';
part 'air_box_record_page_route.dart';

class AirBoxRecordPageController extends GetxController {
  // MARK: - Properties

  final _model = AirBoxRecordPageModel();
  final _service = AirBoxService.instance;
  List<EnumAirBoxDataType> get dataTypeList => EnumAirBoxDataType.values;
  RxReadonly<EnumTimeFilter> get selectedTimeFilterRx => _model.selectedTimeFilter.readonly;
  RxReadonly<EnumAirBoxDataType> get selectedDataTypeRx => _model.selectedDataType.readonly;
  RxReadonly<DateTime> get selectedDateRx => _model.selectedDate.readonly;
  RxReadonly<List<ChartDataModel>?> get chartDataRx => _model.chartData.readonly;

  // MARK: - Init

  AirBoxRecordPageController(AirBoxRecordPageRouterData routerData) {
    _model.routerData = routerData;
    _fetchChartData();
  }

  // MARK: - Public Method

  String get getDateText {
    final selectedDate = selectedDateRx.value;
    final timeFilter = selectedTimeFilterRx.value;

    return selectedDate.formatByTimeFilter(timeFilter);
  }

  double get getMaxYAxisValue {
    final chartData = chartDataRx.value;
    final dataType = selectedDataTypeRx.value;

    if (chartData == null || chartData.isEmpty) {
      return dataType.defaultMax;
    }

    final dataMax = chartData.map((e) => e.number).reduce((a, b) => a > b ? a : b);
    final defaultMax = dataType.defaultMax;

    // 使用數據最大值和預設最大值中的較大者
    return dataMax > defaultMax ? dataMax : defaultMax;
  }

  double get getMinYAxisValue {
    return selectedDataTypeRx.value.defaultMin;
  }

  String get getUnit {
    return selectedDataTypeRx.value.unit;
  }

  List<LineChartBarData> get getLineChartBars {
    final chartData = chartDataRx.value;

    if (chartData == null || chartData.isEmpty) {
      return [];
    }

    return [
      LineChartBarData(
        spots: chartData.asMap().entries.map((entry) {
          return FlSpot(entry.key.toDouble(), entry.value.number);
        }).toList(),
        isCurved: true,
        color: EnumColor.accentBlue.color,
        barWidth: 3.0,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
              radius: 4.0,
              color: EnumColor.accentBlue.color,
              strokeWidth: 2.0,
              strokeColor: Colors.white,
            );
          },
        ),
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  // MARK: - Private Method

  Future<void> _fetchChartData() async {
    final routerData = _model.routerData;

    if (routerData?.onDataFilterChanged == null) {
      return;
    }

    final result = await routerData!.onDataFilterChanged!(
      _model.selectedTimeFilter.value,
      _model.selectedDataType.value,
      _model.selectedDate.value,
    );

    _model.chartData.value = result.chartData;
  }

  Future<void> _updateDate(DateTime newDate) async {
    _model.selectedDate.value = newDate;
    await _fetchChartData();
  }
}
