import 'package:engo_terminal_app3/feature/smart_home/page/gateway/smart_home_gateway_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/main/gateway_main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmartHomeGatewayPage extends GetView<SmartHomeGatewayPageController> {
  const SmartHomeGatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeGatewayPageController>(
      init: SmartHomeGatewayPageController(),
      builder: (controller) {
        controller.setContext(context);
        return GatewayMainPage(routerData: controller.getGatewayMainPageRouterData);
      },
    );
  }
}
