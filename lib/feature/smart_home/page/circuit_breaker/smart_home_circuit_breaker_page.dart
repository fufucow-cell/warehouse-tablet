import 'package:engo_terminal_app3/feature/smart_home/page/circuit_breaker/smart_home_circuit_breaker_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/main/circuit_breaker_main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmartHomeCircuitBreakerPage extends GetView<SmartHomeCircuitBreakerPageController> {
  const SmartHomeCircuitBreakerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeCircuitBreakerPageController>(
      init: SmartHomeCircuitBreakerPageController(),
      builder: (controller) {
        controller.setContext(context);
        return CircuitBreakerMainPage(routerData: controller.getCircuitBreakerMainPageRouterData);
      },
    );
  }
}
