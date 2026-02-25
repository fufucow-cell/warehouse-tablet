import 'package:engo_terminal_app3/feature/smart_home/page/air_box/smart_home_air_box_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/box/air_quality_box_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmartHomeAirBoxPage extends GetView<SmartHomeAirBoxPageController> {
  const SmartHomeAirBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeAirBoxPageController>(
      init: SmartHomeAirBoxPageController(),
      builder: (controller) {
        controller.setContext(context);
        return AirQualityBoxPage(routerData: controller.getAirBoxMainPageRouterData);
      },
    );
  }
}
