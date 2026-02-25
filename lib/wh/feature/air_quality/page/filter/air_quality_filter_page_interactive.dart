part of 'air_quality_filter_page_controller.dart';

enum EnumAirQualityFilterPageInteractive {
  tapBackButton,
  tapEditButton,
  tapConfirmButton,
  tapCancelButton,
  tapResetButton,
}

extension AirQualityFilterPageUserEventExtension on AirQualityFilterPageController {
  Future<void> interactive(EnumAirQualityFilterPageInteractive type, {dynamic data}) async {
    _dismissKeyboard();

    switch (type) {
      case EnumAirQualityFilterPageInteractive.tapBackButton:
        await _routerHandle(EnumAirQualityFilterPageRoute.goBack);
      case EnumAirQualityFilterPageInteractive.tapEditButton:
        _model.tempLifeDays = _getCurrentLifeDays;
        _model.isEditing.value = true;
      case EnumAirQualityFilterPageInteractive.tapConfirmButton:
        _model.isEditing.value = false;
        _model.routerData?.onlifeDaysChanged(_getCurrentLifeDays);
      case EnumAirQualityFilterPageInteractive.tapCancelButton:
        _model.isEditing.value = false;
        _textController?.text = _model.tempLifeDays.toString();
      case EnumAirQualityFilterPageInteractive.tapResetButton:
        _model.isReset.value = true;
        _model.routerData?.onFilterReset();
    }
  }
}
