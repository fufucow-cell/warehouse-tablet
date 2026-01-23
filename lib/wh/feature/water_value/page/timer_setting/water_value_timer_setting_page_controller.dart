import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/main/water_value_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/water_value_timer_setting_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/service/water_value_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'water_value_timer_setting_page_interactive.dart';
part 'water_value_timer_setting_page_route.dart';

class WaterValueTimerSettingPageController extends GetxController {
  // MARK: - Properties

  final _model = WaterValueTimerSettingPageModel();
  WaterValueService get _service => WaterValueService.instance;
  RxReadonly<int> get selectedTabRx => _model.selectedTab.readonly;
  RxReadonly<bool> get isRepeatEnabledRx => _model.isRepeatEnabled.readonly;
  RxReadonly<int> get selectedWeekdayRx => _model.selectedWeekday.readonly;
  RxReadonly<Set<int>> get selectedDaysRx => RxReadonly<Set<int>>(_model.selectedDays);
  RxReadonly<TimeOfDay?> get openTimeRx => _model.openTime.readonly;
  RxReadonly<TimeOfDay?> get closeTimeRx => _model.closeTime.readonly;
  RxReadonly<String> get noteTextRx => _model.noteText.readonly;
  RxReadonly<bool> get isNotificationEnabledRx => _model.isNotificationEnabled.readonly;

  // MARK: - Init

  WaterValueTimerSettingPageController(WaterValueTimerSettingPageRouterData routerData) {
    _model.routerData = routerData;
    // 将旧的 tab 值映射到新的值：0->0(開啟), 1->0(開啟), 2->1(關閉)
    final oldTab = routerData.initialSelectedTab;
    _model.selectedTab.value = oldTab == 2 ? 1 : 0;
    _model.isRepeatEnabled.value = routerData.initialRepeatEnabled;
    _model.isNotificationEnabled.value = routerData.initialNotificationEnabled;
    _model.selectedWeekday.value = routerData.initialSelectedWeekday;
    _model.selectedDays.value = routerData.initialSelectedDays ?? <int>{};
    _model.openTime.value = routerData.initialOpenTime;
    _model.closeTime.value = routerData.initialCloseTime;
    WaterValueService.register().registerServices(
      WaterValueMainPageRouterData(
        waterValueName: EnumLocale.waterValueControlSwitch.tr,
        initialSwitchState: false,
      ),
    );
  }

  // MARK: - Public Method

  void setContext(BuildContext context) {
    WaterValueService.instance.setContext(context);
  }

  void updateNoteText(String value) {
    _model.noteText.value = value;
  }

  // MARK: - Private Method
}
