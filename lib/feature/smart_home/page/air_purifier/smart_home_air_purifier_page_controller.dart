import 'dart:math';

import 'package:engo_terminal_app3/feature/smart_home/page/air_purifier/smart_home_air_purifier_page_model.dart';
import 'package:engo_terminal_app3/feature/smart_home/service/smart_home_service.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/filter/air_quality_filter_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/air_quality_purifier_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/record/air_quality_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/reference/air_quality_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/data_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'smart_home_air_purifier_page_interactive.dart';
part 'smart_home_air_purifier_page_route.dart';

class SmartHomeAirPurifierPageController extends GetxController {
  final _model = SmartHomeAirPurifierPageModel();
  final _service = SmartHomeService.instance;
  final _random = Random();

  SmartHomeAirPurifierPageController();

  AirQualityDataItem _generateRandomData() {
    double generateValue(EnumAirQualityDataType dataType) {
      final min = dataType.defaultMin;
      final max = dataType.defaultMax;
      return min + _random.nextDouble() * (max - min);
    }

    return AirQualityDataItem(
      pm25: generateValue(EnumAirQualityDataType.pm25),
      temperature: generateValue(EnumAirQualityDataType.temperature),
      humidity: generateValue(EnumAirQualityDataType.humidity),
    );
  }

  void setContext(BuildContext context) {
    _model.context = context;
  }

  AirQualityPurifierPageRouterData get getAirPurifierPageRouterData {
    return AirQualityPurifierPageRouterData(
      language: _service.getCurrentLocaleCode,
      theme: _service.getCurrentThemeName,
      isModuleMode: false,
      deviceName: '空氣清淨機',
      roomName: '客廳',
      isOn: true,
      lifePercent: 75,
      initModel: EnumPurifierMode.auto,
      initFanSpeeds: EnumPurifierFanSpeed.weak,
      visibleDataTypes: [
        EnumAirQualityDataType.pm25,
        EnumAirQualityDataType.temperature,
        EnumAirQualityDataType.humidity,
      ],
      visibleModes: EnumPurifierMode.getAllModes,
      visibleFanSpeeds: EnumPurifierFanSpeed.getAllSpeeds,
      onBackButtonTap: () {
        routerHandle(EnumSmartHomeAirPurifierPageRoute.showSnackBar, data: SnackBarData('點擊返回'));
      },
      onSettingButtonTap: () {
        routerHandle(EnumSmartHomeAirPurifierPageRoute.showSnackBar, data: SnackBarData('點擊設定'));
      },
      onEditButtonTap: (String oldName) async {
        routerHandle(EnumSmartHomeAirPurifierPageRoute.showSnackBar, data: SnackBarData('編輯空氣清淨機名稱'));
        return Future.value('新空氣清淨機名稱');
      },
      onPowerToggle: (bool isOn) {
        routerHandle(EnumSmartHomeAirPurifierPageRoute.showSnackBar, data: SnackBarData('電源切換: ${isOn ? "開啟" : "關閉"}'));
      },
      onModeChanged: (EnumPurifierMode mode) {
        routerHandle(EnumSmartHomeAirPurifierPageRoute.showSnackBar, data: SnackBarData('模式變更: ${mode.name}'));
      },
      onFanSpeedChanged: (EnumPurifierFanSpeed speed) {
        routerHandle(EnumSmartHomeAirPurifierPageRoute.showSnackBar, data: SnackBarData('風量變更: ${speed.name}'));
      },
      onTimerChanged: (int hours) {
        routerHandle(EnumSmartHomeAirPurifierPageRoute.showSnackBar, data: SnackBarData('計時變更: $hours 小時'));
      },
      onDataRecordButtonTap: () async {
        routerHandle(EnumSmartHomeAirPurifierPageRoute.showSnackBar, data: SnackBarData('點擊數據按鈕'));
        return getAirPurifierRecordPageRouterData;
      },
      onDataUpdate: () {
        return _generateRandomData();
      },
      onFilterButtonTap: () async {
        routerHandle(EnumSmartHomeAirPurifierPageRoute.showSnackBar, data: SnackBarData('點擊濾網'));
        return AirQualityFilterPageRouterData(
          lifeDays: 1,
          lifePercent: 75,
          onlifeDaysChanged: (days) {
            routerHandle(EnumSmartHomeAirPurifierPageRoute.showSnackBar, data: SnackBarData('濾網天數變更: $days 天'));
          },
          onFilterReset: () {
            routerHandle(EnumSmartHomeAirPurifierPageRoute.showSnackBar, data: SnackBarData('濾網重置'));
          },
        );
      },
    );
  }

  AirQualityRecordPageRouterData get getAirPurifierRecordPageRouterData {
    return AirQualityRecordPageRouterData(
      onDataFilterChanged: (EnumTimeFilter timeFilter, EnumAirQualityDataType dataType, DateTime selectedDate) async {
        return (chartData: _getChartData(timeFilter, dataType));
      },
      onHelpButtonTap: () async {
        return null;
      },
    );
  }

  List<ChartDataModel> _getChartData(EnumTimeFilter timeFilter, EnumAirQualityDataType dataType) {
    final random = Random();
    final now = DateTime.now();
    final min = dataType.defaultMin;
    final max = dataType.defaultMax;
    final range = max - min;

    switch (timeFilter) {
      case EnumTimeFilter.day:
        return List.generate(24, (index) {
          final hour = index;
          final date = DateTime(now.year, now.month, now.day, hour);
          final hourFactor = hour / 23.0;
          final baseValue = min + (hourFactor * range * 0.6) + (random.nextDouble() * range * 0.4);
          return ChartDataModel(
            date: date,
            number: baseValue.clamp(min, max),
          );
        });
      case EnumTimeFilter.month:
        final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
        return List.generate(daysInMonth, (index) {
          final day = index + 1;
          final date = DateTime(now.year, now.month, day);
          final dayFactor = day / daysInMonth;
          final baseValue = min + (dayFactor * range * 0.5) + (random.nextDouble() * range * 0.5);
          return ChartDataModel(
            date: date,
            number: baseValue.clamp(min, max),
          );
        });
      case EnumTimeFilter.year:
        return List.generate(12, (index) {
          final month = index + 1;
          final date = DateTime(now.year, month, 15);
          final monthFactor = month / 12.0;
          final baseValue = min + (monthFactor * range * 0.5) + (random.nextDouble() * range * 0.5);
          return ChartDataModel(
            date: date,
            number: baseValue.clamp(min, max),
          );
        });
      default:
        return [];
    }
  }
}
