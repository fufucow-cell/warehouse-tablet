part of 'air_quality_filter_page_controller.dart';

enum EnumAirQualityFilterPageRoute {
  goBack,
}

extension AirQualityFilterPageRouteExtension on AirQualityFilterPageController {
  Future<void> _routerHandle(EnumAirQualityFilterPageRoute type, {dynamic data}) async {
    switch (type) {
      case EnumAirQualityFilterPageRoute.goBack:
        Navigator.of(_service.getNestedNavigatorContext!).pop();
    }
  }
}
