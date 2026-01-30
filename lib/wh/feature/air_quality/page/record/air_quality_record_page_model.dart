import 'package:engo_terminal_app3/wh/feature/air_quality/page/reference/air_quality_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/data_constant.dart';
import 'package:get/get.dart';

class AirQualityRecordPageModel {
  AirQualityRecordPageRouterData? routerData;
  final selectedTimeFilter = EnumTimeFilter.day.obs;
  final selectedDataType = EnumAirQualityDataType.temperature.obs;
  final selectedDate = DateTime.now().obs;
  final chartData = Rxn<List<ChartDataModel>>();
}

class AirQualityRecordPageRouterData {
  final Future<({List<ChartDataModel> chartData})> Function(
    EnumTimeFilter timeFilter,
    EnumAirQualityDataType dataType,
    DateTime selectedDate,
  )? onDataFilterChanged;
  final Future<EnumAirQualityDataType?> Function()? onHelpButtonTap;

  const AirQualityRecordPageRouterData({
    this.onDataFilterChanged,
    this.onHelpButtonTap,
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
