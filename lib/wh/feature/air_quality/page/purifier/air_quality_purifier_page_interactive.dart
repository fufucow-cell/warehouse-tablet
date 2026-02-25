part of 'air_quality_purifier_page_controller.dart';

enum EnumAirQualityPurifierPageInteractive {
  tapBackButton,
  tapEditButton,
  tapSettingButton,
  tapDataButton,
  tapPowerButton,
  tapFilterLife,
  tapModeButton,
  tapFanSpeedButton,
  tapTimerButton,
  tapModeOption,
  tapFanSpeedOption,
  tapTimerConfirm,
  tapTimerClean,
  tapPopupOutside,
}

extension AirQualityPurifierPageInteractiveExtension on AirQualityPurifierPageController {
  void interactive(EnumAirQualityPurifierPageInteractive type, {dynamic data}) {
    final routerData = _model.routerData;
    if (routerData == null) {
      return;
    }

    switch (type) {
      case EnumAirQualityPurifierPageInteractive.tapBackButton:
        routerData.onBackButtonTap();
      case EnumAirQualityPurifierPageInteractive.tapEditButton:
        routerData.onEditButtonTap(_model.title.value).then((newName) {
          if (newName != null) {
            _model.title.value = newName;
            update();
          }
        });
      case EnumAirQualityPurifierPageInteractive.tapSettingButton:
        routerData.onSettingButtonTap();
      case EnumAirQualityPurifierPageInteractive.tapDataButton:
        final onDataRecordButtonTap = routerData.onDataRecordButtonTap;
        if (onDataRecordButtonTap != null) {
          final future = onDataRecordButtonTap();
          if (future != null) {
            future.then((recordRouterData) {
              _routerHandle(EnumAirQualityPurifierPageRoute.goToRecordPage, data: recordRouterData);
            });
          }
        }
      case EnumAirQualityPurifierPageInteractive.tapPowerButton:
        final newState = (data is bool) ? data : !_model.isOn.value;
        routerData.onPowerToggle(newState);
        _model.isOn.value = newState;

        if (!newState) {
          _turnOff();
          _routerHandle(EnumAirQualityPurifierPageRoute.closePopup);
        } else {
          _startSensorUpdate();
        }
      case EnumAirQualityPurifierPageInteractive.tapFilterLife:
        final onFilterButtonTap = routerData.onFilterButtonTap;
        if (onFilterButtonTap != null) {
          final future = onFilterButtonTap();
          if (future != null) {
            future.then((filterRouterData) {
              _routerHandle(EnumAirQualityPurifierPageRoute.goToFilterPage, data: filterRouterData);
            });
          }
        }
      case EnumAirQualityPurifierPageInteractive.tapModeButton:
        _routerHandle(EnumAirQualityPurifierPageRoute.showModePopup);
      case EnumAirQualityPurifierPageInteractive.tapFanSpeedButton:
        _routerHandle(EnumAirQualityPurifierPageRoute.showFanSpeedPopup);
      case EnumAirQualityPurifierPageInteractive.tapTimerButton:
        _routerHandle(EnumAirQualityPurifierPageRoute.showTimerPopup);
      case EnumAirQualityPurifierPageInteractive.tapModeOption:
        if (data is EnumPurifierMode) {
          _model.currentMode.value = data;
          _routerHandle(EnumAirQualityPurifierPageRoute.closePopup);
        }
      case EnumAirQualityPurifierPageInteractive.tapFanSpeedOption:
        if (data is EnumPurifierFanSpeed) {
          _model.currentFanSpeed.value = data;
          routerData.onFanSpeedChanged(data);
          _routerHandle(EnumAirQualityPurifierPageRoute.closePopup);
        }
      case EnumAirQualityPurifierPageInteractive.tapTimerConfirm:
        if (data is int) {
          final minutes = data * 60;
          _model.timerMinutes.value = minutes;
          routerData.onTimerChanged(minutes);
          _startTimeCounter();
          _routerHandle(EnumAirQualityPurifierPageRoute.closePopup);
        }
      case EnumAirQualityPurifierPageInteractive.tapTimerClean:
        _model.timerMinutes.value = 0;
        routerData.onTimerChanged(0);
        _routerHandle(EnumAirQualityPurifierPageRoute.closePopup);
      case EnumAirQualityPurifierPageInteractive.tapPopupOutside:
        _routerHandle(EnumAirQualityPurifierPageRoute.closePopup);
    }
  }
}
