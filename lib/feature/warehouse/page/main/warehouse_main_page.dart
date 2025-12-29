import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/tab_bar.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/top_tool.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/first_background_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class WarehouseMainPage extends StatefulWidget {
  final WarehouseMainPageRouterData routerData;

  const WarehouseMainPage({
    super.key,
    required this.routerData,
  });

  @override
  State<WarehouseMainPage> createState() => _WarehouseMainPageState();
}

class _WarehouseMainPageState extends State<WarehouseMainPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<WarehouseMainPageController>()) {
      Get.put(WarehouseMainPageController(), permanent: false);
    }

    final controller = Get.find<WarehouseMainPageController>();
    controller.setRouterData(widget.routerData);
    controller.initTabController(this);
  }

  @override
  void dispose() {
    final controller = Get.find<WarehouseMainPageController>();
    controller.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseMainPageController>();
    controller.setRootContext(context);

    return Obx(() {
      if (!controller.isTabControllerReadyRx.value) {
        return _shimmerScaffold;
      }

      final tabBarView = TabBarView(
        controller: controller.tabController,
        children: controller.tabViews,
      );

      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(94.0.scale),
            child: Container(
              color: EnumColor.backgroundPrimary.color,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0.scale),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTabBar(
                        controller: controller.tabController!,
                        tabs: controller.tabs,
                      ),
                    ),
                    const TopTool(),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: ColoredBox(
                color: EnumColor.backgroundPrimary.color,
              ),
            ),
            FirstBackgroundCard(
              child:
                  controller.isLoadingRx.value ? _shimmerContent : tabBarView,
            ),
          ],
        ),
      );
    });
  }

  Widget get _shimmerScaffold {
    return WidgetUtil.shimmerWidget(
      child: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0.scale),
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.0.scale),
              height: 94.0.scale,
            ),
            SizedBox(height: 10.0.scale),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0.scale),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10.0.scale),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _shimmerContent {
    return WidgetUtil.shimmerWidget(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0.scale),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.0.scale),
      ),
    );
  }
}
