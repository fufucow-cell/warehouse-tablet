import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog/dialog_create_cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog/dialog_search_alarm.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog/dialog_search_cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog/dialog_search_category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog/dialog_search_log.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/tab_bar.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/top_tool.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/page_reference.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_request_model/warehouse_cabinet_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_category_request_model/warehouse_category_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/warehouse_category_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/environment_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/temp_router_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_main_page_controller.dart';
part 'warehouse_main_page_interactive.dart';
part 'warehouse_main_page_model.dart';
part 'warehouse_main_page_route.dart';

class WarehouseMainPage extends StatefulWidget {
  final WarehouseMainPageRouterData routerData;

  const WarehouseMainPage({
    super.key,
    required this.routerData,
  });

  @override
  State<WarehouseMainPage> createState() => _WarehouseMainPageState();
}

class _WarehouseMainPageState extends State<WarehouseMainPage> with SingleTickerProviderStateMixin {
  late final WarehouseMainPageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WarehouseMainPageController(widget.routerData);
    _controller.initTabController(this);
  }

  @override
  void dispose() {
    _controller.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TempRouterUtil.getRootContext(context);

    return GetBuilder<WarehouseMainPageController>(
      init: _controller,
      builder: (controller) {
        return Obx(() {
          if (!controller.isTabControllerReady) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(94.0.scale),
                child: Container(
                  color: EnumColor.backgroundPrimary.color,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: (20.0 - (CustomTabBar.itemSpacing / 2)).scale,
                            right: (32.0 - (CustomTabBar.itemSpacing / 2)).scale,
                          ),
                          child: CustomTabBar(
                            controller: controller.tabController!,
                            tabs: controller.tabs,
                          ),
                        ),
                      ),
                      const TopTool(),
                    ],
                  ),
                ),
              ),
            ),
            body: Container(
              color: EnumColor.backgroundPrimary.color,
              child: TabBarView(
                controller: controller.tabController,
                children: controller.tabViews,
              ),
            ),
          );
        });
      },
    );
  }
}
