import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/air_quality/page/filter/air_quality_filter_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/record/air_quality_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/reference/air_quality_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirQualityPurifierPageModel {
  AirQualityPurifierPageRouterData? routerData;
  final title = ''.obs;
  final isOn = false.obs;
  final sensorData = Rxn<AirQualityDataItem>();
  final filterLifePercent = 0.obs;
  final currentMode = EnumPurifierMode.manual.obs;
  final currentFanSpeed = EnumPurifierFanSpeed.weak.obs;
  final timerMinutes = 0.obs;
  int timerMinutesWhenPopupOpened = 0;
  final showModePopup = false.obs;
  final showFanSpeedPopup = false.obs;
  final showTimerPopup = false.obs;
  Timer? dataUpdateTimer;
  Timer? timeCounterTimer;
}

class AirQualityPurifierPageRouterData {
  final String? language;
  final String? theme;
  final bool? isModuleMode;
  final String deviceName;
  final String roomName;
  final bool isOn;
  final int lifePercent;
  final EnumPurifierMode initModel;
  final EnumPurifierFanSpeed initFanSpeeds;
  final List<EnumAirQualityDataType> visibleDataTypes;
  final List<EnumPurifierMode> visibleModes;
  final List<EnumPurifierFanSpeed> visibleFanSpeeds;
  final VoidCallback onBackButtonTap;
  final VoidCallback onSettingButtonTap;
  final Future<String?> Function(String oldName) onEditButtonTap;
  final void Function(bool isOn) onPowerToggle;
  final void Function(EnumPurifierMode mode) onModeChanged;
  final void Function(EnumPurifierFanSpeed speed) onFanSpeedChanged;
  final void Function(int minutes) onTimerChanged;
  final Future<AirQualityFilterPageRouterData>? Function()? onFilterButtonTap;
  final Future<AirQualityRecordPageRouterData>? Function()? onDataRecordButtonTap;
  final AirQualityDataItem Function() onDataUpdate;

  const AirQualityPurifierPageRouterData({
    this.language,
    this.theme,
    this.isModuleMode,
    required this.deviceName,
    required this.roomName,
    required this.isOn,
    required this.lifePercent,
    required this.initModel,
    required this.initFanSpeeds,
    required this.visibleDataTypes,
    required this.visibleModes,
    required this.visibleFanSpeeds,
    required this.onBackButtonTap,
    required this.onSettingButtonTap,
    required this.onEditButtonTap,
    required this.onPowerToggle,
    required this.onModeChanged,
    required this.onFanSpeedChanged,
    required this.onTimerChanged,
    this.onFilterButtonTap,
    this.onDataRecordButtonTap,
    required this.onDataUpdate,
  });
}

enum EnumPurifierMode {
  close,
  manual,
  auto,
  sleep;

  String get title => switch (this) {
        EnumPurifierMode.close => EnumLocale.purifierModeClose.tr,
        EnumPurifierMode.manual => EnumLocale.purifierModeManual.tr,
        EnumPurifierMode.auto => EnumLocale.purifierModeAuto.tr,
        EnumPurifierMode.sleep => EnumLocale.purifierModeSleep.tr,
      };

  Color get color => switch (this) {
        EnumPurifierMode.close => EnumColor.textPrimary.color,
        _ => EnumColor.engoBackgroundOrange400.color,
      };

  static List<EnumPurifierMode> get getAllModes => [
        EnumPurifierMode.manual,
        EnumPurifierMode.auto,
        EnumPurifierMode.sleep,
      ];
}

enum EnumPurifierFanSpeed {
  close,
  light,
  weak,
  strong;

  String get title => switch (this) {
        EnumPurifierFanSpeed.close => EnumLocale.purifierFanSpeedClose.tr,
        EnumPurifierFanSpeed.light => EnumLocale.purifierFanSpeedLight.tr,
        EnumPurifierFanSpeed.weak => EnumLocale.purifierFanSpeedWeak.tr,
        EnumPurifierFanSpeed.strong => EnumLocale.purifierFanSpeedStrong.tr,
      };

  Color get color => switch (this) {
        EnumPurifierFanSpeed.close => EnumColor.textPrimary.color,
        _ => EnumColor.engoBackgroundOrange400.color,
      };

  static List<EnumPurifierFanSpeed> get getAllSpeeds => [
        EnumPurifierFanSpeed.light,
        EnumPurifierFanSpeed.weak,
        EnumPurifierFanSpeed.strong,
      ];
}
