import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/ui/cust_scaffold.dart';
import 'package:get/get.dart';

part 'smart_home_repair_page_controller.dart';
part 'smart_home_repair_page_interactive.dart';
part 'smart_home_repair_page_model.dart';
part 'smart_home_repair_page_route.dart';

class SmartHomeRepairPage extends GetView<SmartHomeRepairPageController> {
  const SmartHomeRepairPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeRepairPageController>(
      init: SmartHomeRepairPageController(),
      builder: (controller) {
        return CustScaffold(
          title: '報修',
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
    // final controller = Get.find<SmartHomeRepairPageController>();

    return Container();
  }
}
