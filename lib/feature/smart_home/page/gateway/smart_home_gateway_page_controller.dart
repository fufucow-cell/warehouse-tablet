import 'package:engo_terminal_app3/feature/smart_home/page/gateway/smart_home_gateway_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/gateway_children_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/main/gateway_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'smart_home_gateway_page_interactive.dart';
part 'smart_home_gateway_page_route.dart';

class SmartHomeGatewayPageController extends GetxController {
  // MARK: - Properties

  final _model = SmartHomeGatewayPageModel();

  // MARK: - Init

  SmartHomeGatewayPageController();

  // MARK: - Public Method

  void setContext(BuildContext context) {
    _model.context = context;
  }

  GatewayMainPageRouterData get getGatewayMainPageRouterData {
    return GatewayMainPageRouterData(
      language: 'zh_TW',
      theme: 'light',
      isModuleMode: false,
      gatewayName: 'Matter中性網關',
      onlineDevicesCount: 4,
      connectionStatus: '網路狀態連線良好',
      onGatewayBackButtonTap: () {
        routerHandle(
          EnumSmartHomeGatewayPageRoute.showSnackBar,
          data: '點擊返回',
        );
      },
      onGatewayEditButtonTap: (String oldName) async {
        routerHandle(
          EnumSmartHomeGatewayPageRoute.showSnackBar,
          data: '編輯網關名稱',
        );
        return Future.value('新網關名稱');
      },
      onGatewaySettingButtonTap: () {
        routerHandle(
          EnumSmartHomeGatewayPageRoute.showSnackBar,
          data: '點擊設定',
        );
      },
      onGatewayChildDevicesButtonTap: () async {
        routerHandle(
          EnumSmartHomeGatewayPageRoute.showSnackBar,
          data: '前往子設備頁面',
        );
        return Future.value(getGatewayChildrenPageRouterData);
      },
    );
  }

  GatewayChildrenPageRouterData get getGatewayChildrenPageRouterData {
    return GatewayChildrenPageRouterData(
      childDevices: [
        ChildDevice(id: '1', name: '顯示型溫溼度探測器', isSwitchOn: true),
        ChildDevice(id: '2', name: '美芝空調', location: '辦公室', isSwitchOn: true),
        ChildDevice(id: '3', name: '廁所ZigBee', isSwitchOn: false),
        ChildDevice(id: '4', name: '走道人體感應器'),
      ],
      onGatewayDeviceMoreButtonTap: (device) {
        routerHandle(
          EnumSmartHomeGatewayPageRoute.showSnackBar,
          data: '點擊設備更多選項按鍵',
        );
        return null;
      },
      onGatewayDeviceSwitchButtonTap: (device) async {
        routerHandle(
          EnumSmartHomeGatewayPageRoute.showSnackBar,
          data: '點擊設備開關按鍵',
        );
        if (device.isSwitchOn != null) {
          return Future.value(!device.isSwitchOn!);
        }

        return null;
      },
      onGatewayScanQrCodeAddTap: () {
        routerHandle(
          EnumSmartHomeGatewayPageRoute.showSnackBar,
          data: '點擊掃描QR Code新增設備',
        );
      },
      onGatewayQuickAddTap: () {
        routerHandle(
          EnumSmartHomeGatewayPageRoute.showSnackBar,
          data: '點擊快速新增設備',
        );
      },
    );
  }
}
