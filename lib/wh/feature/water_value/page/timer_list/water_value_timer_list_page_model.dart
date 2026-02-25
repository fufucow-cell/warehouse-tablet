import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterValueTimerListPageModel {
  WaterValueTimerListPageRouterData? routerData;
  final timerItems = Rx<List<WaterValueTimerInfo>>(<WaterValueTimerInfo>[]);
  final isEditMode = false.obs; // 编辑模式：显示删除按钮
}

class WaterValueTimerListPageRouterData {
  final List<WaterValueTimerInfo> timerInfoList;
  final Future<WaterValueTimerInfo> Function(WaterValueTimerInfo info) itemUpdate;
  final Future<bool> Function(WaterValueTimerInfo info) itemDelete;

  const WaterValueTimerListPageRouterData({
    this.timerInfoList = const [],
    required this.itemUpdate,
    required this.itemDelete,
  });
}

class WaterValueTimerInfo {
  String? id;
  TimeOfDay? time;
  bool? isEnable;
  bool? isRepeat;
  bool? isNotify;
  EnumStatusTab? enumStatus;
  EnumRepeatDay? enumRepeatDay;
  Set<int>? selectedDays;
  String? note;

  WaterValueTimerInfo({
    this.id,
    this.time,
    this.isEnable,
    this.isRepeat,
    this.isNotify,
    this.enumStatus,
    this.enumRepeatDay,
    this.selectedDays,
    this.note,
  });
}

enum EnumStatusTab {
  open,
  close;

  String get title => switch (this) {
        EnumStatusTab.open => EnumLocale.waterValueTimerOpen.tr,
        EnumStatusTab.close => EnumLocale.waterValueTimerClose.tr,
      };
}

enum EnumRepeatDay {
  weekday,
  everyday,
  custom;

  String get title => switch (this) {
        EnumRepeatDay.weekday => EnumLocale.waterValueTimerWeekday.tr,
        EnumRepeatDay.everyday => EnumLocale.waterValueTimerEveryday.tr,
        EnumRepeatDay.custom => EnumLocale.waterValueTimerCustom.tr,
      };

  Set<int> get selectedDays => switch (this) {
        EnumRepeatDay.weekday => <int>{1, 2, 3, 4, 5},
        EnumRepeatDay.everyday => <int>{1, 2, 3, 4, 5, 6, 7},
        EnumRepeatDay.custom => <int>{},
      };
}
