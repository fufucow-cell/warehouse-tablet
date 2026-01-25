part of 'water_value_timer_setting_page_controller.dart';

enum EnumWaterValueTimerSettingPageRoute {
  goBack,
  showTimePicker,
}

extension WaterValueTimerSettingPageRouteExtension on WaterValueTimerSettingPageController {
  Future<void> _routerHandle(
    EnumWaterValueTimerSettingPageRoute type, {
    // ignore: unused_element
    dynamic data,
  }) async {
    switch (type) {
      case EnumWaterValueTimerSettingPageRoute.goBack:
        Navigator.of(_service.getNestedNavigatorContext!).pop(data);
      case EnumWaterValueTimerSettingPageRoute.showTimePicker:
        final initialTime = _model.time.value;

        final pickedTime = await showTimePicker(
          context: _service.getRootNavigatorContext!,
          initialTime: initialTime,
        );

        if (pickedTime != null) {
          interactive(EnumWaterValueTimerSettingPageInteractive.tapTime, data: pickedTime);
        }
    }
  }
}
