part of 'circuit_breaker_main_page_controller.dart';

enum EnumCircuitBreakerMainPageRoute {
  goToDataRecordPage,
  goToNotificationRecordPage,
  goToAlertSettingPage,
}

extension CircuitBreakerMainPageRouteExtension on CircuitBreakerMainPageController {
  void routerHandle(EnumCircuitBreakerMainPageRoute type, {dynamic data}) {
    final context = _service.getNestedNavigatorContext;

    if (context == null) {
      return;
    }

    switch (type) {
      case EnumCircuitBreakerMainPageRoute.goToDataRecordPage:
        if (data is CircuitBreakerDataRecordPageRouterData) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CircuitBreakerDataRecordPage(routerData: data),
            ),
          );
        }
      case EnumCircuitBreakerMainPageRoute.goToNotificationRecordPage:
        if (data is CircuitBreakerNotificationRecordPageRouterData) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CircuitBreakerNotificationRecordPage(routerData: data),
            ),
          );
        }
      case EnumCircuitBreakerMainPageRoute.goToAlertSettingPage:
        if (data is CircuitBreakerAlertSettingPageRouterData) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CircuitBreakerAlertSettingPage(routerData: data),
            ),
          );
        }
    }
  }
}
