import 'package:engo_terminal_app3/feature/smart_home/page/warehouse/smart_home_warehouse_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmartHomeWarehousePage extends GetView<SmartHomeWarehousePageController> {
  const SmartHomeWarehousePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeWarehousePageController>(
      init: SmartHomeWarehousePageController(),
      builder: (controller) {
        return WarehouseMainPage(
          routerData: controller.getWarehouseMainPageRouterData,
        );
      },
    );
  }
}
