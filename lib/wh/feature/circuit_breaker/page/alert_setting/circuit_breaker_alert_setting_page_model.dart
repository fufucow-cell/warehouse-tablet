import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/material.dart';

class CircuitBreakerAlertSettingPageModel {
  CircuitBreakerAlertSettingPageRouterData? routerData;
}

class CircuitBreakerAlertSettingPageRouterData {
  final AlertSettingModel highTemperature;
  final AlertSettingModel highPower;
  final AlertSettingModel overCurrent;
  final AlertSettingModel voltage110Over;
  final AlertSettingModel voltage110Under;
  final AlertSettingModel voltage220Over;
  final AlertSettingModel voltage220Under;
  final VoidCallback? onRemoveDevice;

  CircuitBreakerAlertSettingPageRouterData({
    required this.highTemperature,
    required this.highPower,
    required this.overCurrent,
    required this.voltage110Over,
    required this.voltage110Under,
    required this.voltage220Over,
    required this.voltage220Under,
    this.onRemoveDevice,
  });
}

/// 警示设置数据模型
class AlertSettingModel {
  double value;
  bool alertStatus;
  bool circuitStatus;
  final TextEditingController valueController;
  final Future<void> Function(double newValue) onValueChanged;
  final Future<void> Function(bool alertStatus) onAlertSwitchChanged;
  final Future<void> Function(bool circuitStatus) onCircuitSwitchChanged;

  AlertSettingModel({
    required this.value,
    required this.alertStatus,
    required this.circuitStatus,
    required this.onValueChanged,
    required this.onAlertSwitchChanged,
    required this.onCircuitSwitchChanged,
  }) : valueController = TextEditingController(text: value.toString());
}

class DataModel {
  final EnumAlertSetting type;
  final AlertSettingModel setting;

  DataModel({
    required this.type,
    required this.setting,
  });
}

enum EnumAlertSetting {
  highTemperature,
  highPower,
  overCurrent,
  voltage110Over,
  voltage110Under,
  voltage220Over,
  voltage220Under;

  String get title => switch (this) {
        highTemperature => EnumLocale.engoHighTemperature.tr,
        highPower => EnumLocale.engoHighPower.tr,
        overCurrent => EnumLocale.engoOverCurrent.tr,
        voltage110Over => EnumLocale.engo110VOverVoltage.tr,
        voltage110Under => EnumLocale.engo110VUnderVoltage.tr,
        voltage220Over => EnumLocale.engo220VOverVoltage.tr,
        voltage220Under => EnumLocale.engo220VUnderVoltage.tr,
      };

  String get unit => switch (this) {
        highTemperature => EnumLocale.engoTemperatureUnit.tr,
        highPower => 'KW',
        overCurrent => 'A',
        voltage110Over => 'V',
        voltage110Under => 'V',
        voltage220Over => 'V',
        voltage220Under => 'V',
      };
}
