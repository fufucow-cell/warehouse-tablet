import 'package:engo_terminal_app3/wh/feature/air_quality/page/reference/air_quality_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/service/air_quality_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'air_quality_reference_page_interactive.dart';
part 'air_quality_reference_page_route.dart';

class AirQualityReferencePageController extends GetxController {
  // MARK: - Properties

  final _model = AirQualityReferencePageModel();
  AirQualityService get _service => AirQualityService.instance;
  RxReadonly<EnumAirQualityDataType> get selectedDataTypeRx => _model.selectedDataType.readonly;

  // MARK: - Init

  AirQualityReferencePageController(EnumAirQualityDataType? type) {
    if (type != null) {
      _model.selectedDataType.value = type;
    }
  }

  // MARK: - Public Method

  void setContext(BuildContext context) {
    _service.setContext(context);
  }

  ReferenceStandard? getCurrentStandard() {
    final standards = EnumAirQualityDataType.getReferenceStandards();
    return standards.firstWhereOrNull(
      (standard) => standard.dataType == _model.selectedDataType.value,
    );
  }

  List<String> getDataTypeNames() {
    return EnumAirQualityDataType.values.map((type) {
      return switch (type) {
        EnumAirQualityDataType.pm25 => EnumLocale.airBoxPm25.tr,
        EnumAirQualityDataType.temperature => EnumLocale.airBoxRecordTabTemperature.tr,
        EnumAirQualityDataType.humidity => EnumLocale.airBoxRecordTabHumidity.tr,
        EnumAirQualityDataType.hcho => EnumLocale.airBoxHCHOValue.tr,
        EnumAirQualityDataType.voc => EnumLocale.airBoxVocValue.tr,
        EnumAirQualityDataType.co2 => EnumLocale.airBoxCo2Value.tr,
      };
    }).toList();
  }
}
