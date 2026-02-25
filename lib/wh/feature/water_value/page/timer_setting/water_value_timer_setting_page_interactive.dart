part of 'water_value_timer_setting_page_controller.dart';

enum EnumWaterValueTimerSettingPageInteractive {
  tapBackButton,
  tapSettingButton,
  tapTab,
  tapTime,
  tapRepeatToggle,
  tapWeekday,
  tapDay,
  tapSetting,
  tapLabel,
  tapNotificationToggle,
  tapSave,
}

extension WaterValueTimerSettingPageUserEventExtension on WaterValueTimerSettingPageController {
  void interactive(
    EnumWaterValueTimerSettingPageInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumWaterValueTimerSettingPageInteractive.tapBackButton:
        _routerHandle(EnumWaterValueTimerSettingPageRoute.goBack);
      case EnumWaterValueTimerSettingPageInteractive.tapSettingButton:
        break;
      case EnumWaterValueTimerSettingPageInteractive.tapTab:
        _model.enumStatus.value = data as EnumStatusTab;
      case EnumWaterValueTimerSettingPageInteractive.tapTime:
        final time = data as TimeOfDay?;
        if (time != null) {
          _model.time.value = time;
        }
      case EnumWaterValueTimerSettingPageInteractive.tapRepeatToggle:
        _model.isRepeat.value = !_model.isRepeat.value;
      case EnumWaterValueTimerSettingPageInteractive.tapWeekday:
        final weekday = data as EnumRepeatDay;
        _model.enumRepeatDay.value = weekday;
        if (weekday != EnumRepeatDay.custom) {
          _model.selectedDays.value = weekday.selectedDays;
        }
      case EnumWaterValueTimerSettingPageInteractive.tapDay:
        final day = data as int;
        final currentSet = Set<int>.from(_model.selectedDays.value);
        if (currentSet.contains(day)) {
          currentSet.remove(day);
        } else {
          currentSet.add(day);
        }
        _model.selectedDays.value = currentSet;
      case EnumWaterValueTimerSettingPageInteractive.tapSetting:
        break;
      case EnumWaterValueTimerSettingPageInteractive.tapLabel:
        break;
      case EnumWaterValueTimerSettingPageInteractive.tapNotificationToggle:
        _model.isNotify.value = !_model.isNotify.value;
      case EnumWaterValueTimerSettingPageInteractive.tapSave:
        final timerInfo = WaterValueTimerInfo(
          id: _model.id.value?.isEmpty ?? true ? null : _model.id.value,
          time: _model.time.value,
          isEnable: true,
          isRepeat: _model.isRepeat.value,
          isNotify: _model.isNotify.value,
          enumStatus: _model.enumStatus.value,
          enumRepeatDay: _model.enumRepeatDay.value,
          selectedDays: _model.selectedDays.value,
          note: textController.text.isEmpty ? null : textController.text,
        );
        _routerHandle(EnumWaterValueTimerSettingPageRoute.goBack, data: timerInfo);
    }
  }
}
