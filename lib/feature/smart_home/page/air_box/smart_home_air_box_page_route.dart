part of 'smart_home_air_box_page_controller.dart';

enum EnumSmartHomeAirBoxPageRoute {
  showSnackBar,
}

extension SmartHomeAirBoxPageRouteExtension on SmartHomeAirBoxPageController {
  void routerHandle(EnumSmartHomeAirBoxPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeAirBoxPageRoute.showSnackBar:
        if (data is SnackBarData) {
          CustSnackBar.show(
            context: _model.context!,
            title: data.title,
            message: data.message,
          );
        }
    }
  }
}
