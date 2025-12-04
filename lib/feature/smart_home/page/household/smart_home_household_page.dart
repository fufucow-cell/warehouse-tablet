import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/ui/cust_scaffold.dart';
import 'package:get/get.dart';

part 'smart_home_household_page_controller.dart';
part 'smart_home_household_page_interactive.dart';
part 'smart_home_household_page_model.dart';
part 'smart_home_household_page_route.dart';

class SmartHomeHouseholdPage extends GetView<SmartHomeHouseholdPageController> {
  const SmartHomeHouseholdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeHouseholdPageController>(
      init: SmartHomeHouseholdPageController(),
      builder: (controller) {
        return CustScaffold(
          title: '家庭',
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
    // final controller = Get.find<SmartHomeHouseholdPageController>();

    return Container();
  }
}
