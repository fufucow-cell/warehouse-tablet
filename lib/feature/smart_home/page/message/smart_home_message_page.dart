import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/ui/cust_scaffold.dart';
import 'package:get/get.dart';

part 'smart_home_message_page_controller.dart';
part 'smart_home_message_page_interactive.dart';
part 'smart_home_message_page_model.dart';
part 'smart_home_message_page_route.dart';

class SmartHomeMessagePage
    extends GetView<SmartHomeMessagePageController> {
  const SmartHomeMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeMessagePageController>(
      init: SmartHomeMessagePageController(),
      builder: (controller) {
        return CustScaffold(
          title: EnumLocale.smartHomeTabMessage.tr,
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
    // final controller = Get.find<SmartHomeMessagePageController>();

    return Container();
  }
}
