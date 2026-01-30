part of 'air_quality_reference_page_controller.dart';

enum EnumAirQualityReferencePageRoute {
  goBack,
}

extension AirQualityReferencePageRouteExtension on AirQualityReferencePageController {
  void routerHandle(EnumAirQualityReferencePageRoute type, {dynamic data}) {
    switch (type) {
      case EnumAirQualityReferencePageRoute.goBack:
        final context = _service.getNestedNavigatorContext;
        if (context != null && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
    }
  }
}
