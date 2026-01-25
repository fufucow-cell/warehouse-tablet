import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/main/water_value_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_list/water_value_timer_list_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/water_value_timer_setting_page.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/service/water_value_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'water_value_timer_list_page_interactive.dart';
part 'water_value_timer_list_page_route.dart';

class WaterValueTimerListPageController extends GetxController {
  // MARK: - Properties

  final _model = WaterValueTimerListPageModel();
  WaterValueService get _service => WaterValueService.instance;
  RxReadonly<List<WaterValueTimerInfo>> get timerItemsRx => _model.timerItems.readonly;
  RxReadonly<bool> get isEditModeRx => _model.isEditMode.readonly;

  // MARK: - Init

  WaterValueTimerListPageController(WaterValueTimerListPageRouterData routerData) {
    _model.routerData = routerData;
    _model.timerItems.value = List<WaterValueTimerInfo>.from(routerData.timerInfoList);
    WaterValueService.register().registerServices(
      const WaterValueMainPageRouterData(
        waterValueName: '',
        initialSwitchState: false,
      ),
    );
  }

  // MARK: - Public Method
}
