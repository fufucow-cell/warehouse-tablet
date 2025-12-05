import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:get/get.dart';

part 'warehouse_alarm_page_controller.dart';
part 'warehouse_alarm_page_interactive.dart';
part 'warehouse_alarm_page_model.dart';
part 'warehouse_alarm_page_route.dart';

class WarehouseAlarmPage extends GetView<WarehouseAlarmPageController> {
  const WarehouseAlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseAlarmPageController>(
      init: WarehouseAlarmPageController(),
      builder: (controller) {
        return _Body();
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<WarehouseAlarmPageController>();

    return Center(
      child: Text(EnumWarehouseTabItem.alarm.title),
    );
  }
}
