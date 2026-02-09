part of 'circuit_breaker_notification_record_page_controller.dart';

enum EnumCircuitBreakerNotificationRecordPageInteractive {
  tapTab,
}

extension CircuitBreakerNotificationRecordPageInteractiveExtension on CircuitBreakerNotificationRecordPageController {
  void interactive(EnumCircuitBreakerNotificationRecordPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumCircuitBreakerNotificationRecordPageInteractive.tapTab:
        if (data is EnumRecordType) {
          if (_model.selectedTab.value == data) {
            return;
          }

          _model.selectedTab.value = data;
          _fetchRecords();
        }
    }
  }
}
