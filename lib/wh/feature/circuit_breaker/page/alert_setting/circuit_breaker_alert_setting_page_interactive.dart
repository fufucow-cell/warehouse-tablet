part of 'circuit_breaker_alert_setting_page_controller.dart';

enum EnumCircuitBreakerAlertSettingPageInteractive {
  tapRemoveDevice,
  tapAlertSwitch,
  tapCircuitSwitch,
}

extension CircuitBreakerAlertSettingPageInteractiveExtension on CircuitBreakerAlertSettingPageController {
  void interactive(EnumCircuitBreakerAlertSettingPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumCircuitBreakerAlertSettingPageInteractive.tapRemoveDevice:
        _model.routerData?.onRemoveDevice?.call();
      case EnumCircuitBreakerAlertSettingPageInteractive.tapAlertSwitch:
        if (data is AlertSettingModel) {
          data.onAlertSwitchChanged(data.alertStatus);
          update();
        }
      case EnumCircuitBreakerAlertSettingPageInteractive.tapCircuitSwitch:
        if (data is AlertSettingModel) {
          data.onCircuitSwitchChanged(data.circuitStatus);
          update();
        }
    }
  }
}
