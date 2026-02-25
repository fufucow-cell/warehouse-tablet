import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/main/circuit_breaker_main_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/page/main/circuit_breaker_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircuitBreakerMainPage extends GetView<CircuitBreakerMainPageController> {
  final CircuitBreakerMainPageRouterData routerData;
  const CircuitBreakerMainPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CircuitBreakerMainPageController>(
      init: CircuitBreakerMainPageController(routerData),
      builder: (controller) {
        controller.setContext(context);
        return Scaffold(
          body: FirstBackgroundCard(
            child: Column(
              children: [
                _TopBar(),
                SizedBox(height: 72.0.scale),
                _SwitchControl(),
                SizedBox(height: 72.0.scale),
                Expanded(
                  child: Column(
                    children: [
                      _StatisticsCard(),
                      SizedBox(height: 48.0.scale),
                      Expanded(
                        child: _DataRecordSection(),
                      ),
                    ],
                  ),
                ),
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
    final controller = Get.find<CircuitBreakerMainPageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            controller.interactive(EnumCircuitBreakerMainPageInteractive.tapBackButton);
          },
        ),
        Expanded(
          child: Obx(
            () {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustTextWidget(
                    controller.titleRx.value,
                    size: 40.0.scale,
                    weightType: EnumFontWeightType.bold,
                    color: EnumColor.textPrimary.color,
                  ),
                  SizedBox(width: 16.0.scale),
                  CustIconButton(
                    icon: EnumImage.cPencilLine,
                    size: 50.0.scale,
                    color: EnumColor.engoTextPrimary.color,
                    onTap: () {
                      controller.interactive(EnumCircuitBreakerMainPageInteractive.tapEditButton);
                    },
                  ),
                ],
              );
            },
          ),
        ),
        CustIconButton(
          icon: EnumImage.cSetting,
          size: 62.0.scale,
          color: EnumColor.engoTextPrimary.color,
          onTap: () {
            controller.interactive(EnumCircuitBreakerMainPageInteractive.tapSettingButton);
          },
        ),
      ],
    );
  }
}

class _SwitchControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CircuitBreakerMainPageController>();
    return Obx(
      () {
        final isOn = controller.isSwitchOnRx.value;
        return Column(
          children: [
            SizedBox(
              width: 166.0.scale,
              height: 473.0.scale,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: EnumColor.engoCircuitBreakerSwitchBackgroundGradient.colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0.scale),
                        border: Border.all(
                          width: 1.0.scale,
                          color: EnumColor.engoButtonBorderReverse.color,
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: isOn ? 0.0.scale : 221.0.scale,
                    child: GestureDetector(
                      onTap: () {
                        controller.interactive(EnumCircuitBreakerMainPageInteractive.tapSwitch);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(18.0.scale),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: 133.0.scale,
                          height: 216.0.scale,
                          decoration: BoxDecoration(
                            color: isOn ? EnumColor.engoBackgroundOrange400.color : EnumColor.engoCircuitBreakerSwitchOffThumbBackground.color,
                            borderRadius: BorderRadius.circular(8.0.scale),
                          ),
                          child: Center(
                            child: TweenAnimationBuilder<Color?>(
                              duration: const Duration(milliseconds: 300),
                              tween: ColorTween(
                                begin: isOn ? EnumColor.engoBackgroundOrange400.color : EnumColor.engoTextPrimary.color,
                                end: isOn ? EnumColor.engoTextPrimary.color : EnumColor.engoBackgroundOrange400.color,
                              ),
                              builder: (context, color, child) {
                                return EnumImage.cCircuit.image(
                                  size: Size.square(91.0.scale),
                                  color: color ?? EnumColor.engoTextPrimary.color,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0.scale),
            CustTextWidget(
              EnumLocale.engoSwitch.tr,
              size: 32.0.scale,
              weightType: EnumFontWeightType.regular,
              color: EnumColor.textPrimary.color,
            ),
          ],
        );
      },
    );
  }
}

class _StatisticsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CircuitBreakerMainPageController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatisticsItem(
          title: EnumLocale.engoCurrentTemperature.tr,
          value: controller.getStatisticsValue('currentTemperature') ?? '-',
          isFirst: true,
        ),
        _DividerLine(),
        _StatisticsItem(
          title: EnumLocale.engoCumulativePowerConsumption.tr,
          value: controller.getStatisticsValue('cumulativePowerConsumption') ?? '-',
        ),
        _DividerLine(),
        _StatisticsItem(
          title: EnumLocale.engoTodayPowerConsumption.tr,
          value: controller.getStatisticsValue('todayPowerConsumption') ?? '-',
        ),
        _DividerLine(),
        _StatisticsItem(
          title: EnumLocale.engoPower.tr,
          value: controller.getStatisticsValue('power') ?? '-',
        ),
        _DividerLine(),
        _StatisticsItem(
          title: EnumLocale.engoVoltage.tr,
          value: controller.getStatisticsValue('voltage') ?? '-',
        ),
        _DividerLine(),
        _StatisticsItem(
          title: EnumLocale.engoCurrent.tr,
          value: controller.getStatisticsValue('current') ?? '-',
        ),
      ],
    );
  }
}

class _StatisticsItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isFirst;

  const _StatisticsItem({
    required this.title,
    required this.value,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustTextWidget(
          title,
          size: 28.0.scale,
          weightType: EnumFontWeightType.regular,
          color: EnumColor.engoTextPrimary.color,
        ),
        if (isFirst || value != '-') ...[
          SizedBox(height: 8.0.scale),
          CustTextWidget(
            value,
            size: 32.0.scale,
            weightType: EnumFontWeightType.bold,
            color: EnumColor.accentBlue.color,
          ),
        ],
      ],
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 1.0.scale,
      height: 80.0.scale,
      color: EnumColor.lineDivider.color,
    );
  }
}

class _DataRecordSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CircuitBreakerMainPageController>();
    return ListView(
      children: [
        _DataRecordItem(
          title: EnumLocale.engoDataRecord.tr,
          onTap: () {
            controller.interactive(EnumCircuitBreakerMainPageInteractive.tapDataRecordItem);
          },
        ),
        SizedBox(height: 24.0.scale),
        _DataRecordItem(
          title: EnumLocale.engoNotificationRecord.tr,
          onTap: () {
            controller.interactive(EnumCircuitBreakerMainPageInteractive.tapNotificationRecordItem);
          },
        ),
        SizedBox(height: 24.0.scale),
        _DataRecordItem(
          title: EnumLocale.engoAlertSetting.tr,
          onTap: () {
            controller.interactive(EnumCircuitBreakerMainPageInteractive.tapAlertSettingItem);
          },
        ),
      ],
    );
  }
}

class _DataRecordItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _DataRecordItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0.scale),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 32.0.scale,
            vertical: 24.0.scale,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0.scale,
              color: EnumColor.engoTextSecondary.color,
            ),
            borderRadius: BorderRadius.circular(12.0.scale),
          ),
          child: Row(
            children: [
              CustTextWidget(
                title,
                size: 32.0.scale,
                weightType: EnumFontWeightType.regular,
                color: EnumColor.engoTextPrimary.color,
              ),
              const Spacer(),
              EnumImage.cArrowRight.image(
                size: Size.square(58.0.scale),
                color: EnumColor.engoTextPrimary.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
