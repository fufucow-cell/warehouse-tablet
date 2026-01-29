part of 'air_quality_filter_page_controller.dart';

enum EnumAirQualityFilterPageInteractive {
  tapBackButton,
  tapEditButton,
  tapConfirmButton,
  tapCancelButton,
  tapResetButton,
}

extension AirQualityFilterPageUserEventExtension on AirQualityFilterPageController {
  Future<void> _interactive(EnumAirQualityFilterPageInteractive type, {dynamic data}) async {
    switch (type) {
      case EnumAirQualityFilterPageInteractive.tapBackButton:
        await _routerHandle(EnumAirQualityFilterPageRoute.goBack);
      case EnumAirQualityFilterPageInteractive.tapEditButton:
        _model.startEditing();
        update();
      case EnumAirQualityFilterPageInteractive.tapConfirmButton:
        _model.confirmEditing();
        update();
      case EnumAirQualityFilterPageInteractive.tapCancelButton:
        _model.cancelEditing();
        update();
      case EnumAirQualityFilterPageInteractive.tapResetButton:
        _model.onReset();
    }
  }
}
