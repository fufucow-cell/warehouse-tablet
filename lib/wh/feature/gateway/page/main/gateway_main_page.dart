import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/main/gateway_main_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/main/gateway_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GatewayMainPage extends GetView<GatewayMainPageController> {
  final GatewayMainPageRouterData routerData;
  const GatewayMainPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GatewayMainPageController>(
      init: GatewayMainPageController(routerData),
      builder: (controller) {
        controller.setContext(context);
        return Scaffold(
          body: FirstBackgroundCard(
            child: Column(
              children: [
                const _TopBar(),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 860.0.scale,
                        height: 860.0.scale,
                        child: EnumImage.cGatewayCircle.image(fit: BoxFit.fill),
                      ),
                      const _CenterText(),
                    ],
                  ),
                ),
                const _BottomButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GatewayMainPageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoIconBackButton.color,
          onTap: () {
            controller.interactive(EnumGatewayMainPageInteractive.tapBackButton);
          },
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => CustTextWidget(
                  controller.gatewayNameRx.value,
                  size: 40.0.scale,
                  weightType: EnumFontWeightType.bold,
                  color: EnumColor.textPrimary.color,
                ),
              ),
              SizedBox(width: 16.0.scale),
              CustIconButton(
                icon: EnumImage.cPencilLine,
                size: 50.0.scale,
                color: EnumColor.engoTextPrimary.color,
                onTap: () {
                  controller.interactive(EnumGatewayMainPageInteractive.tapEditButton);
                },
              ),
            ],
          ),
        ),
        CustIconButton(
          icon: EnumImage.cSetting,
          size: 62.0.scale,
          color: EnumColor.engoTextPrimary.color,
          onTap: () {
            controller.interactive(EnumGatewayMainPageInteractive.tapSettingButton);
          },
        ),
      ],
    );
  }
}

class _CenterText extends StatelessWidget {
  const _CenterText();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GatewayMainPageController>();
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustTextWidget(
            EnumLocale.gatewayNetworkStatusGood.tr,
            size: 32.0.scale,
            weightType: EnumFontWeightType.bold,
            color: EnumColor.textPrimary.color,
          ),
          SizedBox(height: 48.0.scale),
          CustTextWidget(
            EnumLocale.gatewayOnlineChildDevicesCount.trArgs([
              controller.getDevicesCount.toString(),
            ]),
            size: 26.0.scale,
            weightType: EnumFontWeightType.regular,
            color: EnumColor.textPrimary.color,
          ),
        ],
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  const _BottomButton();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GatewayMainPageController>();
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0.scale,
            color: EnumColor.engoTextSecondary.color,
          ),
          borderRadius: BorderRadius.circular(12.0.scale),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              controller.interactive(EnumGatewayMainPageInteractive.tapChildDevicesButton);
            },
            borderRadius: BorderRadius.circular(12.0.scale),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32.0.scale,
                vertical: 24.0.scale,
              ),
              child: Row(
                children: [
                  CustTextWidget(
                    EnumLocale.gatewayChildDevicesTitle.tr,
                    size: 32.0.scale,
                    color: EnumColor.engoTextPrimary.color,
                  ),
                  const Spacer(),
                  CustTextWidget(
                    EnumLocale.gatewayChildDevicesSummary.trArgs([
                      controller.getDevicesCount.toString(),
                    ]),
                    size: 32.0.scale,
                    color: EnumColor.engoTextSecondary.color,
                  ),
                  SizedBox(width: 16.0.scale),
                  EnumImage.cArrowRight.image(
                    size: Size.square(45.0.scale),
                    color: EnumColor.engoTextPrimary.color,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
