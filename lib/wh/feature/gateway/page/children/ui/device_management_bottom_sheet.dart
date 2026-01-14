import 'package:engo_terminal_app3/wh/feature/gateway/page/children/gateway_children_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceManagementBottomSheet extends StatelessWidget {
  const DeviceManagementBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GatewayChildrenPageController>();
    return Container(
      padding: EdgeInsets.only(
        left: 24.0.scale,
        right: 24.0.scale,
        top: 24.0.scale,
        bottom: 32.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.engoBottomSheetBackground.color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0.scale),
          topRight: Radius.circular(24.0.scale),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustTextWidget(
            EnumLocale.gatewayDeviceManagement.tr,
            size: 40.0.scale,
            weightType: EnumFontWeightType.bold,
            color: EnumColor.engoTextPrimary.color,
            align: TextAlign.center,
          ),
          SizedBox(height: 32.0.scale),
          _OptionItem(
            text: EnumLocale.gatewayScanQrCodeAdd.tr,
            onTap: () {
              controller.interactive(
                EnumGatewayChildrenPageInteractive.tapScanQrCodeAdd,
                data: context,
              );
            },
          ),
          SizedBox(height: 16.0.scale),
          Divider(
            height: 1.0.scale,
            thickness: 1.0.scale,
            color: EnumColor.textSecondary.color,
          ),
          SizedBox(height: 16.0.scale),
          _OptionItem(
            text: EnumLocale.gatewayQuickAdd.tr,
            onTap: () {
              controller.interactive(
                EnumGatewayChildrenPageInteractive.tapQuickAdd,
                data: context,
              );
            },
          ),
          SizedBox(height: 16.0.scale),
          Divider(
            height: 1.0.scale,
            thickness: 1.0.scale,
            color: EnumColor.textSecondary.color,
          ),
          SizedBox(height: 32.0.scale),
          Material(
            color: EnumColor.engoButtonBackground.color,
            borderRadius: BorderRadius.circular(12.0.scale),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              borderRadius: BorderRadius.circular(12.0.scale),
              child: Container(
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
                    EnumLocale.commonCancel.tr,
                    size: 32.0.scale,
                    weightType: EnumFontWeightType.regular,
                    color: EnumColor.engoTextPrimary.color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _OptionItem({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.scale),
          child: CustTextWidget(
            text,
            size: 32.0.scale,
            weightType: EnumFontWeightType.regular,
            color: EnumColor.engoTextPrimary.color,
          ),
        ),
      ),
    );
  }
}
