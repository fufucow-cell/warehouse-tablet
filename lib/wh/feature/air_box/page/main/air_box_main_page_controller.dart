import 'dart:async';

import 'package:engo_terminal_app3/wh/feature/air_box/page/main/air_box_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/record/air_box_record_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/record/air_box_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/reference/air_box_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/service/air_box_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'air_box_main_page_interactive.dart';
part 'air_box_main_page_route.dart';

class AirBoxMainPageController extends GetxController {
  // MARK: - Properties

  final _model = AirBoxMainPageModel();
  AirBoxService get _service => AirBoxService.instance;
  RxReadonly<String> get titleRx => _model.title.readonly;
  RxReadonly<String> get pm25Rx => _model.pm25.readonly;
  RxReadonly<String> get pm25StatusRx => _model.pm25Status.readonly;
  RxReadonly<String> get temperatureRx => _model.temperature.readonly;
  RxReadonly<String> get humidityRx => _model.humidity.readonly;
  RxReadonly<String> get formaldehydeRx => _model.formaldehyde.readonly;
  RxReadonly<String> get vocRx => _model.voc.readonly;
  RxReadonly<String> get co2Rx => _model.co2.readonly;
  List<EnumAirBoxDataType> get visibleDataTypes => _model.routerData?.visibleDataTypes ?? [];

  // MARK: - Init

  AirBoxMainPageController(AirBoxMainPageRouterData routerData) {
    _model.routerData = routerData;
    AirBoxService.register().registerServices(routerData);
    _initData();
  }

  void _initData() {
    final routerData = _model.routerData;
    if (routerData == null) {
      return;
    }

    _model.title.value = routerData.deviceName;
    _listenSensorData(routerData);
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

  void updateData(AirBoxSensorDataModel data) {
    if (data.pm25 != null) {
      _model.pm25.value = data.pm25!;
    }
    if (data.temperature != null) {
      _model.temperature.value = data.temperature!;
    }
    if (data.humidity != null) {
      _model.humidity.value = data.humidity!;
    }
    if (data.formaldehyde != null) {
      _model.formaldehyde.value = data.formaldehyde!;
    }
    if (data.voc != null) {
      _model.voc.value = data.voc!;
    }
    if (data.co2 != null) {
      _model.co2.value = data.co2!;
    }
    update();
  }

  String getValueForDataType(EnumAirBoxDataType dataType) {
    final value = switch (dataType) {
      EnumAirBoxDataType.pm25 => _model.pm25.value,
      EnumAirBoxDataType.temperature => _model.temperature.value,
      EnumAirBoxDataType.humidity => _model.humidity.value,
      EnumAirBoxDataType.formaldehyde => _model.formaldehyde.value,
      EnumAirBoxDataType.voc => _model.voc.value,
      EnumAirBoxDataType.co2 => _model.co2.value,
    };

    if (value.isEmpty) {
      return '-';
    }

    return value;
  }

  // MARK: - Private Method

  void _listenSensorData(AirBoxMainPageRouterData routerData) {
    _model.dataUpdateTimer?.cancel();
    _model.dataUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final data = routerData.onDataUpdate();
      updateData(data);
    });
  }
}
