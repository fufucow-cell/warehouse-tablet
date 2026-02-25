part of 'air_quality_record_page_controller.dart';

enum EnumAirQualityRecordPageInteractive {
  tapTimeFilter,
  tapDataTypeFilter,
  tapDatePicker,
  tapHelpButton,
  tapBackButton,
}

extension AirQualityRecordPageInteractiveExtension on AirQualityRecordPageController {
  Future<void> interactive(EnumAirQualityRecordPageInteractive type, {dynamic data}) async {
    switch (type) {
      case EnumAirQualityRecordPageInteractive.tapTimeFilter:
        if (data is EnumTimeFilter && _model.selectedTimeFilter.value != data) {
          _model.selectedTimeFilter.value = data;
          await _fetchChartData();
        }
      case EnumAirQualityRecordPageInteractive.tapDataTypeFilter:
        if (data is String && data.isNotEmpty) {
          final targetType = EnumAirQualityDataType.fromTitle(data);

          if (_model.selectedDataType.value != targetType) {
            _model.selectedDataType.value = targetType;
            await _fetchChartData();
          }
        }
      case EnumAirQualityRecordPageInteractive.tapDatePicker:
        await _routerHandle(EnumAirQualityRecordPageRoute.showDatePicker);
      case EnumAirQualityRecordPageInteractive.tapHelpButton:
        await _routerHandle(
          EnumAirQualityRecordPageRoute.goHelpPage,
          data: data,
        );
      case EnumAirQualityRecordPageInteractive.tapBackButton:
        await _routerHandle(EnumAirQualityRecordPageRoute.goBack);
    }
  }
}
