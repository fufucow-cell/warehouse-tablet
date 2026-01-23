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
        _showTimePicker(data as bool); // true = openTime, false = closeTime
    }
  }

  // MARK: - Private Method

  Future<void> _showTimePicker(bool isOpenTime) async {
    final context = _service.getRootNavigatorContext ?? Get.context!;
    final initialTime = isOpenTime
        ? (_model.openTime.value ?? const TimeOfDay(hour: 8, minute: 0))
        : (_model.closeTime.value ?? const TimeOfDay(hour: 18, minute: 0));

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      if (isOpenTime) {
        interactive(EnumWaterValueTimerSettingPageInteractive.tapOpenTime, data: pickedTime);
      } else {
        interactive(EnumWaterValueTimerSettingPageInteractive.tapCloseTime, data: pickedTime);
      }
    }
  }
}
