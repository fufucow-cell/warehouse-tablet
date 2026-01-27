part of 'air_box_main_page_controller.dart';

enum EnumAirBoxMainPageRoute {
  goToRecordPage,
}

extension AirBoxMainPageRouteExtension on AirBoxMainPageController {
  void _routerHandle(EnumAirBoxMainPageRoute type, {dynamic data}) {
    final context = _service.getNestedNavigatorContext;

    if (context == null) {
      return;
    }

    switch (type) {
      case EnumAirBoxMainPageRoute.goToRecordPage:
        if (data is AirBoxRecordPageRouterData) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AirBoxRecordPage(routerData: data),
            ),
          );
        }
    }
  }
}
