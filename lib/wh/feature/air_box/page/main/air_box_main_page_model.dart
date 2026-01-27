import 'package:engo_terminal_app3/wh/feature/air_box/page/record/air_box_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/reference/air_box_reference_page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirBoxMainPageModel {
  AirBoxMainPageRouterData? routerData;
  BuildContext? nestedNavigatorContext;
  final title = ''.obs;
  final pm25 = ''.obs;
  final pm25Status = ''.obs;
  final temperature = ''.obs;
  final humidity = ''.obs;
  final formaldehyde = ''.obs;
  final voc = ''.obs;
  final co2 = ''.obs;
}

class AirBoxMainPageRouterData {
  final String? language;
  final String? theme;
  final bool? isModuleMode;
  final String deviceName;
  final List<EnumAirBoxDataType> visibleDataTypes;
  final String? pm25;
  final String? pm25Status;
  final String? temperature;
  final String? humidity;
  final String? formaldehyde;
  final String? voc;
  final String? co2;
  final VoidCallback? onBackButtonTap;
  final Future<String?> Function(String oldName)? onEditButtonTap;
  final VoidCallback? onSettingButtonTap;
  final Future<AirBoxRecordPageRouterData> Function()? onDataRecordItemTap;
  final void Function(AirBoxDataModel data)? onDataUpdate;

  const AirBoxMainPageRouterData({
    this.language,
    this.theme,
    this.isModuleMode,
    required this.deviceName,
    required this.visibleDataTypes,
    this.pm25,
    this.pm25Status,
    this.temperature,
    this.humidity,
    this.formaldehyde,
    this.voc,
    this.co2,
    this.onBackButtonTap,
    this.onEditButtonTap,
    this.onSettingButtonTap,
    this.onDataRecordItemTap,
    this.onDataUpdate,
  });
}

class AirBoxDataModel {
  final String? pm25;
  final String? pm25Status;
  final String? temperature;
  final String? humidity;
  final String? formaldehyde;
  final String? voc;
  final String? co2;

  const AirBoxDataModel({
    this.pm25,
    this.pm25Status,
    this.temperature,
    this.humidity,
    this.formaldehyde,
    this.voc,
    this.co2,
  });
}
