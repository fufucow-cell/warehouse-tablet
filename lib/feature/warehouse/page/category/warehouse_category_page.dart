import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/scaffold.dart';
import 'package:get/get.dart';

part 'warehouse_category_page_controller.dart';
part 'warehouse_category_page_interactive.dart';
part 'warehouse_category_page_model.dart';
part 'warehouse_category_page_route.dart';

class WarehouseCategoryPage extends GetView<WarehouseCategoryPageController> {
  const WarehouseCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseCategoryPageController>(
      init: WarehouseCategoryPageController(),
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
    // final controller = Get.find<WarehouseCategoryPageController>();

    return Center(
      child: Text(EnumWarehouseTabItem.category.title),
    );
  }
}
