part of 'circuit_breaker_alert_setting_page_controller.dart';

enum EnumCircuitBreakerAlertSettingPageRoute {
  goBack,
}

extension CircuitBreakerAlertSettingPageRouteExtension on CircuitBreakerAlertSettingPageController {
  void routerHandle(EnumCircuitBreakerAlertSettingPageRoute type, {dynamic data}) {
    final context = _service.getNestedNavigatorContext;

    if (context == null) {
      return;
    }

    switch (type) {
      case EnumCircuitBreakerAlertSettingPageRoute.goBack:
        Navigator.of(context).pop();
        break;
    }
  }
}
