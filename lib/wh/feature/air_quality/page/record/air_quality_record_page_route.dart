part of 'air_quality_record_page_controller.dart';

enum EnumAirQualityRecordPageRoute {
  goBack,
  goHelpPage,
  showDatePicker,
}

extension AirQualityRecordPageRouteExtension on AirQualityRecordPageController {
  Future<void> _routerHandle(EnumAirQualityRecordPageRoute type, {dynamic data}) async {
    final context = _service.getNestedNavigatorContext;

    if (context == null) {
      return;
    }

    switch (type) {
      case EnumAirQualityRecordPageRoute.goBack:
        Navigator.of(context).pop();
      case EnumAirQualityRecordPageRoute.goHelpPage:
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AirQualityReferencePage(type: _model.selectedDataType.value)),
        );
      case EnumAirQualityRecordPageRoute.showDatePicker:
        final selectedDate = _model.selectedDate.value;
        final timeFilter = _model.selectedTimeFilter.value;

        DateTime? pickedDate;
        if (timeFilter == EnumTimeFilter.day) {
          pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
        } else if (timeFilter == EnumTimeFilter.month) {
          // 月份选择器需要自定义实现
          pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            initialDatePickerMode: DatePickerMode.year,
          );
        } else {
          // 年份选择器需要自定义实现
          pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            initialDatePickerMode: DatePickerMode.year,
          );
        }

        if (pickedDate != null) {
          await _updateDate(pickedDate);
        }
    }
  }
}
