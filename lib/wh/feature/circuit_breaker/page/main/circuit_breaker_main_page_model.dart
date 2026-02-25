import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/alert_setting/circuit_breaker_alert_setting_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/data_record/circuit_breaker_data_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/notification_record/circuit_breaker_notification_record_page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircuitBreakerMainPageModel {
  CircuitBreakerMainPageRouterData? routerData;
  final title = ''.obs;
  final isSwitchOn = false.obs;
}

class CircuitBreakerMainPageRouterData {
  final String? language;
  final String? theme;
  final bool? isModuleMode;
  final String circuitBreakerName;
  final bool initialSwitchState;
  final String? currentTemperature;
  final String? cumulativePowerConsumption;
  final String? todayPowerConsumption;
  final String? power;
  final String? voltage;
  final String? current;
  final Future<void> Function(bool newValue)? onSwitchToggle;
  final VoidCallback? onBackButtonTap;
  final Future<String?> Function(String oldName)? onEditButtonTap;
  final VoidCallback? onSettingButtonTap;
  final Future<CircuitBreakerDataRecordPageRouterData> Function()? onDataRecordItemTap;
  final Future<CircuitBreakerNotificationRecordPageRouterData> Function()? onNotificationRecordItemTap;
  final Future<CircuitBreakerAlertSettingPageRouterData> Function()? onAlertSettingItemTap;

  const CircuitBreakerMainPageRouterData({
    this.language,
    this.theme,
    this.isModuleMode,
    required this.circuitBreakerName,
    required this.initialSwitchState,
    this.currentTemperature,
    this.cumulativePowerConsumption,
    this.todayPowerConsumption,
    this.power,
    this.voltage,
    this.current,
    this.onSwitchToggle,
    this.onBackButtonTap,
    this.onEditButtonTap,
    this.onSettingButtonTap,
    this.onDataRecordItemTap,
    this.onNotificationRecordItemTap,
    this.onAlertSettingItemTap,
  });
}
