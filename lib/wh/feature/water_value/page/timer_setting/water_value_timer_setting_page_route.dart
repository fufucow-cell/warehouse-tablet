part of 'water_value_timer_setting_page_controller.dart';

enum EnumWaterValueTimerSettingPageRoute {
  goBack,
  showTimePicker,
}

extension WaterValueTimerSettingPageRouteExtension on WaterValueTimerSettingPageController {
  void routerHandle(
    EnumWaterValueTimerSettingPageRoute type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumWaterValueTimerSettingPageRoute.goBack:
        Navigator.of(_service.getNestedNavigatorContext!).pop();
      case EnumWaterValueTimerSettingPageRoute.showTimePicker:
        _showTimePicker();
    }
  }

  // MARK: - Private Method

  Future<void> _showTimePicker() async {
    final context = _service.getRootNavigatorContext ?? Get.context!;
    final initialTime = _model.time.value ?? const TimeOfDay(hour: 8, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      interactive(EnumWaterValueTimerSettingPageInteractive.tapTime, data: pickedTime);
    }
  }
}
