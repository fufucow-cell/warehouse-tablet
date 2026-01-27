part of 'air_box_reference_page_controller.dart';

enum EnumAirBoxReferencePageInteractive {
  tapBackButton,
  tapDataTypeDropdown,
}

extension AirBoxReferencePageInteractiveExtension on AirBoxReferencePageController {
  void interactive(EnumAirBoxReferencePageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumAirBoxReferencePageInteractive.tapBackButton:
        routerHandle(EnumAirBoxReferencePageRoute.goBack);
      case EnumAirBoxReferencePageInteractive.tapDataTypeDropdown:
        if (data is String) {
          final typeIndex = getDataTypeNames().indexOf(data);
          if (typeIndex >= 0 && typeIndex < EnumAirBoxDataType.values.length) {
            _model.selectedDataType.value = EnumAirBoxDataType.values[typeIndex];
            update();
          }
        }
    }
  }
}
