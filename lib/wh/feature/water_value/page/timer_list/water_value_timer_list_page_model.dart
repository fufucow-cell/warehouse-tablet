import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterValueTimerListPageModel {
  WaterValueTimerListPageRouterData? routerData;
  final timerItems = Rx<List<WaterValueTimerItem>>(<WaterValueTimerItem>[]);
  final isEditMode = false.obs; // 编辑模式：显示删除按钮
}

class WaterValueTimerItem {
  final String id;
  final String name;
  final TimeOfDay? openTime;
  final TimeOfDay? closeTime;
  final bool isRepeatEnabled;
  final int selectedWeekday; // 0: 工作日, 1: 每天, 2: 自定義
  final Set<int> selectedDays; // 0-6: 周一到周日
  final bool isNotificationEnabled;
  final String note;
  final bool isEnabled;

  WaterValueTimerItem({
    required this.id,
    required this.name,
    this.openTime,
    this.closeTime,
    required this.isRepeatEnabled,
    required this.selectedWeekday,
    required this.selectedDays,
    required this.isNotificationEnabled,
    required this.note,
    required this.isEnabled,
  });
}

class WaterValueTimerListPageRouterData {
  final String? language;
  final String? theme;
  final bool? isModuleMode;
  final List<WaterValueTimerItem> initialTimerItems;
  final Future<void> Function()? onAddTimer; // 添加新定时，跳转到定时设定页面
  final Future<void> Function(WaterValueTimerItem item)? onEditTimer; // 编辑定时，跳转到定时设定页面
  final Future<void> Function(String itemId)? onDeleteTimer; // 删除定时
  final Future<void> Function(String itemId, bool enabled)? onToggleTimer; // 切换定时开关
  final VoidCallback? onBackButtonTap;
  final VoidCallback? onSettingButtonTap; // 设置按钮，切换编辑模式

  const WaterValueTimerListPageRouterData({
    this.language,
    this.theme,
    this.isModuleMode,
    this.initialTimerItems = const [],
    this.onAddTimer,
    this.onEditTimer,
    this.onDeleteTimer,
    this.onToggleTimer,
    this.onBackButtonTap,
    this.onSettingButtonTap,
  });
}
