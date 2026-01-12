part of 'smart_home_gateway_page_controller.dart';

enum EnumSmartHomeGatewayPageInteractive {
  tapSomeWidget,
}

extension SmartHomeGatewayPageUserEventExtension on SmartHomeGatewayPageController {
  void interactive(EnumSmartHomeGatewayPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumSmartHomeGatewayPageInteractive.tapSomeWidget:
        break;
    }
  }
}