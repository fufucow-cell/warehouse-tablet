import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/air_quality/page/filter/air_quality_filter_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/filter/air_quality_filter_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/air_quality_purifier_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/record/air_quality_record_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/record/air_quality_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/reference/air_quality_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/service/air_quality_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'air_quality_purifier_page_interactive.dart';
part 'air_quality_purifier_page_route.dart';

class AirQualityPurifierPageController extends GetxController {
  // MARK: - Properties

  final _model = AirQualityPurifierPageModel();
  AirQualityService get _service => AirQualityService.instance;
  RxReadonly<String> get titleRx => _model.title.readonly;
  String get getRoomName => _model.routerData?.roomName ?? '';
  RxReadonly<bool> get isOnRx => _model.isOn.readonly;
  RxReadonly<int> get filterLifePercentRx => _model.filterLifePercent.readonly;
  RxReadonly<EnumPurifierMode> get currentModeRx => _model.currentMode.readonly;
  RxReadonly<EnumPurifierFanSpeed> get currentFanSpeedRx => _model.currentFanSpeed.readonly;
  RxReadonly<int> get timerMinutesRx => _model.timerMinutes.readonly;
  int get timerMinutesWhenPopupOpened => _model.timerMinutesWhenPopupOpened;

  void setTimerMinutes(int value) {
    _model.timerMinutes.value = value.clamp(1, 60);
  }

  RxReadonly<bool> get showModePopupRx => _model.showModePopup.readonly;
  RxReadonly<bool> get showFanSpeedPopupRx => _model.showFanSpeedPopup.readonly;
  RxReadonly<bool> get showTimerPopupRx => _model.showTimerPopup.readonly;
  RxReadonly<AirQualityDataItem?> get sensorDataRx => _model.sensorData.readonly;
  List<EnumAirQualityDataType> get visibleDataTypes => _model.routerData?.visibleDataTypes ?? [];

  // MARK: - Init

  AirQualityPurifierPageController(AirQualityPurifierPageRouterData routerData) {
    _model.routerData = routerData;
    AirQualityService.register().registerServicesForPurifier(routerData);
    _initData();
  }

  void _initData() {
    final routerData = _model.routerData;

    if (routerData == null) {
      return;
    }

    _model.title.value = routerData.deviceName;
    _model.isOn.value = routerData.isOn;
    _model.filterLifePercent.value = routerData.filterLifePercent;
    _model.currentMode.value = routerData.initModel;
    _model.currentFanSpeed.value = routerData.initFanSpeeds;
    _model.timerMinutes.value = 0;
    _startSensorUpdate();
  }

  @override
  void onClose() {
    _model.dataUpdateTimer?.cancel();
    super.onClose();
  }

  // MARK: - Public Method

  void setContext(BuildContext context) {
    _service.setContext(context);
  }

  String getValueForDataType(EnumAirQualityDataType dataType) {
    final sensorData = _model.sensorData.value;

    if (sensorData == null) {
      return '-';
    }

    final value = switch (dataType) {
      EnumAirQualityDataType.pm25 => sensorData.pm25,
      EnumAirQualityDataType.temperature => sensorData.temperature,
      EnumAirQualityDataType.humidity => sensorData.humidity,
      EnumAirQualityDataType.hcho => sensorData.hcho,
      EnumAirQualityDataType.voc => sensorData.voc,
      EnumAirQualityDataType.co2 => sensorData.co2,
    };

    if (value == null) {
      return '-';
    }

    return value.toStringAsFixed(2);
  }

  String getPm25Status() {
    final sensorData = _model.sensorData.value;
    if (sensorData == null || sensorData.pm25 == null) {
      return '';
    }

    final level = EnumAirQualityDataType.pm25.getReferenceLevelByValue(sensorData.pm25!, null);
    return level?.statusLocale.tr ?? '';
  }

  String getTimeCounterText() {
    if (timerMinutesRx.value == 0) {
      return EnumLocale.purifierTimerLabel.tr;
    }
    final totalMinutes = timerMinutesRx.value;
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    final hhMm = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    return '${EnumLocale.purifierTimerRemaining.tr} $hhMm';
  }

  List<Map<EnumAirQualityDataType, double?>> get getSensorDatas {
    final result = List<Map<EnumAirQualityDataType, double?>>.empty(growable: true);
    final sensor = _model.sensorData.value;

    for (final type in visibleDataTypes) {
      final value = switch (type) {
        EnumAirQualityDataType.pm25 => sensor?.pm25,
        EnumAirQualityDataType.temperature => sensor?.temperature,
        EnumAirQualityDataType.humidity => sensor?.humidity,
        EnumAirQualityDataType.hcho => sensor?.hcho,
        EnumAirQualityDataType.voc => sensor?.voc,
        EnumAirQualityDataType.co2 => sensor?.co2,
      };
      result.add({type: value});
    }

    return result;
  }

  String get getFilterLifeText {
    if (isOnRx.value) {
      return '${EnumLocale.purifierFilterLife.tr}:${filterLifePercentRx.value}%';
    } else {
      return EnumLocale.purifierFilterLife.tr;
    }
  }

  // MARK: - Private Method

  void _turnOff() {
    _model.isOn.value = false;
    _model.currentMode.value = EnumPurifierMode.close;
    _model.currentFanSpeed.value = EnumPurifierFanSpeed.close;
    _model.timerMinutes.value = 0;
    _stopSensorUpdate();
    _stopTimeCounter();
  }

  void _startSensorUpdate() {
    _stopSensorUpdate();
    _model.dataUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final data = _model.routerData?.onDataUpdate();
      _model.sensorData.value = data;
    });
  }

  void _stopSensorUpdate() {
    _model.dataUpdateTimer?.cancel();
    _model.dataUpdateTimer = null;
    _model.sensorData.value = null;
  }

  void _startTimeCounter() {
    _stopTimeCounter();
    _model.timeCounterTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      final minutes = timerMinutesRx.value - 1;

      if (minutes <= 0) {
        interactive(EnumAirQualityPurifierPageInteractive.tapPowerButton, data: false);
        return;
      }

      _model.timerMinutes.value = minutes;
    });
  }

  void _stopTimeCounter() {
    _model.timeCounterTimer?.cancel();
    _model.timeCounterTimer = null;
  }
}
