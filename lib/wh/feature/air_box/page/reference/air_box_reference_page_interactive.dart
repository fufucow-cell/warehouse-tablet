part of 'air_box_reference_page_controller.dart';

enum EnumAirBoxReferencePageInteractive {
  tapBackButton,
  tapSettingButton,
  tapDataTypeDropdown,
}

extension AirBoxReferencePageInteractiveExtension on AirBoxReferencePageController {
  void interactive(EnumAirBoxReferencePageInteractive type, {dynamic data}) {
    final routerData = _model.routerData;
    if (routerData == null) return;

    switch (type) {
      case EnumAirBoxReferencePageInteractive.tapBackButton:
        routerData.onBackButtonTap?.call();
      case EnumAirBoxReferencePageInteractive.tapSettingButton:
        routerData.onSettingButtonTap?.call();
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
