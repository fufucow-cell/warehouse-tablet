import 'package:engo_terminal_app3/wh/feature/air_box/page/reference/air_box_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'air_box_reference_page_interactive.dart';
part 'air_box_reference_page_route.dart';

class AirBoxReferencePageController extends GetxController {
  // MARK: - Properties

  final _model = AirBoxReferencePageModel();
  RxReadonly<EnumAirBoxDataType> get selectedDataTypeRx => _model.selectedDataType.readonly;
  String get deviceName => _model.routerData?.deviceName ?? '';

  // MARK: - Init

  AirBoxReferencePageController(AirBoxReferencePageRouterData routerData) {
    _model.routerData = routerData;
  }

  // MARK: - Public Method

  void setContext(BuildContext context) {
    _model.nestedNavigatorContext = context;
  }

  ReferenceStandard? getCurrentStandard() {
    final standards = EnumAirBoxDataType.getReferenceStandards();
    return standards.firstWhereOrNull(
      (standard) => standard.dataType == _model.selectedDataType.value,
    );
  }

  List<String> getDataTypeNames() {
    return EnumAirBoxDataType.values.map((type) {
      return switch (type) {
        EnumAirBoxDataType.pm25 => EnumLocale.airBoxPm25.tr,
        EnumAirBoxDataType.temperature => EnumLocale.airBoxRecordTabTemperature.tr,
        EnumAirBoxDataType.humidity => EnumLocale.airBoxRecordTabHumidity.tr,
        EnumAirBoxDataType.formaldehyde => EnumLocale.airBoxFormaldehydeValue.tr,
        EnumAirBoxDataType.voc => EnumLocale.airBoxVocValue.tr,
        EnumAirBoxDataType.co2 => EnumLocale.airBoxCo2Value.tr,
      };
    }).toList();
  }
}
