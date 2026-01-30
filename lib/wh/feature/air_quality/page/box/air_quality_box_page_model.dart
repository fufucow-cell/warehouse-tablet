import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/air_quality/page/record/air_quality_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/reference/air_quality_reference_page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirQualityBoxPageModel {
  AirQualityBoxPageRouterData? routerData;
  final title = ''.obs;
  final sensorData = Rxn<AirQualityDataItem>();
  Timer? dataUpdateTimer;
}

class AirQualityBoxPageRouterData {
  final String? language;
  final String? theme;
  final bool? isModuleMode;
  final String? roomName;
  final String deviceName;
  final List<EnumAirQualityDataType> visibleDataTypes;
  final VoidCallback onBackButtonTap;
  final Future<String?> Function(String oldName) onEditButtonTap;
  final VoidCallback onSettingButtonTap;
  final Future<AirQualityRecordPageRouterData> Function() onDataRecordItemTap;
  final AirQualityDataItem Function() onDataUpdate;

  const AirQualityBoxPageRouterData({
    this.language,
    this.theme,
    this.isModuleMode,
    required this.roomName,
    required this.deviceName,
    required this.visibleDataTypes,
    required this.onBackButtonTap,
    required this.onEditButtonTap,
    required this.onSettingButtonTap,
    required this.onDataRecordItemTap,
    required this.onDataUpdate,
  });
}

class AirQualityDataModel {
  final String? pm25;
  final String? pm25Status;
  final String? temperature;
  final String? humidity;
  final String? hcho;
  final String? voc;
  final String? co2;

  const AirQualityDataModel({
    this.pm25,
    this.pm25Status,
    this.temperature,
    this.humidity,
    this.hcho,
    this.voc,
    this.co2,
  });
}
