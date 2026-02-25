part of 'circuit_breaker_notification_record_page_controller.dart';

enum EnumCircuitBreakerNotificationRecordPageRoute {
  goBack,
}

extension CircuitBreakerNotificationRecordPageRouteExtension on CircuitBreakerNotificationRecordPageController {
  void routerHandle(EnumCircuitBreakerNotificationRecordPageRoute type, {dynamic data}) {
    final context = _service.getNestedNavigatorContext;

    if (context == null) {
      return;
    }

    switch (type) {
      case EnumCircuitBreakerNotificationRecordPageRoute.goBack:
        Navigator.of(context).pop();
        break;
    }
  }
}
