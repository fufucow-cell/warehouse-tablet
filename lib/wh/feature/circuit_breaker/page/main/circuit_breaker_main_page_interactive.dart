part of 'circuit_breaker_main_page_controller.dart';

enum EnumCircuitBreakerMainPageInteractive {
  tapBackButton,
  tapEditButton,
  tapSettingButton,
  tapSwitch,
  tapDataRecordItem,
  tapNotificationRecordItem,
  tapAlertSettingItem,
}

extension CircuitBreakerMainPageInteractiveExtension on CircuitBreakerMainPageController {
  void interactive(EnumCircuitBreakerMainPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumCircuitBreakerMainPageInteractive.tapBackButton:
        _model.routerData?.onBackButtonTap?.call();
      case EnumCircuitBreakerMainPageInteractive.tapEditButton:
        _model.routerData?.onEditButtonTap?.call(_model.routerData!.circuitBreakerName).then((newName) {
          _model.title.value = newName ?? '';
        });
      case EnumCircuitBreakerMainPageInteractive.tapSettingButton:
        _model.routerData?.onSettingButtonTap?.call();
      case EnumCircuitBreakerMainPageInteractive.tapSwitch:
        final newValue = !_model.isSwitchOn.value;
        _model.isSwitchOn.value = newValue;
        _model.routerData?.onSwitchToggle?.call(newValue);
      case EnumCircuitBreakerMainPageInteractive.tapDataRecordItem:
        _model.routerData?.onDataRecordItemTap?.call().then((routerData) {
          routerHandle(EnumCircuitBreakerMainPageRoute.goToDataRecordPage, data: routerData);
        });
      case EnumCircuitBreakerMainPageInteractive.tapNotificationRecordItem:
        _model.routerData?.onNotificationRecordItemTap?.call().then((routerData) {
          routerHandle(EnumCircuitBreakerMainPageRoute.goToNotificationRecordPage, data: routerData);
        });
      case EnumCircuitBreakerMainPageInteractive.tapAlertSettingItem:
        _model.routerData?.onAlertSettingItemTap?.call().then((routerData) {
          routerHandle(EnumCircuitBreakerMainPageRoute.goToAlertSettingPage, data: routerData);
        });
    }
  }
}
