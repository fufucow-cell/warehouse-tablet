import 'package:engo_terminal_app3/wh/feature/gateway/page/children/gateway_children_page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GatewayMainPageModel {
  GatewayMainPageRouterData? routerData;
  final gatewayName = ''.obs;
}

class GatewayMainPageRouterData {
  final String language;
  final String theme;
  final bool isModuleMode;
  final String gatewayName;
  final int onlineDevicesCount;
  final String connectionStatus;
  final VoidCallback? onGatewayBackButtonTap;
  final Future<String?> Function(String oldName)? onGatewayEditButtonTap;
  final VoidCallback? onGatewaySettingButtonTap;
  final Future<GatewayChildrenPageRouterData> Function()? onGatewayChildDevicesButtonTap;

  const GatewayMainPageRouterData({
    required this.language,
    required this.theme,
    required this.isModuleMode,
    required this.gatewayName,
    required this.onlineDevicesCount,
    required this.connectionStatus,
    this.onGatewayBackButtonTap,
    this.onGatewayEditButtonTap,
    this.onGatewaySettingButtonTap,
    this.onGatewayChildDevicesButtonTap,
  });
}
