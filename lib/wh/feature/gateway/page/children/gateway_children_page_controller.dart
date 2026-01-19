import 'package:engo_terminal_app3/wh/feature/gateway/page/children/gateway_children_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/device_management_bottom_sheet.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/service/gateway_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'gateway_children_page_interactive.dart';
part 'gateway_children_page_route.dart';

class GatewayChildrenPageController extends GetxController {
  // MARK: - Properties

  final _model = GatewayChildrenPageModel();
  GatewayService get _service => GatewayService.instance;
  RxReadonly<List<ChildDevice>?> get childDevicesRx => _model.childDevices.readonly;

  // MARK: - Init

  GatewayChildrenPageController(GatewayChildrenPageRouterData routerData) {
    _model.routerData = routerData;
    _model.childDevices.value = routerData.childDevices;
  }

  // MARK: - Public Method
}
