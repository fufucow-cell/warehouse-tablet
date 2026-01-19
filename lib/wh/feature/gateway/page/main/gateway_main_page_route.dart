part of 'gateway_main_page_controller.dart';

enum EnumGatewayMainPageRoute {
  goToChildrenPage,
}

extension GatewayMainPageRouteExtension on GatewayMainPageController {
  void routerHandle(EnumGatewayMainPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumGatewayMainPageRoute.goToChildrenPage:
        final context = _service.getNestedNavigatorContext;
        if (context != null && data is GatewayChildrenPageRouterData) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GatewayChildrenPage(routerData: data),
            ),
          );
        }
    }
  }
}
