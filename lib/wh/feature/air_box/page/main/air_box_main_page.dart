import 'package:engo_terminal_app3/wh/feature/air_box/page/main/air_box_main_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/main/air_box_main_page_model.dart';
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

class AirBoxMainPage extends GetView<AirBoxMainPageController> {
  final AirBoxMainPageRouterData routerData;
  const AirBoxMainPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirBoxMainPageController>(
      init: AirBoxMainPageController(routerData),
      builder: (controller) {
        controller.setContext(context);
        return Scaffold(
          body: AirBackgroundCard(
            child: Stack(
              children: [
                Positioned.fill(
                  top: -50.0.scale,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: EnumImage.cBackgroundWind2.image(
                      size: Size.square(900.0.scale),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const _TopBar(),
                    Container(
                      alignment: Alignment.center,
                      height: 600.0.scale,
                      child: const _Pm25Display(),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const _DataCard(),
                            SizedBox(height: 48.0.scale),
                            const _DataRecordSection(),
                            SizedBox(height: 32.0.scale),
                          ],
                        ),
                      ),
                    ),
                  ],
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
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirBoxMainPageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            controller.interactive(EnumAirBoxMainPageInteractive.tapBackButton);
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
                  controller.interactive(EnumAirBoxMainPageInteractive.tapEditButton);
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
            controller.interactive(EnumAirBoxMainPageInteractive.tapSettingButton);
          },
        ),
      ],
    );
  }
}

class _Pm25Display extends StatelessWidget {
  const _Pm25Display();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirBoxMainPageController>();
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 33.0.scale,
                height: 33.0.scale,
                decoration: ShapeDecoration(
                  color: EnumColor.accentGreen.color,
                  shape: const OvalBorder(),
                ),
              ),
              SizedBox(width: 20.0.scale),
              CustTextWidget(
                'PM2.5 ',
                size: 40.0.scale,
                weightType: EnumFontWeightType.regular,
                color: EnumColor.accentGreen.color,
              ),
            ],
          ),
          SizedBox(height: 8.0.scale),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustTextWidget(
                controller.pm25Rx.value.isNotEmpty ? controller.pm25Rx.value : '0',
                size: 180.0.scale,
                weightType: EnumFontWeightType.bold,
                color: EnumColor.accentBlue.color,
              ),
              SizedBox(width: 24.0.scale),
              CustTextWidget(
                controller.pm25StatusRx.value.isNotEmpty ? controller.pm25StatusRx.value : '良好',
                size: 40.0.scale,
                weightType: EnumFontWeightType.regular,
                color: EnumColor.accentBlue.color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DataCard extends StatelessWidget {
  const _DataCard();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirBoxMainPageController>();
    return Obx(
      () => Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32.0.scale, vertical: 16.0.scale),
        decoration: ShapeDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 15.0.scale,
            colors: EnumColor.airBoxDataCardGradient.colors,
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0.scale,
              color: EnumColor.engoButtonBorderReverse.color,
            ),
            borderRadius: BorderRadius.circular(12.0.scale),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _DataItem(
                label: EnumLocale.airBoxCurrentTemperature.tr,
                value: controller.temperatureRx.value.isNotEmpty ? '${controller.temperatureRx.value}°C' : '--',
              ),
            ),
            const _Divider(),
            Expanded(
              child: _DataItem(
                label: EnumLocale.airBoxCurrentHumidity.tr,
                value: controller.humidityRx.value.isNotEmpty ? '${controller.humidityRx.value}%' : '--',
              ),
            ),
            const _Divider(),
            Expanded(
              child: _DataItem(
                label: EnumLocale.airBoxFormaldehydeValue.tr,
                value: controller.formaldehydeRx.value.isNotEmpty ? controller.formaldehydeRx.value : '--',
              ),
            ),
            const _Divider(),
            Expanded(
              child: _DataItem(
                label: EnumLocale.airBoxVocValue.tr,
                value: controller.vocRx.value.isNotEmpty ? controller.vocRx.value : '--',
              ),
            ),
            const _Divider(),
            Expanded(
              child: _DataItem(
                label: EnumLocale.airBoxCo2Value.tr,
                value: controller.co2Rx.value.isNotEmpty ? controller.co2Rx.value : '--',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0.scale,
      height: 75.0.scale,
      color: Colors.black,
    );
  }
}

class _DataItem extends StatelessWidget {
  final String label;
  final String value;

  const _DataItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustTextWidget(
            label,
            size: 26.0.scale,
            weightType: EnumFontWeightType.regular,
            color: EnumColor.textPrimary.color,
            align: TextAlign.center,
          ),
          SizedBox(height: 16.0.scale),
          CustTextWidget(
            value,
            size: 38.0.scale,
            weightType: EnumFontWeightType.bold,
            color: EnumColor.accentBlue.color,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DataRecordSection extends StatelessWidget {
  const _DataRecordSection();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirBoxMainPageController>();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          controller.interactive(EnumAirBoxMainPageInteractive.tapDataRecordButton);
        },
        borderRadius: BorderRadius.circular(12.0.scale),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0.scale,
              color: EnumColor.textSecondary.color,
            ),
            borderRadius: BorderRadius.circular(12.0.scale),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.0.scale, vertical: 32.0.scale),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustTextWidget(
                  EnumLocale.airBoxDataRecord.tr,
                  size: 32.0.scale,
                  weightType: EnumFontWeightType.regular,
                  color: EnumColor.textPrimary.color,
                ),
              ),
              SizedBox(width: 16.0.scale),
              EnumImage.cArrowRight.image(
                size: Size.square(58.0.scale),
                color: EnumColor.textPrimary.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
