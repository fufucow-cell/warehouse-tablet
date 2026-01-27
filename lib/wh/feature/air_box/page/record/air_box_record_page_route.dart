part of 'air_box_record_page_controller.dart';

enum EnumAirBoxRecordPageRoute {
  goBack,
  goHelpPage,
  showDatePicker,
}

extension AirBoxRecordPageRouteExtension on AirBoxRecordPageController {
  Future<void> _routerHandle(EnumAirBoxRecordPageRoute type, {dynamic data}) async {
    final context = _service.getNestedNavigatorContext;

    if (context == null) {
      return;
    }

    switch (type) {
      case EnumAirBoxRecordPageRoute.goBack:
        Navigator.of(context).pop();
      case EnumAirBoxRecordPageRoute.goHelpPage:
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AirBoxReferencePage(type: _model.selectedDataType.value)),
        );
      case EnumAirBoxRecordPageRoute.showDatePicker:
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
