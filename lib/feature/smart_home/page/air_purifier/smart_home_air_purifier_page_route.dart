part of 'smart_home_air_purifier_page_controller.dart';

enum EnumSmartHomeAirPurifierPageRoute {
  showSnackBar,
}

extension SmartHomeAirPurifierPageRouteExtension on SmartHomeAirPurifierPageController {
  void routerHandle(EnumSmartHomeAirPurifierPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeAirPurifierPageRoute.showSnackBar:
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
