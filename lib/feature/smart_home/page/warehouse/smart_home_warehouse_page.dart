import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/warehouse_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'smart_home_warehouse_page_controller.dart';
part 'smart_home_warehouse_page_interactive.dart';
part 'smart_home_warehouse_page_model.dart';
part 'smart_home_warehouse_page_route.dart';

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
