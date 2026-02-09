import 'package:engo_terminal_app3/feature/smart_home/page/air_purifier/smart_home_air_purifier_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/air_quality_purifier_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmartHomeAirPurifierPage extends GetView<SmartHomeAirPurifierPageController> {
  const SmartHomeAirPurifierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeAirPurifierPageController>(
      init: SmartHomeAirPurifierPageController(),
      builder: (controller) {
        controller.setContext(context);
        return AirQualityPurifierPage(routerData: controller.getAirPurifierPageRouterData);
      },
    );
  }
}
