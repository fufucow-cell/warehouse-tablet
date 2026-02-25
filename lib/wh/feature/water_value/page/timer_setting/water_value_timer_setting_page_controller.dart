import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/main/water_value_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_list/water_value_timer_list_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/water_value_timer_setting_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/service/water_value_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'water_value_timer_setting_page_interactive.dart';
part 'water_value_timer_setting_page_route.dart';

class WaterValueTimerSettingPageController extends GetxController {
  // MARK: - Properties

  late final WaterValueTimerSettingPageModel _model;
  WaterValueService get _service => WaterValueService.instance;
  RxReadonly<EnumStatusTab> get enumStatusRx => _model.enumStatus.readonly;
  RxReadonly<bool> get isRepeatRx => _model.isRepeat.readonly;
  RxReadonly<EnumRepeatDay> get enumRepeatDayRx => _model.enumRepeatDay.readonly;
  RxReadonly<Set<int>> get selectedDaysRx => RxReadonly<Set<int>>(_model.selectedDays);
  RxReadonly<TimeOfDay> get timeRx => _model.time.readonly;
  RxReadonly<String> get noteTextRx => _model.noteText.readonly;
  RxReadonly<bool> get isNotifyRx => _model.isNotify.readonly;
  final textController = TextEditingController();

  // MARK: - Init

  WaterValueTimerSettingPageController(WaterValueTimerInfo info) {
    _model = WaterValueTimerSettingPageModel(info);
    textController.text = _model.noteText.value;
    WaterValueService.register().registerServices(
      WaterValueMainPageRouterData(
        waterValueName: EnumLocale.waterValueControlSwitch.tr,
        initialSwitchState: false,
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    // 监听 model 的变化，同步到 controller
    ever(_model.noteText, (value) {
      if (textController.text != value) {
        textController.text = value;
      }
    });
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
