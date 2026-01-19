part of 'gateway_children_page_controller.dart';

enum EnumGatewayChildrenPageInteractive {
  tapBackButton,
  tapDeviceMoreButton,
  tapDeviceSwitchButton,
  tapDeviceManagementButton,
  tapScanQrCodeAdd,
  tapQuickAdd,
  tapCancelBottomSheet,
}

extension GatewayChildrenPageInteractiveExtension on GatewayChildrenPageController {
  void interactive(EnumGatewayChildrenPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumGatewayChildrenPageInteractive.tapBackButton:
        routerHandle(EnumGatewayChildrenPageRoute.goBack);
      case EnumGatewayChildrenPageInteractive.tapDeviceManagementButton:
        routerHandle(EnumGatewayChildrenPageRoute.showDeviceManagementBottomSheet);
      case EnumGatewayChildrenPageInteractive.tapScanQrCodeAdd:
        _model.routerData?.onGatewayScanQrCodeAddTap?.call();
      case EnumGatewayChildrenPageInteractive.tapQuickAdd:
        _model.routerData?.onGatewayQuickAddTap?.call();
      case EnumGatewayChildrenPageInteractive.tapDeviceMoreButton:
        _model.routerData?.onGatewayDeviceMoreButtonTap?.call(data as ChildDevice);
      case EnumGatewayChildrenPageInteractive.tapDeviceSwitchButton:
        if (data is ChildDevice) {
          _model.routerData?.onGatewayDeviceSwitchButtonTap?.call(data)?.then((value) {
            data.isSwitchOn = value;
            update();
          });
        }
      case EnumGatewayChildrenPageInteractive.tapCancelBottomSheet:
        routerHandle(EnumGatewayChildrenPageRoute.closeBottomSheet);
    }
  }
}
