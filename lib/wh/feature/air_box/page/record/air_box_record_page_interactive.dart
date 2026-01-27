part of 'air_box_record_page_controller.dart';

enum EnumAirBoxRecordPageInteractive {
  tapTimeFilter,
  tapDataTypeFilter,
  tapDatePicker,
  tapHelpButton,
  tapBackButton,
}

extension AirBoxRecordPageInteractiveExtension on AirBoxRecordPageController {
  Future<void> interactive(EnumAirBoxRecordPageInteractive type, {dynamic data}) async {
    switch (type) {
      case EnumAirBoxRecordPageInteractive.tapTimeFilter:
        if (data is String) {
          final newFilterEnum = EnumTimeFilter.fromString(data);
          if (_model.selectedTimeFilter.value != newFilterEnum) {
            _model.selectedTimeFilter.value = newFilterEnum;
            await _fetchChartData();
          }
        }
      case EnumAirBoxRecordPageInteractive.tapDataTypeFilter:
        if (data is String && data.isNotEmpty) {
          final targetType = EnumAirBoxDataType.fromTitle(data);

          if (_model.selectedDataType.value != targetType) {
            _model.selectedDataType.value = targetType;
            await _fetchChartData();
          }
        }
      case EnumAirBoxRecordPageInteractive.tapDatePicker:
        await _routerHandle(EnumAirBoxRecordPageRoute.showDatePicker);
      case EnumAirBoxRecordPageInteractive.tapHelpButton:
        await _routerHandle(
          EnumAirBoxRecordPageRoute.goHelpPage,
          data: data,
        );
      case EnumAirBoxRecordPageInteractive.tapBackButton:
        await _routerHandle(EnumAirBoxRecordPageRoute.goBack);
    }
  }
}
