part of 'smart_home_circuit_breaker_page_controller.dart';

enum EnumSmartHomeCircuitBreakerPageInteractive {
  placeholder, // 占位符，可根據需要添加實際的交互事件
}

extension SmartHomeCircuitBreakerPageInteractiveExtension on SmartHomeCircuitBreakerPageController {
  void interactive(EnumSmartHomeCircuitBreakerPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeCircuitBreakerPageInteractive.placeholder:
        // 可以添加交互處理
        break;
    }
  }
}
