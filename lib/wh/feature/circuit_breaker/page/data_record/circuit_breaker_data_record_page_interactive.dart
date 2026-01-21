part of 'circuit_breaker_data_record_page_controller.dart';

enum EnumCircuitBreakerDataRecordPageInteractive {
  tapSettingButton,
  tapTimeFilter,
  tapDatePicker,
}

extension CircuitBreakerDataRecordPageInteractiveExtension on CircuitBreakerDataRecordPageController {
  void interactive(EnumCircuitBreakerDataRecordPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumCircuitBreakerDataRecordPageInteractive.tapSettingButton:
        _model.routerData?.onSettingButtonTap?.call();
      case EnumCircuitBreakerDataRecordPageInteractive.tapTimeFilter:
        if (data is String) {
          _updateTimeFilter(data);
        }
      case EnumCircuitBreakerDataRecordPageInteractive.tapDatePicker:
        routerHandle(EnumCircuitBreakerDataRecordPageRoute.showDatePicker);
    }
  }
}
