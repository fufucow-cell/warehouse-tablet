import 'dart:math';

import 'package:engo_terminal_app3/feature/smart_home/page/air_box/smart_home_air_box_page_model.dart';
import 'package:engo_terminal_app3/feature/smart_home/service/smart_home_service.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/main/air_box_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/record/air_box_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/reference/air_box_reference_page_model.dart';
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

  AirBoxSensorDataModel _generateRandomData() {
    double generateValue(EnumAirBoxDataType dataType) {
      final min = dataType.defaultMin;
      final max = dataType.defaultMax;
      return min + _random.nextDouble() * (max - min);
    }

    String formatValue(EnumAirBoxDataType dataType, double value) {
      if (dataType.isIntegerType) {
        return value.toInt().toString();
      } else {
        // 根據不同類型決定小數位數
        return switch (dataType) {
          EnumAirBoxDataType.formaldehyde => value.toStringAsFixed(3),
          EnumAirBoxDataType.voc => value.toStringAsFixed(2),
          EnumAirBoxDataType.co2 => value.toStringAsFixed(3),
          _ => value.toStringAsFixed(1),
        };
      }
    }

    return AirBoxSensorDataModel(
      pm25: formatValue(EnumAirBoxDataType.pm25, generateValue(EnumAirBoxDataType.pm25)),
      temperature: formatValue(EnumAirBoxDataType.temperature, generateValue(EnumAirBoxDataType.temperature)),
      humidity: formatValue(EnumAirBoxDataType.humidity, generateValue(EnumAirBoxDataType.humidity)),
      formaldehyde: formatValue(EnumAirBoxDataType.formaldehyde, generateValue(EnumAirBoxDataType.formaldehyde)),
      voc: formatValue(EnumAirBoxDataType.voc, generateValue(EnumAirBoxDataType.voc)),
      co2: formatValue(EnumAirBoxDataType.co2, generateValue(EnumAirBoxDataType.co2)),
    );
  }

  void setContext(BuildContext context) {
    _model.context = context;
  }

  AirBoxMainPageRouterData get getAirBoxMainPageRouterData {
    return AirBoxMainPageRouterData(
      language: _service.getCurrentLocaleCode,
      theme: _service.getCurrentThemeName,
      isModuleMode: false,
      deviceName: '空氣盒',
      visibleDataTypes: [
        EnumAirBoxDataType.pm25,
        EnumAirBoxDataType.temperature,
        EnumAirBoxDataType.humidity,
        EnumAirBoxDataType.formaldehyde,
        EnumAirBoxDataType.voc,
        EnumAirBoxDataType.co2,
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

  AirBoxRecordPageRouterData get getAirBoxRecordPageRouterData {
    return AirBoxRecordPageRouterData(
      onDataFilterChanged: (EnumTimeFilter timeFilter, EnumAirBoxDataType dataType, DateTime selectedDate) async {
        return (chartData: _getChartData(timeFilter, dataType));
      },
      onHelpButtonTap: () async {
        return getAirBoxReferencePageRouterData;
      },
    );
  }

  EnumAirBoxDataType? get getAirBoxReferencePageRouterData {
    // 返回 null 表示使用預設類型，或可以返回特定類型
    return null;
  }

  List<ChartDataModel> _getChartData(EnumTimeFilter timeFilter, EnumAirBoxDataType dataType) {
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
