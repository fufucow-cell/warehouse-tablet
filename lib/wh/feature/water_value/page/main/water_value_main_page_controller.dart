import 'package:engo_terminal_app3/wh/feature/water_value/page/main/water_value_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_list/water_value_timer_list_page.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_list/water_value_timer_list_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/water_value_timer_setting_page.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/water_value_timer_setting_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/service/water_value_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'water_value_main_page_interactive.dart';
part 'water_value_main_page_route.dart';

class WaterValueMainPageController extends GetxController {
  // MARK: - Properties

  final _model = WaterValueMainPageModel();
  WaterValueService get _service => WaterValueService.instance;
  RxReadonly<bool> get isSwitchOnRx => _model.isSwitchOn.readonly;
  RxReadonly<String> get titleRx => _model.title.readonly;

  // MARK: - Init

  WaterValueMainPageController(WaterValueMainPageRouterData routerData) {
    _model.routerData = routerData;
    _model.title.value = routerData.waterValueName;
    WaterValueService.register().registerServices(routerData);
    _model.isSwitchOn.value = routerData.initialSwitchState;
  }

  @override
  void onClose() {
    WaterValueService.unregister();
    super.onClose();
  }

  // MARK: - Public Method

  void setContext(BuildContext context) {
    WaterValueService.instance.setContext(context);
  }

  // MARK: - Private Method
}
