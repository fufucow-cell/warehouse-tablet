part of 'smart_home_circuit_breaker_page_controller.dart';

enum EnumSmartHomeCircuitBreakerPageRoute {
  showSnackBar,
}

extension SmartHomeCircuitBreakerPageRouteExtension on SmartHomeCircuitBreakerPageController {
  void routerHandle(EnumSmartHomeCircuitBreakerPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeCircuitBreakerPageRoute.showSnackBar:
        if (data is SnackBarData) {
          CustSnackBar.show(
            context: _model.context!,
            title: data.title,
            message: data.message,
          );
        }
    }
  }
}
