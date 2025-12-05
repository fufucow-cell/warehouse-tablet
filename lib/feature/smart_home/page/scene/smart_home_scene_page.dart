import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/ui/cust_scaffold.dart';
import 'package:get/get.dart';

part 'smart_home_scene_page_controller.dart';
part 'smart_home_scene_page_interactive.dart';
part 'smart_home_scene_page_model.dart';
part 'smart_home_scene_page_route.dart';

class SmartHomeScenePage extends GetView<SmartHomeScenePageController> {
  const SmartHomeScenePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeScenePageController>(
      init: SmartHomeScenePageController(),
      builder: (controller) {
        return CustScaffold(
          title: '場景',
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
    // final controller = Get.find<SmartHomeScenePageController>();

    return Container();
  }
}
