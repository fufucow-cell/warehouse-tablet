import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/air_quality_purifier_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/air_quality_purifier_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/ui/fan_speed_popup.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/ui/mode_popup.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/ui/timer_popup.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/ui/sensor_data_bar.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/air_background_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirQualityPurifierPage extends GetView<AirQualityPurifierPageController> {
  final AirQualityPurifierPageRouterData routerData;
  const AirQualityPurifierPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirQualityPurifierPageController>(
      init: AirQualityPurifierPageController(routerData),
      builder: (controller) {
        controller.setContext(context);
        return Scaffold(
          body: AirBackgroundCard(
            isPurifier: true,
            child: Column(
              children: [
                const _TopBar(),
                SizedBox(height: 8.0.scale),
                CustTextWidget(
                  controller.getRoomName,
                  size: 32.0.scale,
                ),
                SizedBox(height: 16.0.scale),
                Obx(() {
                  controller.sensorDataRx.value;

                  if (controller.visibleDataTypes.length > 1) {
                    final sensorDatas = controller.getSensorDatas;
                    return Column(
                      children: [
                        SensorDataBar(
                          datas: sensorDatas.skip(1).toList(),
                        ),
                        SizedBox(height: 48.0.scale),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                }),
                Expanded(
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          const _LeftControlButtons(),
                          Expanded(
                            child: Stack(
                              fit: StackFit.expand,
                              clipBehavior: Clip.none,
                              children: [
                                const Positioned.fill(child: _MainDisplay()),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Obx(
                                      () {
                                        if (controller.showModePopupRx.value) {
                                          return const ModePopup();
                                        }
                                        if (controller.showFanSpeedPopupRx.value) {
                                          return const FanSpeedPopup();
                                        }
                                        if (controller.showTimerPopupRx.value) {
                                          return const TimerPopup();
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 50.0.scale,
                        bottom: 50.0.scale,
                        child: _PowerButton(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.0.scale),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LeftControlButtons extends StatelessWidget {
  const _LeftControlButtons();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityPurifierPageController>();
    return SizedBox(
      width: 493.0.scale,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 32.0.scale),
          Obx(
            () => _LeftControlButton(
              text: _getModeText(controller.currentModeRx.value),
              isFocused: controller.currentModeRx.value != EnumPurifierMode.close,
              enumImage: EnumImage.cMenu,
              onTap: () {
                controller.interactive(EnumAirQualityPurifierPageInteractive.tapModeButton);
              },
            ),
          ),
          SizedBox(height: 48.0.scale),
          Obx(
            () => _LeftControlButton(
              text: _getFanSpeedText(controller.currentFanSpeedRx.value),
              isFocused: controller.currentFanSpeedRx.value != EnumPurifierFanSpeed.close,
              enumImage: EnumImage.cWind,
              onTap: () {
                controller.interactive(EnumAirQualityPurifierPageInteractive.tapFanSpeedButton);
              },
            ),
          ),
          SizedBox(height: 48.0.scale),
          Obx(
            () {
              controller.timerMinutesRx.value;
              return _LeftControlButton(
                text: controller.getTimeCounterText(),
                isFocused: controller.timerMinutesRx.value > 0,
                enumImage: EnumImage.cClock,
                onTap: () {
                  controller.interactive(EnumAirQualityPurifierPageInteractive.tapTimerButton);
                },
              );
            },
          ),
          SizedBox(height: 48.0.scale),
          _LeftControlButton(
            text: EnumLocale.purifierTabData.tr,
            enumImage: EnumImage.cChart,
            onTap: () {
              controller.interactive(EnumAirQualityPurifierPageInteractive.tapDataButton);
            },
          ),
          SizedBox(height: 48.0.scale),
          Obx(
            () => _LeftControlButton(
              text: controller.getFilterLifeText,
              enumImage: EnumImage.cPurifierFliter,
              onTap: () {
                controller.interactive(EnumAirQualityPurifierPageInteractive.tapFilterLife);
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getModeText(EnumPurifierMode mode) {
    return mode.title;
  }

  String _getFanSpeedText(EnumPurifierFanSpeed speed) {
    return speed.title;
  }
}

class _LeftControlButton extends StatelessWidget {
  final String text;
  final bool isFocused;
  final VoidCallback onTap;
  final EnumImage enumImage;

  const _LeftControlButton({
    required this.text,
    this.isFocused = false,
    required this.onTap,
    required this.enumImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0.scale, horizontal: 16.0.scale),
        decoration: BoxDecoration(
          color: EnumColor.engoBackgroundOrange400.color.withOpacity(0.1),
          border: Border.all(
            width: 1.0.scale,
            color: EnumColor.engoBackgroundOrange400.color,
          ),
          borderRadius: BorderRadius.circular(8.0.scale),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            enumImage.image(
              size: Size.square(70.0.scale),
              color: isFocused ? EnumColor.engoBackgroundOrange400.color : EnumColor.textPrimary.color,
            ),
            SizedBox(width: 16.0.scale),
            CustTextWidget(
              text,
              size: 32.0.scale,
              weightType: EnumFontWeightType.regular,
              color: isFocused ? EnumColor.engoBackgroundOrange400.color : EnumColor.textPrimary.color,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityPurifierPageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            controller.interactive(EnumAirQualityPurifierPageInteractive.tapBackButton);
          },
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => CustTextWidget(
                  controller.titleRx.value,
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
                  controller.interactive(EnumAirQualityPurifierPageInteractive.tapEditButton);
                },
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 12.0.scale),
            CustIconButton(
              icon: EnumImage.cSetting,
              size: 62.0.scale,
              color: EnumColor.engoTextPrimary.color,
              onTap: () {
                controller.interactive(EnumAirQualityPurifierPageInteractive.tapSettingButton);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _MainDisplay extends StatelessWidget {
  const _MainDisplay();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityPurifierPageController>();
    return Container(
      alignment: Alignment.center,
      height: 600.0.scale,
      child: Obx(
        () {
          final visibleDataTypes = controller.visibleDataTypes;

          if (visibleDataTypes.isEmpty) {
            return const SizedBox.shrink();
          }

          final type = visibleDataTypes.first;
          final value = controller.getValueForDataType(type);
          Color color = EnumColor.accentBlue.color;
          final level = type.getReferenceLevelByValue(null, value);

          if (level != null) {
            color = level.color;
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  type.enumImage.image(
                    size: Size.square(70.0.scale),
                    color: EnumColor.accentBlue.color,
                  ),
                  SizedBox(width: 20.0.scale),
                  CustTextWidget(
                    type.title.tr,
                    size: 40.0.scale,
                    weightType: EnumFontWeightType.regular,
                    color: EnumColor.accentBlue.color,
                  ),
                ],
              ),
              SizedBox(height: 8.0.scale),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustTextWidget(
                    value,
                    size: 180.0.scale,
                    weightType: EnumFontWeightType.bold,
                    color: color,
                  ),
                  if (level != null) ...[
                    SizedBox(width: 24.0.scale),
                    CustTextWidget(
                      level.statusLocale.tr,
                      size: 40.0.scale,
                      weightType: EnumFontWeightType.regular,
                      color: color,
                    ),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PowerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityPurifierPageController>();
    return Obx(
      () {
        final isOn = controller.isOnRx.value;
        final eImg = isOn ? EnumImage.cGatewayStatusOn : EnumImage.cGatewayStatusOff;
        return GestureDetector(
          onTap: () {
            controller.interactive(EnumAirQualityPurifierPageInteractive.tapPowerButton);
          },
          child: eImg.image(
            size: Size.square(116.0.scale),
          ),
        );
      },
    );
  }
}
