part of 'air_quality_reference_page_controller.dart';

enum EnumAirQualityReferencePageInteractive {
  tapBackButton,
  tapDataTypeDropdown,
}

extension AirQualityReferencePageInteractiveExtension on AirQualityReferencePageController {
  void interactive(EnumAirQualityReferencePageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumAirQualityReferencePageInteractive.tapBackButton:
        routerHandle(EnumAirQualityReferencePageRoute.goBack);
      case EnumAirQualityReferencePageInteractive.tapDataTypeDropdown:
        if (data is String) {
          final typeIndex = getDataTypeNames().indexOf(data);
          if (typeIndex >= 0 && typeIndex < EnumAirQualityDataType.values.length) {
            _model.selectedDataType.value = EnumAirQualityDataType.values[typeIndex];
            update();
          }
        }
    }
  }
}
