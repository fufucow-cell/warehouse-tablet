part of 'water_value_main_page_controller.dart';

enum EnumWaterValueMainPageRoute {
  pop,
  goToTimerSettingPage,
  goToTimerListPage,
}

extension WaterValueMainPageRouteExtension on WaterValueMainPageController {
  void routerHandle(
    EnumWaterValueMainPageRoute type, {
    dynamic data,
  }) {
    final context = _service.getNestedNavigatorContext;

    if (context == null) {
      return;
    }

    switch (type) {
      case EnumWaterValueMainPageRoute.pop:
        Navigator.of(_service.getRootNavigatorContext ?? Get.context!).pop();
      case EnumWaterValueMainPageRoute.goToTimerSettingPage:
        if (data is WaterValueTimerSettingPageRouterData) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WaterValueTimerSettingPage(routerData: data),
            ),
          );
        }
      case EnumWaterValueMainPageRoute.goToTimerListPage:
        if (data is WaterValueTimerListPageRouterData) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WaterValueTimerListPage(routerData: data),
            ),
          );
        }
    }
  }
}
