import 'package:engo_terminal_app3/ui/cust_scaffold.dart';
import 'package:engo_terminal_app3/feature/smart_home/page/gateway/smart_home_gateway_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmartHomeGatewayPage extends GetView<SmartHomeGatewayPageController> {
  const SmartHomeGatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeGatewayPageController>(
      init: SmartHomeGatewayPageController(),
      builder: (controller) {
        return CustScaffold(
          title: EnumLocale.smartHomeTabGateway.tr,
          child: Center(child: CustTextWidget(EnumLocale.smartHomeTabGateway.tr)),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<SmartHomeGatewayPageController>();

    return Container();
  }
}
