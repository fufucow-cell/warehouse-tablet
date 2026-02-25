import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/air_quality/page/record/air_quality_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/reference/air_quality_reference_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/reference/air_quality_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/service/air_quality_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/data_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'air_quality_record_page_interactive.dart';
part 'air_quality_record_page_route.dart';

class AirQualityRecordPageController extends GetxController {
  // MARK: - Properties

  final _model = AirQualityRecordPageModel();
  final _service = AirQualityService.instance;
  List<EnumAirQualityDataType> get dataTypeList => EnumAirQualityDataType.values;
  RxReadonly<EnumTimeFilter> get selectedTimeFilterRx => _model.selectedTimeFilter.readonly;
  RxReadonly<EnumAirQualityDataType> get selectedDataTypeRx => _model.selectedDataType.readonly;
  RxReadonly<DateTime> get selectedDateRx => _model.selectedDate.readonly;
  RxReadonly<List<ChartDataModel>?> get chartDataRx => _model.chartData.readonly;

  // MARK: - Init

  AirQualityRecordPageController(AirQualityRecordPageRouterData routerData) {
    _model.routerData = routerData;
    _fetchChartData();
  }

  // MARK: - Public Method

  String get getDateText {
    final selectedDate = selectedDateRx.value;
    final timeFilter = selectedTimeFilterRx.value;

    if (timeFilter == EnumTimeFilter.day) {
      return EnumTimeFilter.yearMonthDay.dateFormat.format(selectedDate);
    } else if (timeFilter == EnumTimeFilter.month) {
      return EnumTimeFilter.yearMonth.dateFormat.format(selectedDate);
    } else if (timeFilter == EnumTimeFilter.year) {
      return EnumTimeFilter.year.dateFormat.format(selectedDate);
    }

    return '';
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

  /// 根據 Y 軸刻度值取得對應的 ReferenceLevel（用於決定網格線顏色）
  ReferenceLevel? getReferenceLevelForYAxisValue(double value) {
    final dataType = selectedDataTypeRx.value;
    const epsilon = 0.0001;

    double parseNum(String raw) {
      return double.tryParse(raw.trim()) ?? 0.0;
    }

    // 先嘗試找到這個值作為級距起點或終點的 ReferenceLevel
    for (final level in dataType.referenceLevels) {
      final range = level.range.trim();
      if (range.contains('-')) {
        final parts = range.split('-');
        if (parts.length == 2) {
          final startValue = parseNum(parts[0]);
          final endValue = parseNum(parts[1]);
          // 檢查是否為起點或終點
          if ((value - startValue).abs() <= epsilon || (value - endValue).abs() <= epsilon) {
            return level;
          }
        }
      } else if (range.startsWith('<')) {
        final threshold = parseNum(range.substring(1));
        if ((value - threshold).abs() <= epsilon) {
          return level;
        }
      } else if (range.startsWith('>')) {
        final threshold = parseNum(range.substring(1));
        if ((value - threshold).abs() <= epsilon) {
          return level;
        }
      }
    }

    // 如果找不到作為起點或終點的，則使用 getReferenceLevelByValue 找到包含這個值的級距
    return dataType.getReferenceLevelByValue(value, null);
  }

  /// 使用 referenceLevels 的級距定義來產生 Y 軸刻度（包含 min/max）
  List<double> get getYAxisTickValues {
    final dataType = selectedDataTypeRx.value;
    final maxY = getMaxYAxisValue;
    final minY = getMinYAxisValue;

    final values = <double>{minY};

    double parseNum(String raw) {
      return double.tryParse(raw.trim()) ?? 0.0;
    }

    for (final level in dataType.referenceLevels) {
      final range = level.range.trim();
      if (range.contains('-')) {
        final parts = range.split('-');
        if (parts.length == 2) {
          values.add(parseNum(parts[0]));
        }
      } else if (range.startsWith('<')) {
        values.add(parseNum(range.substring(1)));
      } else if (range.startsWith('>')) {
        values.add(parseNum(range.substring(1)));
      }
    }

    // 最後一個刻度以 (資料最大值 vs 預設最大值) 的較大者為準
    values.add(maxY);
    values.add(dataType.defaultMax);

    final sorted = values.toList()..sort();
    // 避免 max == min 導致 interval 為 0
    if (sorted.isEmpty) {
      return [minY, maxY];
    }
    if (sorted.length == 1) {
      return [sorted.first, sorted.first + 1];
    }
    return sorted;
  }

  /// 用於 fl_chart 的 interval：取刻度間最小差值
  double get getYAxisIntervalByReferenceLevels {
    final dataType = selectedDataTypeRx.value;

    // 若是整數類型，直接用 1，確保像 PM2.5 的 0/36/54/71 都會被走到並顯示
    if (dataType.isIntegerType) {
      return 1;
    }

    // 小數類型：依 referenceLevels 的字串小數位數決定步進（例：0.005 -> 0.001）
    int decimalsOf(String s) {
      final t = s.trim();
      final idx = t.indexOf('.');
      if (idx < 0) {
        return 0;
      }
      return t.length - idx - 1;
    }

    int maxDecimals = 0;
    for (final level in dataType.referenceLevels) {
      final range = level.range.trim();
      if (range.contains('-')) {
        final parts = range.split('-');
        if (parts.length == 2) {
          maxDecimals = maxDecimals < decimalsOf(parts[0]) ? decimalsOf(parts[0]) : maxDecimals;
          maxDecimals = maxDecimals < decimalsOf(parts[1]) ? decimalsOf(parts[1]) : maxDecimals;
        }
      } else if (range.startsWith('<') || range.startsWith('>')) {
        maxDecimals = maxDecimals < decimalsOf(range.substring(1)) ? decimalsOf(range.substring(1)) : maxDecimals;
      }
    }

    // 最小到 0.0001，避免 interval 太小
    final step = switch (maxDecimals) {
      0 => 1.0,
      1 => 0.1,
      2 => 0.01,
      3 => 0.001,
      _ => 0.0001,
    };
    return step;
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
