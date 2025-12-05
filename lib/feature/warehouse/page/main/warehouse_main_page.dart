import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/constant/page_reference.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_main_page_controller.dart';
part 'warehouse_main_page_interactive.dart';
part 'warehouse_main_page_model.dart';
part 'warehouse_main_page_route.dart';

class WarehouseMainPage
    extends GetView<WarehouseMainPageController> {
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
        return Scaffold(
          appBar: AppBar(
            backgroundColor:
                Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: const Text('智能倉庫'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                color: Colors.white,
                child: TabBar(
                  controller: controller.tabController,
                  tabs: controller.tabs,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black54,
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  indicatorColor: Colors.black,
                ),
              ),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: TabBarView(
              controller: controller.tabController,
              children: controller.tabViews,
            ),
          ),
        );
      },
    );
  }
}
