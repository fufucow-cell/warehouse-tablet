import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/data_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircuitBreakerDataRecordPageModel {
  CircuitBreakerDataRecordPageRouterData? routerData;
  final selectedTimeFilter = EnumTimeFilter.day.obs;
  final selectedDate = DateTime.now().obs;
  final chartData = Rxn<List<ChartDataModel>>();
}

class CircuitBreakerDataRecordPageRouterData {
  final Future<({List<ChartDataModel> chartData})> Function(
    EnumTimeFilter timeFilter,
    DateTime selectedDate,
  )? onDataFilterChanged;
  final VoidCallback? onSettingButtonTap;

  const CircuitBreakerDataRecordPageRouterData({
    this.onDataFilterChanged,
    this.onSettingButtonTap,
  });
}

/// 图表数据模型
class ChartDataModel {
  final DateTime date;
  final double number;

  const ChartDataModel({
    required this.date,
    required this.number,
  });
}
