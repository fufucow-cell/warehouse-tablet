part of 'air_quality_box_page_controller.dart';

enum EnumAirQualityBoxPageRoute {
  goToRecordPage,
}

extension AirQualityBoxPageRouteExtension on AirQualityBoxPageController {
  void _routerHandle(EnumAirQualityBoxPageRoute type, {dynamic data}) {
    final context = _service.getNestedNavigatorContext;

    if (context == null) {
      return;
    }

    switch (type) {
      case EnumAirQualityBoxPageRoute.goToRecordPage:
        if (data is AirQualityRecordPageRouterData) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AirQualityRecordPage(routerData: data),
            ),
          );
        }
    }
  }
}
