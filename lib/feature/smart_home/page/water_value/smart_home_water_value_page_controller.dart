import 'package:engo_terminal_app3/feature/smart_home/page/water_value/smart_home_water_value_page_model.dart';
import 'package:engo_terminal_app3/feature/smart_home/service/smart_home_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_snack_bar.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/main/water_value_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_list/water_value_timer_list_page.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_list/water_value_timer_list_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/water_value_timer_setting_page.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/water_value_timer_setting_page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'smart_home_water_value_page_interactive.dart';
part 'smart_home_water_value_page_route.dart';

class SmartHomeWaterValuePageController extends GetxController {
  // MARK: - Properties

  final _model = SmartHomeWaterValuePageModel();
  final _service = SmartHomeService.instance;

  // MARK: - Init

  SmartHomeWaterValuePageController();

  // MARK: - Public Method

  void setContext(BuildContext context) {
    _model.context = context;
  }

  WaterValueMainPageRouterData get getWaterValueMainPageRouterData {
    return WaterValueMainPageRouterData(
      language: _service.getCurrentLocaleCode,
      theme: _service.getCurrentThemeName,
      isModuleMode: false,
      waterValueName: EnumLocale.waterValue.tr,
      initialSwitchState: false,
      onSwitchToggle: (bool newValue) async {
        routerHandle(
          EnumSmartHomeWaterValuePageRoute.showSnackBar,
          data: SnackBarData('開關狀態變更', newValue ? '開啟' : '關閉'),
        );
      },
      onBackButtonTap: () {
        routerHandle(
          EnumSmartHomeWaterValuePageRoute.showSnackBar,
          data: SnackBarData('點擊返回'),
        );
      },
      onEditButtonTap: (String oldName) async {
        routerHandle(
          EnumSmartHomeWaterValuePageRoute.showSnackBar,
          data: SnackBarData('編輯止水閥名稱'),
        );
        return Future.value('新止水閥名稱');
      },
      onSettingButtonTap: () {
        routerHandle(
          EnumSmartHomeWaterValuePageRoute.showSnackBar,
          data: SnackBarData('點擊設定'),
        );
      },
      onTimerButtonTap: () {
        routerHandle(
          EnumSmartHomeWaterValuePageRoute.goToTimerListPage,
        );
      },
    );
  }

  // MARK: - Private Method
}
