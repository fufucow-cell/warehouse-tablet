import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/scaffold.dart';
import 'package:get/get.dart';

part 'warehouse_item_page_controller.dart';
part 'warehouse_item_page_interactive.dart';
part 'warehouse_item_page_model.dart';
part 'warehouse_item_page_route.dart';

class WarehouseItemPage extends GetView<WarehouseItemPageController> {
  const WarehouseItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseItemPageController>(
      init: WarehouseItemPageController(),
      builder: (controller) {
        return CustScaffold(
          child: _Body(),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<WarehouseItemPageController>();

    return Center(
      child: Text(EnumWarehouseTabItem.item.title),
    );
  }
}
