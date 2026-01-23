part of 'water_value_timer_setting_page_controller.dart';

enum EnumWaterValueTimerSettingPageInteractive {
  tapBackButton,
  tapSettingButton,
  tapTab,
  tapOpenTime,
  tapCloseTime,
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
        _handleBackButton();
      case EnumWaterValueTimerSettingPageInteractive.tapSettingButton:
        _handleSettingButton();
      case EnumWaterValueTimerSettingPageInteractive.tapTab:
        _handleTabChanged(data as int);
      case EnumWaterValueTimerSettingPageInteractive.tapOpenTime:
        _handleOpenTimeChanged(data as TimeOfDay?);
      case EnumWaterValueTimerSettingPageInteractive.tapCloseTime:
        _handleCloseTimeChanged(data as TimeOfDay?);
      case EnumWaterValueTimerSettingPageInteractive.tapRepeatToggle:
        _handleRepeatToggle();
      case EnumWaterValueTimerSettingPageInteractive.tapWeekday:
        _handleWeekdayChanged(data as int);
      case EnumWaterValueTimerSettingPageInteractive.tapDay:
        _handleDayToggled(data as int);
      case EnumWaterValueTimerSettingPageInteractive.tapSetting:
        _handleSettingTap();
      case EnumWaterValueTimerSettingPageInteractive.tapLabel:
        _handleLabelTap();
      case EnumWaterValueTimerSettingPageInteractive.tapNotificationToggle:
        _handleNotificationToggle();
      case EnumWaterValueTimerSettingPageInteractive.tapSave:
        _handleSave();
    }
  }

  // MARK: - Private Method

  void _handleBackButton() {
    final callback = _model.routerData?.onBackButtonTap;
    if (callback != null) {
      callback();
    } else {
      routerHandle(EnumWaterValueTimerSettingPageRoute.goBack);
    }
  }

  void _handleSettingButton() {
    final callback = _model.routerData?.onSettingButtonTap;
    if (callback != null) {
      callback();
    }
  }

  Future<void> _handleTabChanged(int tab) async {
    _model.selectedTab.value = tab;
    final callback = _model.routerData?.onTabChanged;
    if (callback != null) {
      await callback(tab);
    }
  }

  Future<void> _handleOpenTimeChanged(TimeOfDay? time) async {
    _model.openTime.value = time;
    final callback = _model.routerData?.onOpenTimeChanged;
    if (callback != null) {
      await callback(time);
    }
  }

  Future<void> _handleCloseTimeChanged(TimeOfDay? time) async {
    _model.closeTime.value = time;
    final callback = _model.routerData?.onCloseTimeChanged;
    if (callback != null) {
      await callback(time);
    }
  }

  Future<void> _handleRepeatToggle() async {
    final newValue = !_model.isRepeatEnabled.value;
    _model.isRepeatEnabled.value = newValue;
    final callback = _model.routerData?.onRepeatToggle;
    if (callback != null) {
      await callback(newValue);
    }
  }

  Future<void> _handleWeekdayChanged(int weekday) async {
    _model.selectedWeekday.value = weekday;
    final callback = _model.routerData?.onWeekdayChanged;
    if (callback != null) {
      await callback(weekday);
    }
  }

  Future<void> _handleDayToggled(int day) async {
    // day: 0-6 代表周一到周日
    final currentSet = Set<int>.from(_model.selectedDays.value);
    if (currentSet.contains(day)) {
      currentSet.remove(day);
    } else {
      currentSet.add(day);
    }
    _model.selectedDays.value = currentSet;
    final callback = _model.routerData?.onDaysChanged;
    if (callback != null) {
      await callback(_model.selectedDays.value);
    }
  }

  void _handleSettingTap() {
    final callback = _model.routerData?.onSettingTap;
    if (callback != null) {
      callback();
    }
  }

  void _handleLabelTap() {
    final callback = _model.routerData?.onLabelTap;
    if (callback != null) {
      callback();
    }
  }

  Future<void> _handleNotificationToggle() async {
    final newValue = !_model.isNotificationEnabled.value;
    _model.isNotificationEnabled.value = newValue;
    final callback = _model.routerData?.onNotificationToggle;
    if (callback != null) {
      await callback(newValue);
    }
  }

  Future<void> _handleSave() async {
    final callback = _model.routerData?.onSave;
    if (callback != null) {
      await callback(
        _model.openTime.value,
        _model.closeTime.value,
        _model.isRepeatEnabled.value,
        _model.selectedWeekday.value,
        _model.selectedTab.value,
        _model.selectedDays.value,
      );
    }
  }
}
