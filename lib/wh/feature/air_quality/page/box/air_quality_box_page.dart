import 'package:engo_terminal_app3/wh/feature/air_quality/page/box/air_quality_box_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/box/air_quality_box_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/service/air_quality_service.dart';
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

class AirQualityBoxPage extends GetView<AirQualityBoxPageController> {
  final AirQualityBoxPageRouterData routerData;
  const AirQualityBoxPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirQualityBoxPageController>(
      init: AirQualityBoxPageController(routerData),
      builder: (controller) {
        AirQualityService.register().setContext(context);
        return Scaffold(
          body: AirBackgroundCard(
            isBox: true,
            child: Column(
              children: [
                const _TopBar(),
                SizedBox(height: 8.0.scale),
                CustTextWidget(
                  controller.roomName,
                  size: 32.0.scale,
                ),
                const _MainDisplay(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                        const _DataRecordSection(),
                        SizedBox(height: 32.0.scale),
                      ],
                    ),
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
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityBoxPageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            controller.interactive(EnumAirQualityBoxPageInteractive.tapBackButton);
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
                  controller.interactive(EnumAirQualityBoxPageInteractive.tapEditButton);
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
            controller.interactive(EnumAirQualityBoxPageInteractive.tapSettingButton);
          },
        ),
      ],
    );
  }
}

class _MainDisplay extends StatelessWidget {
  const _MainDisplay();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityBoxPageController>();
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

class _DataRecordSection extends StatelessWidget {
  const _DataRecordSection();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityBoxPageController>();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          controller.interactive(EnumAirQualityBoxPageInteractive.tapDataRecordButton);
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
