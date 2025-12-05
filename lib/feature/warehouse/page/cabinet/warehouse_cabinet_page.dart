import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:get/get.dart';

part 'warehouse_cabinet_page_controller.dart';
part 'warehouse_cabinet_page_interactive.dart';
part 'warehouse_cabinet_page_model.dart';
part 'warehouse_cabinet_page_route.dart';

class WarehouseCabinetPage extends GetView<WarehouseCabinetPageController> {
  const WarehouseCabinetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseCabinetPageController>(
      init: WarehouseCabinetPageController(),
      builder: (controller) {
        return _Body();
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<WarehouseCabinetPageController>();

    return Center(
      child: Text(EnumWarehouseTabItem.cabinet.title),
    );
  }
}
