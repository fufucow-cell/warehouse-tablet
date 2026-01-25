import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_list/water_value_timer_list_page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterValueTimerSettingPageModel {
  final Rx<String?> id;
  final Rx<bool> isRepeat;
  final Rx<bool> isNotify;
  final Rx<EnumStatusTab> enumStatus;
  final Rx<EnumRepeatDay> enumRepeatDay;
  final Rx<Set<int>> selectedDays;
  final Rx<TimeOfDay> time;
  final Rx<String> noteText;

  WaterValueTimerSettingPageModel(WaterValueTimerInfo data)
      : id = (data.id ?? '').obs,
        isRepeat = (data.isRepeat ?? false).obs,
        isNotify = (data.isNotify ?? false).obs,
        enumStatus = (data.enumStatus ?? EnumStatusTab.open).obs,
        enumRepeatDay = (data.enumRepeatDay ?? EnumRepeatDay.weekday).obs,
        selectedDays = Rx<Set<int>>(
          data.selectedDays ?? (data.enumRepeatDay ?? EnumRepeatDay.weekday).selectedDays,
        ),
        time = Rx<TimeOfDay>(data.time ?? TimeOfDay.now()),
        noteText = (data.note ?? '').obs;
}
