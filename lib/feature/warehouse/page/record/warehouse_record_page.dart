import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/scaffold.dart';
import 'package:get/get.dart';

part 'warehouse_record_page_controller.dart';
part 'warehouse_record_page_interactive.dart';
part 'warehouse_record_page_model.dart';
part 'warehouse_record_page_route.dart';

class WarehouseRecordPage extends GetView<WarehouseRecordPageController> {
  const WarehouseRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseRecordPageController>(
      init: WarehouseRecordPageController(),
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
    // final controller = Get.find<WarehouseRecordPageController>();

    return Center(
      child: Text(EnumWarehouseTabItem.record.title),
    );
  }
}
