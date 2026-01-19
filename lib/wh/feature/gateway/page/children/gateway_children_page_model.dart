import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GatewayChildrenPageModel {
  GatewayChildrenPageRouterData? routerData;
  final childDevices = Rxn<List<ChildDevice>>();
}

class GatewayChildrenPageRouterData {
  final List<ChildDevice> childDevices;
  final VoidCallback? Function(ChildDevice device)? onGatewayDeviceMoreButtonTap;
  final Future<bool?>? Function(ChildDevice device)? onGatewayDeviceSwitchButtonTap;
  final VoidCallback? onGatewayScanQrCodeAddTap;
  final VoidCallback? onGatewayQuickAddTap;

  const GatewayChildrenPageRouterData({
    required this.childDevices,
    this.onGatewayDeviceMoreButtonTap,
    this.onGatewayDeviceSwitchButtonTap,
    this.onGatewayScanQrCodeAddTap,
    this.onGatewayQuickAddTap,
  });
}

class ChildDevice {
  String id;
  String name;
  String? location;
  bool? isSwitchOn;

  ChildDevice({
    required this.id,
    required this.name,
    this.location,
    this.isSwitchOn,
  });
}
