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
  final Future<void> Function(bool newValue)? onSwitchToggle;
  final VoidCallback? onBackButtonTap;
  final Future<String?> Function(String oldName)? onEditButtonTap;
  final VoidCallback? onSettingButtonTap;
  final VoidCallback? onTimerButtonTap;

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
  });
}
