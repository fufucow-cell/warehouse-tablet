import 'package:engo_terminal_app3/wh/feature/gateway/page/children/gateway_children_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/gateway_children_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_empty_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_grid_view.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_shimmer_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GatewayChildrenPage extends GetView<GatewayChildrenPageController> {
  final GatewayChildrenPageRouterData routerData;
  const GatewayChildrenPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GatewayChildrenPageController>(
      init: GatewayChildrenPageController(routerData),
      builder: (controller) {
        return Scaffold(
          body: FirstBackgroundCard(
            child: Column(
              children: [
                _TopBar(),
                SizedBox(height: 100.0.scale),
                Expanded(
                  child: _DeviceList(),
                ),
                SizedBox(height: 40.0.scale),
                _BottomButton(),
                SizedBox(height: 100.0.scale),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GatewayChildrenPageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoIconBackButton.color,
          onTap: () {
            controller.interactive(EnumGatewayChildrenPageInteractive.tapBackButton);
          },
        ),
        Expanded(
          child: Center(
            child: CustTextWidget(
              EnumLocale.gatewayChildDevicesTitle.tr,
              size: 40.0.scale,
              weightType: EnumFontWeightType.bold,
              color: EnumColor.textPrimary.color,
            ),
          ),
        ),
        SizedBox(width: 80.0.scale),
      ],
    );
  }
}

class _DeviceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GatewayChildrenPageController>();
    return Obx(
      () {
        final devices = controller.childDevicesRx.value;

        if (devices == null) {
          return const ShimmerWidget();
        }

        if (devices.isEmpty) {
          return const CustEmptyWidget();
        }

        return CustGridView(
          itemCount: devices.length,
          itemBuilder: (context, index) => _ChildDeviceCard(
            device: devices[index],
          ),
          crossAxisCount: 3,
          padding: EdgeInsets.all(16.0.scale),
          crossAxisSpacing: 32.0.scale,
          mainAxisSpacing: 32.0.scale,
        );
      },
    );
  }
}

class _ChildDeviceCard extends StatelessWidget {
  final ChildDevice device;

  const _ChildDeviceCard({required this.device});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GatewayChildrenPageController>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0.scale),
        border: Border.all(
          width: 3.0.scale,
          color: Colors.white,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: EnumColor.engoDeviceCardBackgroundGradient.colors,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0.scale,
          vertical: 16.0.scale,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                EnumImage.cGatewayDevice.image(
                  size: Size(124.0.scale, 70.0.scale),
                  color: EnumColor.engoTextPrimary.color,
                ),
                const Spacer(),
                CustIconButton(
                  icon: EnumImage.cGatewayMore,
                  size: 70.0.scale,
                  color: EnumColor.engoTextPrimary.color,
                  onTap: () {
                    controller.interactive(EnumGatewayChildrenPageInteractive.tapDeviceMoreButton, data: device);
                  },
                ),
              ],
            ),
            SizedBox(height: 40.0.scale),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (device.location != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustTextWidget(
                        device.name,
                        size: 32.0.scale,
                        weightType: EnumFontWeightType.regular,
                        color: EnumColor.textPrimary.color,
                      ),
                      SizedBox(height: 8.0.scale),
                      CustTextWidget(
                        device.location ?? '',
                        size: 22.0.scale,
                        weightType: EnumFontWeightType.regular,
                        color: EnumColor.textSecondary.color,
                      ),
                    ],
                  )
                else
                  CustTextWidget(
                    device.name,
                    size: 32.0.scale,
                    weightType: EnumFontWeightType.regular,
                    color: EnumColor.textPrimary.color,
                  ),
                if (device.isSwitchOn != null) ...[
                  const Spacer(),
                  CustIconButton(
                    icon: device.isSwitchOn! ? EnumImage.cGatewayStatusOn : EnumImage.cGatewayStatusOff,
                    size: 70.0.scale,
                    onTap: () {
                      controller.interactive(
                        EnumGatewayChildrenPageInteractive.tapDeviceSwitchButton,
                        data: device,
                      );
                    },
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GatewayChildrenPageController>();
    return Material(
      color: EnumColor.engoButtonBackground.color,
      borderRadius: BorderRadius.circular(12.0.scale),
      child: InkWell(
        onTap: () {
          controller.interactive(
            EnumGatewayChildrenPageInteractive.tapDeviceManagementButton,
            data: context,
          );
        },
        borderRadius: BorderRadius.circular(12.0.scale),
        child: Container(
          width: 600.0.scale,
          padding: EdgeInsets.symmetric(
            horizontal: 235.0.scale,
            vertical: 24.0.scale,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0.scale,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(12.0.scale),
          ),
          child: Center(
            child: CustTextWidget(
              EnumLocale.gatewayDeviceManagement.tr,
              size: 32.0.scale,
              weightType: EnumFontWeightType.regular,
              color: EnumColor.engoTextPrimary.color,
            ),
          ),
        ),
      ),
    );
  }
}
