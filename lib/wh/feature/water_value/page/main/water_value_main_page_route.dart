part of 'water_value_main_page_controller.dart';

enum EnumWaterValueMainPageRoute {
  goToTimerListPage,
}

extension WaterValueMainPageRouteExtension on WaterValueMainPageController {
  Future<void> _routerHandle(EnumWaterValueMainPageRoute type) async {
    final context = _service.getNestedNavigatorContext;

    if (context == null) {
      return;
    }

    switch (type) {
      case EnumWaterValueMainPageRoute.goToTimerListPage:
        final routerData = await _model.routerData?.onTimerListButtonTap?.call();
        if (routerData == null) {
          return;
        }
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => WaterValueTimerListPage(routerData: routerData)),
        );
    }
  }
}
