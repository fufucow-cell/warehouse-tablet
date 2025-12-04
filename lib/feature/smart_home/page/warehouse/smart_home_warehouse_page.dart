import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/smart_home/page/warehouse/smart_home_warehouse_page_controller.dart';
import 'package:flutter_smart_home_tablet/ui/cust_scaffold.dart';
import 'package:get/get.dart';

class SmartHomeWarehousePage extends GetView<SmartHomeWarehousePageController> {
  const SmartHomeWarehousePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeWarehousePageController>(
      init: SmartHomeWarehousePageController(),
      builder: (controller) {
        return CustScaffold(
          title: '智能倉儲',
          showBackButton: false,
          child: _Body(),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<SmartHomeWarehousePageController>();

    return Container();
  }
}
