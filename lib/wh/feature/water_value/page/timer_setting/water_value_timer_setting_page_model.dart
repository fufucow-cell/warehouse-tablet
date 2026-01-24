import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterValueTimerSettingPageModel {
  WaterValueTimerSettingPageRouterData? routerData;
  final selectedTab = 0.obs; // 0: 開啟, 1: 關閉
  final isRepeatEnabled = false.obs;
  final selectedWeekday = 0.obs; // 0: 工作日, 1: 每天, 2: 自定義
  final selectedDays = Rx<Set<int>>(<int>{}); // 0-6: 周一到周日
  final time = Rxn<TimeOfDay>();
  final noteText = ''.obs;
  final isNotificationEnabled = false.obs;
}

class WaterValueTimerSettingPageRouterData {
  final String? language;
  final String? theme;
  final bool? isModuleMode;
  final TimeOfDay? initialTime;
  final bool initialRepeatEnabled;
  final bool initialNotificationEnabled;
  final int initialSelectedWeekday;
  final int initialSelectedTab;
  final Set<int>? initialSelectedDays; // 0-6: 周一到周日
  final Future<void> Function(TimeOfDay? time, bool repeatEnabled, int weekday, int tab, Set<int> selectedDays)? onSave;
  final VoidCallback? onBackButtonTap;
  final VoidCallback? onSettingButtonTap;
  final Future<void> Function(int tab)? onTabChanged;
  final Future<void> Function(TimeOfDay? time)? onTimeChanged;
  final Future<void> Function(bool enabled)? onRepeatToggle;
  final Future<void> Function(int weekday)? onWeekdayChanged;
  final Future<void> Function(Set<int> selectedDays)? onDaysChanged;
  final VoidCallback? onSettingTap;
  final VoidCallback? onLabelTap;
  final Future<void> Function(bool enabled)? onNotificationToggle;

  const WaterValueTimerSettingPageRouterData({
    this.language,
    this.theme,
    this.isModuleMode,
    this.initialTime,
    this.initialRepeatEnabled = false,
    this.initialNotificationEnabled = false,
    this.initialSelectedWeekday = 0,
    this.initialSelectedTab = 0,
    this.initialSelectedDays,
    this.onSave,
    this.onBackButtonTap,
    this.onSettingButtonTap,
    this.onTabChanged,
    this.onTimeChanged,
    this.onRepeatToggle,
    this.onWeekdayChanged,
    this.onDaysChanged,
    this.onSettingTap,
    this.onLabelTap,
    this.onNotificationToggle,
  });
}
