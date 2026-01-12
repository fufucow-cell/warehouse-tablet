part of 'smart_home_gateway_page_controller.dart';

enum EnumSmartHomeGatewayPageRoute {
  goOtherPage,
  showSomeDialog,
}

extension SmartHomeGatewayPageRouteExtension on SmartHomeGatewayPageController {
  void routerHandle(EnumSmartHomeGatewayPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeGatewayPageRoute.goOtherPage:
        break;
      case EnumSmartHomeGatewayPageRoute.showSomeDialog:
        break;
    }
  }
}