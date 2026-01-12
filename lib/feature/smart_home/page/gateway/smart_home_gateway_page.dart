import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/smart_home/page/gateway/smart_home_gateway_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/text_widget.dart';
import 'package:flutter_smart_home_tablet/ui/cust_scaffold.dart';
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
