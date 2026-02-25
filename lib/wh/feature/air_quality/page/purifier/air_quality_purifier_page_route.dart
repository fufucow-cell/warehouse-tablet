part of 'air_quality_purifier_page_controller.dart';

enum EnumAirQualityPurifierPageRoute {
  goToFilterPage,
  goToRecordPage,
  showModePopup,
  showFanSpeedPopup,
  showTimerPopup,
  closePopup,
}

extension AirQualityPurifierPageRouteExtension on AirQualityPurifierPageController {
  void _routerHandle(EnumAirQualityPurifierPageRoute type, {dynamic data}) {
    final context = _service.getNestedNavigatorContext;

    if (context == null) {
      return;
    }

    switch (type) {
      case EnumAirQualityPurifierPageRoute.goToFilterPage:
        if (data is AirQualityFilterPageRouterData) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AirQualityFilterPage(routerData: data),
            ),
          );
        }
      case EnumAirQualityPurifierPageRoute.goToRecordPage:
        if (data is AirQualityRecordPageRouterData) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AirQualityRecordPage(routerData: data),
            ),
          );
        }
      case EnumAirQualityPurifierPageRoute.closePopup:
      case EnumAirQualityPurifierPageRoute.showModePopup:
      case EnumAirQualityPurifierPageRoute.showFanSpeedPopup:
      case EnumAirQualityPurifierPageRoute.showTimerPopup:
        _showPopup(type);
    }
  }

  void _showPopup(EnumAirQualityPurifierPageRoute? type) {
    final newType = _model.isOn.value ? type : null;
    _model.showModePopup.value = (newType == EnumAirQualityPurifierPageRoute.showModePopup);
    _model.showFanSpeedPopup.value = (newType == EnumAirQualityPurifierPageRoute.showFanSpeedPopup);
    if (newType == EnumAirQualityPurifierPageRoute.showTimerPopup) {
      _model.timerMinutesWhenPopupOpened = _model.timerMinutes.value;
    }
    _model.showTimerPopup.value = (newType == EnumAirQualityPurifierPageRoute.showTimerPopup);
  }
}
