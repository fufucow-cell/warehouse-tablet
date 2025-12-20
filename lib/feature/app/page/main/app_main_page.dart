import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/constant/root_router_constant.dart';
import 'package:flutter_smart_home_tablet/feature/app/page/main/app_main_router_constant.dart';
import 'package:flutter_smart_home_tablet/feature/app/page/main/app_main_router_util.dart';
import 'package:flutter_smart_home_tablet/feature/smart_home/service/smart_home_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/storage_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/storage_util.dart';
import 'package:flutter_smart_home_tablet/ui/cust_dialog.dart';
import 'package:flutter_smart_home_tablet/util/api_util.dart';
import 'package:get/get.dart';

part 'app_main_page_controller.dart';
part 'app_main_page_interactive.dart';
part 'app_main_page_model.dart';
part 'app_main_page_route.dart';

class AppMainPage extends GetView<AppMainPageController> {
  const AppMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppMainPageController>(
      init: AppMainPageController(),
      builder: (controller) {
        return const Scaffold(
          body: Row(
            children: [
              _LeftMenuWidget(),
              VerticalDivider(width: 1),
              Expanded(child: _RightContentWidget()),
            ],
          ),
        );
      },
    );
  }
}

class _LeftMenuWidget extends StatelessWidget {
  const _LeftMenuWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Theme.of(context).colorScheme.surface,
      child: const Column(
        children: [
          _TitleWidget(),
          Expanded(child: _TabListWidget()),
          _LogoutButton(),
        ],
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppMainPageController>();

    return GestureDetector(
      onTap: () => controller.interactive(
        EnumAppMainPageInteractive.tapTitleWidget,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0.scale),
        child: EnumImage.tCow.image(
            size: Size.square(200.0.scale),
            color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
  }
}

class _TabListWidget extends StatelessWidget {
  const _TabListWidget();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppMainPageController>();
    return Obx(() {
      return ListView(
        padding: EdgeInsets.zero,
        children: EnumAppMainTabItem.values.map((item) {
          final isSelected = controller.getSelectedItem == item;
          return ListTile(
            selected: isSelected,
            leading: Icon(
              item.icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              item.title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            onTap: () => controller.interactive(
              EnumAppMainPageInteractive.selectItem,
              data: item,
            ),
          );
        }).toList(),
      );
    });
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppMainPageController>();

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        leading: Icon(
          Icons.logout,
          color: Theme.of(context).colorScheme.error,
        ),
        title: Text(
          EnumLocale.logoutButton.tr,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        onTap: () => controller.interactive(
          EnumAppMainPageInteractive.tapLogout,
        ),
      ),
    );
  }
}

class _RightContentWidget extends StatelessWidget {
  const _RightContentWidget();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppMainPageController>();

    return Navigator(
      key: controller.getNavigatorKey,
      initialRoute: controller.getInitRoutePath,
      onGenerateRoute: controller.generateRoute,
      observers: [controller.getRouterUtil],
    );
  }
}
