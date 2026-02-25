import 'package:engo_terminal_app3/feature/smart_home/page/water_value/smart_home_water_value_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/main/water_value_main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmartHomeWaterValuePage extends GetView<SmartHomeWaterValuePageController> {
  const SmartHomeWaterValuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeWaterValuePageController>(
      init: SmartHomeWaterValuePageController(),
      builder: (controller) {
        controller.setContext(context);
        return WaterValueMainPage(routerData: controller.getWaterValueMainPageRouterData);
      },
    );
  }
}
