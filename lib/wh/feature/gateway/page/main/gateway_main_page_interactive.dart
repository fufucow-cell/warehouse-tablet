part of 'gateway_main_page_controller.dart';

enum EnumGatewayMainPageInteractive {
  tapBackButton,
  tapEditButton,
  tapSettingButton,
  tapChildDevicesButton,
}

extension GatewayMainPageInteractiveExtension on GatewayMainPageController {
  void interactive(EnumGatewayMainPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumGatewayMainPageInteractive.tapBackButton:
        _model.routerData?.onGatewayBackButtonTap?.call();
      case EnumGatewayMainPageInteractive.tapEditButton:
        _model.routerData?.onGatewayEditButtonTap?.call(_model.gatewayName.value).then((newName) {
          if (newName != null) {
            _model.gatewayName.value = newName;
          }
        });
      case EnumGatewayMainPageInteractive.tapSettingButton:
        _model.routerData?.onGatewaySettingButtonTap?.call();
      case EnumGatewayMainPageInteractive.tapChildDevicesButton:
        _model.routerData?.onGatewayChildDevicesButtonTap?.call().then((routerData) {
          routerHandle(EnumGatewayMainPageRoute.goToChildrenPage, data: routerData);
        });
    }
  }
}
