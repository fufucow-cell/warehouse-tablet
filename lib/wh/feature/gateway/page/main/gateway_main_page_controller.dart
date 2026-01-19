import 'package:engo_terminal_app3/wh/feature/gateway/page/children/gateway_children_page.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/gateway_children_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/main/gateway_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/service/gateway_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'gateway_main_page_interactive.dart';
part 'gateway_main_page_route.dart';

class GatewayMainPageController extends GetxController {
  // MARK: - Properties

  final _model = GatewayMainPageModel();
  GatewayService get _service => GatewayService.instance;
  RxReadonly<String> get gatewayNameRx => _model.gatewayName.readonly;
  int get getDevicesCount => _model.routerData?.onlineDevicesCount ?? 0;

  // MARK: - Init

  GatewayMainPageController(GatewayMainPageRouterData routerData) {
    _model.routerData = routerData;
    GatewayService.register().registerServices(routerData);
    GatewayService.instance.registerServices(routerData);
  }

  @override
  void onClose() {
    GatewayService.unregister();
    super.onClose();
  }

  // MARK: - Public Method

  void setContext(BuildContext context) {
    GatewayService.instance.setContext(context);
  }
}
