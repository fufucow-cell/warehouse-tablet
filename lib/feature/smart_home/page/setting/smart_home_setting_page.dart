import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/ui/cust_scaffold.dart';
import 'package:get/get.dart';

part 'smart_home_setting_page_controller.dart';
part 'smart_home_setting_page_interactive.dart';
part 'smart_home_setting_page_model.dart';
part 'smart_home_setting_page_route.dart';

class SmartHomeSettingPage extends GetView<SmartHomeSettingPageController> {
  const SmartHomeSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeSettingPageController>(
      init: SmartHomeSettingPageController(),
      builder: (controller) {
        return CustScaffold(
          title: '設置',
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
    // final controller = Get.find<SmartHomeSettingPageController>();

    return Container();
  }
}
