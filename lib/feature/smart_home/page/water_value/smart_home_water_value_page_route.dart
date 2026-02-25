part of 'smart_home_water_value_page_controller.dart';

enum EnumSmartHomeWaterValuePageRoute {
  showSnackBar,
}

extension SmartHomeWaterValuePageRouteExtension on SmartHomeWaterValuePageController {
  void _routerHandle(
    EnumSmartHomeWaterValuePageRoute type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumSmartHomeWaterValuePageRoute.showSnackBar:
        final snackBarData = data as SnackBarData;
        CustSnackBar.show(
          title: snackBarData.title ?? '',
          message: snackBarData.message,
        );
    }
  }
}
