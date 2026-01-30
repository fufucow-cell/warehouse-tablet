import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/air_quality/page/box/air_quality_box_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/record/air_quality_record_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/record/air_quality_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/reference/air_quality_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/service/air_quality_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'air_quality_box_page_interactive.dart';
part 'air_quality_box_page_route.dart';

class AirQualityBoxPageController extends GetxController {
  // MARK: - Properties

  final _model = AirQualityBoxPageModel();
  AirQualityService get _service => AirQualityService.instance;
  RxReadonly<String> get titleRx => _model.title.readonly;
  RxReadonly<AirQualityDataItem?> get sensorDataRx => _model.sensorData.readonly;
  String get roomName => _model.routerData?.roomName ?? '';
  List<EnumAirQualityDataType> get visibleDataTypes => _model.routerData?.visibleDataTypes ?? [];

  // MARK: - Init

  AirQualityBoxPageController(AirQualityBoxPageRouterData routerData) {
    _model.routerData = routerData;
    _model.title.value = routerData.deviceName;
    AirQualityService.register().registerServices(routerData);
    _listenSensorData();
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
    final sensorData = sensorDataRx.value;

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

  // MARK: - Private Method

  void _listenSensorData() {
    _model.dataUpdateTimer?.cancel();
    _model.dataUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _model.sensorData.value = _model.routerData?.onDataUpdate();
    });
  }
}
