import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/data_record/circuit_breaker_data_record_page.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/data_record/circuit_breaker_data_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/main/circuit_breaker_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/notification_record/circuit_breaker_notification_record_page.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/notification_record/circuit_breaker_notification_record_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/alert_setting/circuit_breaker_alert_setting_page.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/alert_setting/circuit_breaker_alert_setting_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/service/circuit_breaker_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'circuit_breaker_main_page_interactive.dart';
part 'circuit_breaker_main_page_route.dart';

class CircuitBreakerMainPageController extends GetxController {
  // MARK: - Properties

  final _model = CircuitBreakerMainPageModel();
  CircuitBreakerService get _service => CircuitBreakerService.instance;
  RxReadonly<bool> get isSwitchOnRx => _model.isSwitchOn.readonly;
  RxReadonly<String> get titleRx => _model.title.readonly;

  // MARK: - Init

  CircuitBreakerMainPageController(CircuitBreakerMainPageRouterData routerData) {
    _model.routerData = routerData;
    _model.title.value = routerData.circuitBreakerName;
    CircuitBreakerService.register().registerServices(routerData);
    _model.isSwitchOn.value = routerData.initialSwitchState;
  }

  @override
  void onClose() {
    CircuitBreakerService.unregister();
    super.onClose();
  }

  // MARK: - Public Method

  void setContext(BuildContext context) {
    CircuitBreakerService.instance.setContext(context);
  }

  String? getStatisticsValue(String type) {
    switch (type) {
      case 'currentTemperature':
        return _model.routerData?.currentTemperature;
      case 'cumulativePowerConsumption':
        return _model.routerData?.cumulativePowerConsumption;
      case 'todayPowerConsumption':
        return _model.routerData?.todayPowerConsumption;
      case 'power':
        return _model.routerData?.power;
      case 'voltage':
        return _model.routerData?.voltage;
      case 'current':
        return _model.routerData?.current;
      default:
        return null;
    }
  }
}
