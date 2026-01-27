import 'package:engo_terminal_app3/wh/feature/air_box/page/reference/air_box_reference_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/air_box/page/reference/air_box_reference_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_dropdown_menu_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirBoxReferencePage extends GetView<AirBoxReferencePageController> {
  final EnumAirBoxDataType? type;
  const AirBoxReferencePage({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirBoxReferencePageController>(
      init: AirBoxReferencePageController(type),
      builder: (controller) {
        controller.setContext(context);
        return Scaffold(
          body: FirstBackgroundCard(
            child: Column(
              children: [
                const _TopBar(),
                SizedBox(height: 48.0.scale),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 437.0.scale),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _ParameterSelector(),
                        SizedBox(height: 48.0.scale),
                        _ParameterInfo(),
                        SizedBox(height: 48.0.scale),
                        _LevelList(),
                      ],
                    ),
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

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirBoxReferencePageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            controller.interactive(EnumAirBoxReferencePageInteractive.tapBackButton);
          },
        ),
        Expanded(
          child: Center(
            child: CustTextWidget(
              EnumLocale.airBoxReferenceTitle.tr,
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

class _ParameterSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirBoxReferencePageController>();
    return Obx(
      () => CustTextDropdownButton(
        width: 380.0.scale,
        height: 70.0.scale,
        selectedValue: controller.getDataTypeNames()[controller.selectedDataTypeRx.value.index],
        values: controller.getDataTypeNames(),
        onValueSelected: (value) {
          if (value != null) {
            controller.interactive(
              EnumAirBoxReferencePageInteractive.tapDataTypeDropdown,
              data: value,
            );
          }
        },
      ),
    );
  }
}

class _ParameterInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirBoxReferencePageController>();
    return Obx(
      () {
        final standard = controller.getCurrentStandard();
        if (standard == null) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          width: 768.0.scale,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustTextWidget(
                standard.titleLocale.tr,
                size: 32.0.scale,
                weightType: EnumFontWeightType.bold,
                color: EnumColor.textPrimary.color,
                align: TextAlign.center,
              ),
              SizedBox(height: 20.0.scale),
              SizedBox(
                width: 768.0.scale,
                child: CustTextWidget(
                  standard.descriptionLocale.tr,
                  size: 26.0.scale,
                  weightType: EnumFontWeightType.regular,
                  color: EnumColor.textPrimary.color,
                  align: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LevelList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirBoxReferencePageController>();
    return Obx(
      () {
        final standard = controller.getCurrentStandard();
        if (standard == null) {
          return const SizedBox.shrink();
        }

        return ConstrainedBox(
          constraints: BoxConstraints(minWidth: 683.0.scale),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...standard.levels.map((level) => _LevelItem(level: level)),
            ],
          ),
        );
      },
    );
  }
}

class _UnitDisplay extends StatelessWidget {
  final String unit;
  final String parameterName;

  const _UnitDisplay({
    required this.unit,
    required this.parameterName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 227.0.scale,
      height: 74.0.scale,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 18,
            child: CustTextWidget(
              '$parameterName($unit)',
              size: 32.0.scale,
              weightType: EnumFontWeightType.regular,
              color: EnumColor.textPrimary.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelItem extends StatelessWidget {
  final ReferenceLevel level;

  const _LevelItem({required this.level});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 33.0.scale,
                    height: 33.0.scale,
                    decoration: ShapeDecoration(
                      color: level.color,
                      shape: const OvalBorder(),
                    ),
                  ),
                  SizedBox(width: 48.0.scale),
                  Text(
                    level.range,
                    style: TextStyle(
                      fontSize: 32.0.scale,
                      fontWeight: FontWeight.w400,
                      color: EnumColor.textPrimary.color,
                      letterSpacing: 10.0,
                    ),
                  ),
                ],
              ),
              CustTextWidget(
                level.statusLocale.tr,
                size: 32.0.scale,
                weightType: EnumFontWeightType.regular,
                color: EnumColor.textPrimary.color,
                align: TextAlign.right,
              ),
            ],
          ),
        ),
        SizedBox(height: 32.0.scale),
        Container(
          width: double.infinity,
          height: 1.0.scale,
          color: EnumColor.textPrimary.color,
        ),
        SizedBox(height: 32.0.scale),
      ],
    );
  }
}
