part of 'water_value_timer_list_page_controller.dart';

enum EnumWaterValueTimerListPageRoute {
  pop,
  goToTimerSettingPage,
}

extension WaterValueTimerListPageRouteExtension on WaterValueTimerListPageController {
  void routerHandle(
    EnumWaterValueTimerListPageRoute type, {
    dynamic data,
  }) {
    final context = _service.getNestedNavigatorContext;

    if (context == null) {
      return;
    }

    switch (type) {
      case EnumWaterValueTimerListPageRoute.pop:
        Navigator.of(_service.getRootNavigatorContext ?? Get.context!).pop();
      case EnumWaterValueTimerListPageRoute.goToTimerSettingPage:
        if (data is WaterValueTimerSettingPageRouterData) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WaterValueTimerSettingPage(routerData: data),
            ),
          );
        }
    }
  }
}
