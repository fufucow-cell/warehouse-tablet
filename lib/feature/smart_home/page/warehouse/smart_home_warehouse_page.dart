import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/smart_home/service/smart_home_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/locale_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/theme_util.dart';
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
          routerData: controller.getWarehouseMainPageRouterData(),
        );
      },
    );
  }
}
