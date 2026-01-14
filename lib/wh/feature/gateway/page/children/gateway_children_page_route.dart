part of 'gateway_children_page_controller.dart';

enum EnumGatewayChildrenPageRoute {
  goBack,
  showDeviceManagementBottomSheet,
  closeBottomSheet,
}

extension GatewayChildrenPageRouteExtension on GatewayChildrenPageController {
  void routerHandle(EnumGatewayChildrenPageRoute type, {dynamic data}) {
    final context = _service.getNestedNavigatorContext;

    if (context != null) {
      switch (type) {
        case EnumGatewayChildrenPageRoute.showDeviceManagementBottomSheet:
          showModalBottomSheet(
            context: context,
            barrierColor: Colors.black.withOpacity(0.1),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            builder: (context) => const DeviceManagementBottomSheet(),
          );
        case EnumGatewayChildrenPageRoute.goBack:
        case EnumGatewayChildrenPageRoute.closeBottomSheet:
          Navigator.of(context).pop();
      }
    }
  }
}
