import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_list/water_value_timer_list_page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterValueMainPageModel {
  WaterValueMainPageRouterData? routerData;
  final title = ''.obs;
  final isSwitchOn = false.obs;
}

class WaterValueMainPageRouterData {
  final String? language;
  final String? theme;
  final bool? isModuleMode;
  final String waterValueName;
  final bool initialSwitchState;
  final void Function(bool newValue)? onSwitchToggle;
  final VoidCallback? onBackButtonTap;
  final Future<String?> Function(String oldName)? onEditButtonTap;
  final VoidCallback? onSettingButtonTap;
  final VoidCallback? onTimerButtonTap;
  final Future<WaterValueTimerListPageRouterData?> Function()? onTimerListButtonTap;

  const WaterValueMainPageRouterData({
    this.language,
    this.theme,
    this.isModuleMode,
    required this.waterValueName,
    required this.initialSwitchState,
    this.onSwitchToggle,
    this.onBackButtonTap,
    this.onEditButtonTap,
    this.onSettingButtonTap,
    this.onTimerButtonTap,
    this.onTimerListButtonTap,
  });
}
