import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/alert_setting/circuit_breaker_alert_setting_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/alert_setting/circuit_breaker_alert_setting_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_field.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircuitBreakerAlertSettingPage extends GetView<CircuitBreakerAlertSettingPageController> {
  final CircuitBreakerAlertSettingPageRouterData routerData;
  const CircuitBreakerAlertSettingPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CircuitBreakerAlertSettingPageController>(
      init: CircuitBreakerAlertSettingPageController(routerData),
      builder: (controller) {
        return Scaffold(
          body: FirstBackgroundCard(
            child: Column(
              children: [
                _TopBar(),
                SizedBox(height: 18.0.scale),
                Expanded(
                  child: _AlertSettingList(),
                ),
                SizedBox(height: 18.0.scale),
                _RemoveDeviceButton(),
                SizedBox(height: 18.0.scale),
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
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            final controller = Get.find<CircuitBreakerAlertSettingPageController>();
            controller.routerHandle(EnumCircuitBreakerAlertSettingPageRoute.goBack);
          },
        ),
        Expanded(
          child: Center(
            child: CustTextWidget(
              EnumLocale.engoAlertSetting.tr,
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

class _AlertSettingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CircuitBreakerAlertSettingPageController>();
    final settings = controller.getAllSettings;

    return ListView.builder(
      itemCount: settings.length,
      itemBuilder: (context, index) {
        final item = settings[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 24.0.scale),
          child: _AlertSettingCard(
            type: item.type,
            setting: item.setting,
          ),
        );
      },
    );
  }
}

class _AlertSettingCard extends StatelessWidget {
  final EnumAlertSetting type;
  final AlertSettingModel setting;

  const _AlertSettingCard({
    required this.type,
    required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CircuitBreakerAlertSettingPageController>();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0.scale,
        vertical: 32.0.scale,
      ),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 1.5,
          colors: EnumColor.engoCircuitBreakerAlertCardGradient.colors,
        ),
        border: Border.all(
          width: 1.0.scale,
          color: EnumColor.engoCircuitBreakerAlertCardBorder.color,
        ),
        borderRadius: BorderRadius.circular(12.0.scale),
      ),
      child: Row(
        children: [
          // Left section: Title and value input
          SizedBox(
            width: 378.0.scale,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustTextWidget(
                  type.title,
                  size: 32.0.scale,
                  weightType: EnumFontWeightType.bold,
                  color: EnumColor.textPrimary.color,
                ),
                SizedBox(height: 16.0.scale),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustTextWidget(
                      EnumLocale.engoSetValue.tr,
                      size: 26.0.scale,
                      weightType: EnumFontWeightType.regular,
                      color: EnumColor.textPrimary.color,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 194.0.scale,
                          child: Focus(
                            onFocusChange: (hasFocus) {
                              if (!hasFocus) {
                                final controller = Get.find<CircuitBreakerAlertSettingPageController>();
                                controller.onValueFieldUnfocus(setting);
                              }
                            },
                            child: CustTextField(
                              controller: setting.valueController,
                              fontSize: 26.0.scale,
                              textColor: EnumColor.engoCircuitBreakerInputValue.color,
                              textFieldType: EnumTextFieldType.decimal,
                              padding: EdgeInsets.only(
                                top: 18.0.scale,
                                left: 14.0.scale,
                                right: 50.0.scale,
                                bottom: 18.0.scale,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0.scale),
                        CustTextWidget(
                          type.unit,
                          size: 26.0.scale,
                          weightType: EnumFontWeightType.regular,
                          color: EnumColor.textPrimary.color,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 128.0.scale),
          Row(
            children: [
              CustTextWidget(
                EnumLocale.engoSendAlert.tr,
                size: 26.0.scale,
                weightType: EnumFontWeightType.regular,
                color: EnumColor.textPrimary.color,
              ),
              SizedBox(width: 16.0.scale),
              _CustomSwitch(
                value: setting.alertStatus,
                onChanged: (value) {
                  setting.alertStatus = value;
                  controller.interactive(EnumCircuitBreakerAlertSettingPageInteractive.tapAlertSwitch, data: setting);
                },
              ),
            ],
          ),
          SizedBox(width: 128.0.scale),
          // Right section: Circuit breaker switch
          Row(
            children: [
              CustTextWidget(
                EnumLocale.engoCircuitBreakerTrip.tr,
                size: 26.0.scale,
                weightType: EnumFontWeightType.regular,
                color: EnumColor.textPrimary.color,
              ),
              SizedBox(width: 16.0.scale),
              _CustomSwitch(
                value: setting.circuitStatus,
                onChanged: (value) {
                  setting.circuitStatus = value;
                  controller.interactive(EnumCircuitBreakerAlertSettingPageInteractive.tapCircuitSwitch, data: setting);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CustomSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const _CustomSwitch({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: SizedBox(
        width: 78.0.scale,
        height: 45.0.scale,
        child: Stack(
          children: [
            // Background
            Container(
              decoration: BoxDecoration(
                color: value ? EnumColor.engoBackgroundOrange400.color : EnumColor.engoCircuitBreakerSwitchOffThumbBackground.color,
                borderRadius: BorderRadius.circular(30.0.scale),
              ),
            ),
            // Thumb
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: value ? 39.0.scale : 7.31.scale,
              top: value ? 6.54.scale : 5.75.scale,
              child: Container(
                width: 32.5.scale,
                height: 32.5.scale,
                decoration: BoxDecoration(
                  color: EnumColor.textWhite.color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4.0.scale,
                      offset: Offset(0, 2.0.scale),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RemoveDeviceButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CircuitBreakerAlertSettingPageController>();
    return GestureDetector(
      onTap: () {
        controller.interactive(EnumCircuitBreakerAlertSettingPageInteractive.tapRemoveDevice);
      },
      child: Container(
        alignment: Alignment.center,
        width: 600.0.scale,
        padding: EdgeInsets.symmetric(vertical: 24.0.scale),
        decoration: BoxDecoration(
          color: EnumColor.backgroundButton.color,
          borderRadius: BorderRadius.circular(12.0.scale),
          border: Border.all(
            width: 1.0.scale,
            color: Colors.black,
          ),
        ),
        child: Center(
          child: CustTextWidget(
            EnumLocale.engoRemoveDevice.tr,
            size: 32.0.scale,
            weightType: EnumFontWeightType.regular,
            color: EnumColor.textPrimary.color,
          ),
        ),
      ),
    );
  }
}
