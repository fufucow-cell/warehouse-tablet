part of 'smart_home_gateway_page_controller.dart';

enum EnumSmartHomeGatewayPageRoute {
  showSnackBar,
}

extension SmartHomeGatewayPageRouteExtension on SmartHomeGatewayPageController {
  void routerHandle(EnumSmartHomeGatewayPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeGatewayPageRoute.showSnackBar:
        if (data is String) {
          CustSnackBar.show(
            context: _model.context,
            title: data,
          );
        }
    }
  }
}
