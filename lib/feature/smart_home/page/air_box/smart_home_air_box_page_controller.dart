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

  SmartHomeAirBoxPageController();

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
      pm25: '5',
      pm25Status: '良好',
      temperature: '26.6',
      humidity: '60',
      formaldehyde: '0.02',
      voc: '0.3',
      co2: '0.05',
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
      onDataUpdate: (AirBoxDataModel data) {
        // 数据更新处理
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

  AirBoxReferencePageRouterData get getAirBoxReferencePageRouterData {
    return AirBoxReferencePageRouterData(
      deviceName: '中山區-臥室1',
      onBackButtonTap: () {
        final context = _model.context;
        if (context != null && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      onSettingButtonTap: () {
        routerHandle(EnumSmartHomeAirBoxPageRoute.showSnackBar, data: SnackBarData('點擊設定'));
      },
    );
  }

  List<ChartDataModel> _getChartData(EnumTimeFilter timeFilter, EnumAirBoxDataType dataType) {
    final random = Random();
    final now = DateTime.now();

    switch (timeFilter) {
      case EnumTimeFilter.day:
        return List.generate(24, (index) {
          final hour = index;
          final date = DateTime(now.year, now.month, now.day, hour);
          final baseValue = 20.0 + (hour * 2.0) + random.nextDouble() * 10.0;
          return ChartDataModel(
            date: date,
            number: baseValue.clamp(15.0, 35.0),
          );
        });
      case EnumTimeFilter.month:
        final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
        return List.generate(daysInMonth, (index) {
          final day = index + 1;
          final date = DateTime(now.year, now.month, day);
          final baseValue = 25.0 + random.nextDouble() * 10.0;
          return ChartDataModel(
            date: date,
            number: baseValue.clamp(20.0, 35.0),
          );
        });
      case EnumTimeFilter.year:
        return List.generate(12, (index) {
          final month = index + 1;
          final date = DateTime(now.year, month, 15);
          final baseValue = 25.0 + random.nextDouble() * 8.0;
          return ChartDataModel(
            date: date,
            number: baseValue.clamp(20.0, 33.0),
          );
        });
    }
  }
}
