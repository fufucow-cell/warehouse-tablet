import 'dart:math';

import 'package:engo_terminal_app3/feature/smart_home/page/air_box/smart_home_air_box_page_model.dart';
import 'package:engo_terminal_app3/feature/smart_home/service/smart_home_service.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/box/air_quality_box_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/record/air_quality_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/reference/air_quality_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'smart_home_air_box_page_interactive.dart';
part 'smart_home_air_box_page_route.dart';

class SmartHomeAirBoxPageController extends GetxController {
  final _model = SmartHomeAirBoxPageModel();
  final _service = SmartHomeService.instance;
  final _random = Random();

  SmartHomeAirBoxPageController();

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
      hcho: generateValue(EnumAirQualityDataType.hcho),
      voc: generateValue(EnumAirQualityDataType.voc),
      co2: generateValue(EnumAirQualityDataType.co2),
    );
  }

  void setContext(BuildContext context) {
    _model.context = context;
  }

  AirQualityBoxPageRouterData get getAirBoxMainPageRouterData {
    return AirQualityBoxPageRouterData(
      language: _service.getCurrentLocaleCode,
      theme: _service.getCurrentThemeName,
      isModuleMode: false,
      roomName: '廚房',
      deviceName: '空氣盒',
      visibleDataTypes: [
        EnumAirQualityDataType.pm25,
        EnumAirQualityDataType.temperature,
        EnumAirQualityDataType.humidity,
        EnumAirQualityDataType.hcho,
        EnumAirQualityDataType.voc,
        EnumAirQualityDataType.co2,
      ],
      onBackButtonTap: () {
        routerHandle(EnumSmartHomeAirBoxPageRoute.showSnackBar, data: SnackBarData('點擊返回'));
      },
      onEditButtonTap: (String oldName) async {
        routerHandle(EnumSmartHomeAirBoxPageRoute.showSnackBar, data: SnackBarData('編輯空氣盒名稱'));
        return Future.value('新空氣盒名稱');
      },
      onSettingButtonTap: () {
        routerHandle(EnumSmartHomeAirBoxPageRoute.showSnackBar, data: SnackBarData('點擊設定'));
      },
      onDataRecordItemTap: () async {
        return Future.value(getAirBoxRecordPageRouterData);
      },
      onDataUpdate: () {
        return _generateRandomData();
      },
    );
  }

  AirQualityRecordPageRouterData get getAirBoxRecordPageRouterData {
    return AirQualityRecordPageRouterData(
      onDataFilterChanged: (EnumTimeFilter timeFilter, EnumAirQualityDataType dataType, DateTime selectedDate) async {
        return (chartData: _getChartData(timeFilter, dataType));
      },
      onHelpButtonTap: () async {
        return getAirBoxReferencePageRouterData;
      },
    );
  }

  EnumAirQualityDataType? get getAirBoxReferencePageRouterData {
    // 返回 null 表示使用預設類型，或可以返回特定類型
    return null;
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
          // 根據小時產生變化，加上隨機波動
          final hourFactor = hour / 23.0; // 0.0 到 1.0
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
          // 根據日期產生變化，加上隨機波動
          final dayFactor = day / daysInMonth; // 0.0 到 1.0
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
          // 根據月份產生變化，加上隨機波動
          final monthFactor = month / 12.0; // 0.0 到 1.0
          final baseValue = min + (monthFactor * range * 0.5) + (random.nextDouble() * range * 0.5);
          return ChartDataModel(
            date: date,
            number: baseValue.clamp(min, max),
          );
        });
    }
  }
}
