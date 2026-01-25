import 'dart:math';

import 'package:engo_terminal_app3/feature/smart_home/page/water_value/smart_home_water_value_page_model.dart';
import 'package:engo_terminal_app3/feature/smart_home/service/smart_home_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_snack_bar.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/main/water_value_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_list/water_value_timer_list_page_model.dart';
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
      onSwitchToggle: (bool newValue) {
        _routerHandle(
          EnumSmartHomeWaterValuePageRoute.showSnackBar,
          data: SnackBarData('開關狀態變更', newValue ? '開啟' : '關閉'),
        );
      },
      onBackButtonTap: () {
        _routerHandle(
          EnumSmartHomeWaterValuePageRoute.showSnackBar,
          data: SnackBarData('點擊返回'),
        );
      },
      onEditButtonTap: (String oldName) async {
        _routerHandle(
          EnumSmartHomeWaterValuePageRoute.showSnackBar,
          data: SnackBarData('編輯止水閥名稱'),
        );
        return Future.value('新止水閥名稱');
      },
      onSettingButtonTap: () {
        _routerHandle(
          EnumSmartHomeWaterValuePageRoute.showSnackBar,
          data: SnackBarData('點擊設定'),
        );
      },
      onTimerButtonTap: () {
        _routerHandle(
          EnumSmartHomeWaterValuePageRoute.showSnackBar,
          data: SnackBarData(EnumLocale.waterValueTimer.tr, ''),
        );
      },
      onTimerListButtonTap: () async {
        return _getTimerListPageRouterData();
      },
    );
  }

  // MARK: - Private Method

  WaterValueTimerListPageRouterData _getTimerListPageRouterData() {
    return WaterValueTimerListPageRouterData(
      itemDelete: (WaterValueTimerInfo info) async {
        _routerHandle(
          EnumSmartHomeWaterValuePageRoute.showSnackBar,
          data: SnackBarData('刪除定時'),
        );
        return true;
      },
      timerInfoList: [
        WaterValueTimerInfo(
          id: '1',
          time: const TimeOfDay(hour: 8, minute: 0),
          isEnable: true,
          isRepeat: true,
          isNotify: false,
          enumStatus: EnumStatusTab.open,
          enumRepeatDay: EnumRepeatDay.weekday,
          note: '工作日早上開啟',
        ),
        WaterValueTimerInfo(
          id: '2',
          time: const TimeOfDay(hour: 22, minute: 0),
          isEnable: true,
          isRepeat: true,
          isNotify: false,
          enumStatus: EnumStatusTab.close,
          enumRepeatDay: EnumRepeatDay.everyday,
          note: '每天晚上關閉',
        ),
        WaterValueTimerInfo(
          id: '3',
          time: const TimeOfDay(hour: 12, minute: 30),
          isEnable: true,
          isRepeat: true,
          isNotify: true,
          enumStatus: EnumStatusTab.open,
          enumRepeatDay: EnumRepeatDay.custom,
          selectedDays: const {1, 3, 5}, // 週一、三、五
          note: '週一三五中午開啟',
        ),
      ],
      itemUpdate: (WaterValueTimerInfo info) async {
        _routerHandle(
          EnumSmartHomeWaterValuePageRoute.showSnackBar,
          data: SnackBarData((info.id?.isNotEmpty ?? false) ? '更新定時' : '新增定時'),
        );

        if (info.id?.isEmpty ?? true) {
          info.id = Random().nextInt(10000).toString();
        }
        return info;
      },
    );
  }
}
