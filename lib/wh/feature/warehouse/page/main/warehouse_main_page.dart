import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/ui/tab_bar.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/ui/top_tool.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/warehouse_main_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/main/warehouse_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_shimmer_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _WarehouseMainPageState extends State<WarehouseMainPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<WarehouseMainPageController>()) {
      Get.put(WarehouseMainPageController(widget.routerData), permanent: false);
    }

    final controller = Get.find<WarehouseMainPageController>();
    controller.initTabController(this);
  }

  @override
  void dispose() {
    final controller = Get.find<WarehouseMainPageController>();
    controller.onClose();
    Get.delete<WarehouseMainPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseMainPageController>();
    controller.setContext(context);

    // 获取当前主题的亮度
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return Obx(() {
      if (!controller.isTabControllerReadyRx.value) {
        return _shimmerScaffold;
      }

      final tabBarView = TabBarView(
        controller: controller.tabController,
        children: controller.tabViews,
      );

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: EnumColor.backgroundPrimary.color,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: EnumColor.backgroundPrimary.color,
          systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        ),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: EnumColor.backgroundPrimary.color,
            elevation: 0,
          ),
          body: Column(
            children: [
              _TopBar(),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ColoredBox(
                        color: EnumColor.backgroundPrimary.color,
                      ),
                    ),
                    FirstBackgroundCard(
                      child: controller.isLoadingRx.value ? _shimmerContent : tabBarView,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget get _shimmerScaffold {
    return ShimmerWidget(
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
    return ShimmerWidget(
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

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseMainPageController>();
    return Container(
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
    );
  }
}
