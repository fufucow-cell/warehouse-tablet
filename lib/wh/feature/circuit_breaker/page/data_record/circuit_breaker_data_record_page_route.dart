part of 'circuit_breaker_data_record_page_controller.dart';

enum EnumCircuitBreakerDataRecordPageRoute {
  goBack,
  showDatePicker,
  closeDatePicker,
}

extension CircuitBreakerDataRecordPageRouteExtension on CircuitBreakerDataRecordPageController {
  void routerHandle(EnumCircuitBreakerDataRecordPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumCircuitBreakerDataRecordPageRoute.goBack:
        final context = _service.getNestedNavigatorContext;

        if (context == null) {
          return;
        }

        Navigator.of(context).pop();
      case EnumCircuitBreakerDataRecordPageRoute.showDatePicker:
        _showDatePicker();
      case EnumCircuitBreakerDataRecordPageRoute.closeDatePicker:
        final context = _service.getRootNavigatorContext;

        if (context == null) {
          return;
        }
        Navigator.of(context).pop();
    }
  }

  Future<void> _showDatePicker() async {
    final currentDate = DateTime.now();
    final timeFilter = _model.selectedTimeFilter.value;
    DateTime selectedDate = _model.selectedDate.value;
    final context = _service.getRootNavigatorContext;

    if (context == null) {
      return;
    }

    if (timeFilter == EnumTimeFilter.day) {
      selectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    } else if (timeFilter == EnumTimeFilter.month) {
      selectedDate = DateTime(selectedDate.year, selectedDate.month, 1);
    } else {
      selectedDate = DateTime(selectedDate.year, 1, 1);
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(currentDate.year - 3),
      lastDate: currentDate,
      initialDatePickerMode: timeFilter == EnumTimeFilter.year
          ? DatePickerMode.year
          : timeFilter == EnumTimeFilter.month
              ? DatePickerMode.year
              : DatePickerMode.day,
    );

    _updateDate(picked);
  }
}
