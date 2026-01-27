import 'package:engo_terminal_app3/wh/feature/air_box/page/main/air_box_main_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/main/air_box_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/reference/air_box_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/service/air_box_service.dart';
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
        AirBoxService.register().setContext(context);
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
                    const _FirstDisplay(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (controller.visibleDataTypes.length > 1) ...[
                              _SensorDataSection(),
                              SizedBox(height: 48.0.scale),
                            ],
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

class _FirstDisplay extends StatelessWidget {
  const _FirstDisplay();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirBoxMainPageController>();
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
                  Container(
                    width: 33.0.scale,
                    height: 33.0.scale,
                    decoration: ShapeDecoration(
                      color: EnumColor.accentBlue.color,
                      shape: const OvalBorder(),
                    ),
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

class _SensorDataSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirBoxMainPageController>();
    return Obx(
      () {
        final visibleDataTypes = controller.visibleDataTypes;
        if (visibleDataTypes.length <= 1) {
          return const SizedBox.shrink();
        }

        final List<Widget> widgets = [];
        final remainingDataTypes = visibleDataTypes.skip(1).toList();

        for (int i = 0; i < remainingDataTypes.length; i++) {
          if (i > 0) {
            widgets.add(const _Divider());
          }
          widgets.add(
            Expanded(
              child: _DataItem(
                type: remainingDataTypes[i],
                value: controller.getValueForDataType(remainingDataTypes[i]),
              ),
            ),
          );
        }

        return Container(
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
            children: widgets,
          ),
        );
      },
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
  final EnumAirBoxDataType type;
  final String value;

  const _DataItem({
    required this.type,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    Color color = EnumColor.accentBlue.color;
    final level = type.getReferenceLevelByValue(null, value);

    if (level != null) {
      color = level.color;
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustTextWidget(
            type.title.tr,
            size: 26.0.scale,
            weightType: EnumFontWeightType.regular,
            color: EnumColor.textPrimary.color,
            align: TextAlign.center,
          ),
          SizedBox(height: 16.0.scale),
          CustTextWidget(
            '$value ${type.unit}',
            size: 38.0.scale,
            weightType: EnumFontWeightType.bold,
            color: color,
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
