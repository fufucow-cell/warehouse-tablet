import 'package:engo_terminal_app3/wh/feature/air_box/page/reference/air_box_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:get/get.dart';

class AirBoxRecordPageModel {
  AirBoxRecordPageRouterData? routerData;
  final selectedTimeFilter = EnumTimeFilter.day.obs;
  final selectedDataType = EnumAirBoxDataType.temperature.obs;
  final selectedDate = DateTime.now().obs;
  final chartData = Rxn<List<ChartDataModel>>();
}

class AirBoxRecordPageRouterData {
  final Future<({List<ChartDataModel> chartData})> Function(
    EnumTimeFilter timeFilter,
    EnumAirBoxDataType dataType,
    DateTime selectedDate,
  )? onDataFilterChanged;
  final Future<EnumAirBoxDataType?> Function()? onHelpButtonTap;

  const AirBoxRecordPageRouterData({
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

enum EnumTimeFilter {
  day,
  month,
  year;

  String get title => switch (this) {
        EnumTimeFilter.day => EnumLocale.engoTabDay.tr,
        EnumTimeFilter.month => EnumLocale.engoTabMonth.tr,
        EnumTimeFilter.year => EnumLocale.engoTabYear.tr,
      };

  static EnumTimeFilter fromString(String? value) {
    return EnumTimeFilter.values.firstWhereOrNull((e) => e.title == value) ?? EnumTimeFilter.day;
  }
}
