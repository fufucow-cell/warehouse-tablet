import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/constant/page_reference.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/data/user_data.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/scaffold.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/router.dart';
import 'package:get/get.dart';

part 'warehouse_main_page_controller.dart';
part 'warehouse_main_page_interactive.dart';
part 'warehouse_main_page_model.dart';
part 'warehouse_main_page_route.dart';

class WarehouseMainPage extends GetView<WarehouseMainPageController> {
  final WarehouseMainPageRouterData routerData;

  const WarehouseMainPage({
    super.key,
    required this.routerData,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseMainPageController>(
      init: WarehouseMainPageController(routerData),
      builder: (controller) {
        final isRoot = controller.isRootNavigator(context);
        final content = CustScaffold(
          child: _Body(),
        );

        if (isRoot) {
          // 如果是 root Navigator，创建新的嵌套 Navigator
          return Navigator(
            key: controller.navigatorKey,
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (_) => content,
              );
            },
          );
        } else {
          // 如果已经是 nested Navigator，直接返回内容
          return content;
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseMainPageController>();

    return Obx(() => controller.selectedItem.page);
  }
}
