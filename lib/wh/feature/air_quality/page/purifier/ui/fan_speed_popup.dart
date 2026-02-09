import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/air_quality_purifier_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/air_quality_purifier_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FanSpeedPopup extends StatelessWidget {
  const FanSpeedPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityPurifierPageController>();
    return GestureDetector(
      onTap: () {
        controller.interactive(EnumAirQualityPurifierPageInteractive.tapPopupOutside);
      },
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              left: 16.0.scale,
              top: 184.0.scale,
              child: GestureDetector(
                onTap: () {}, // 阻止事件冒泡
                child: Container(
                  width: 409.0.scale,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: EnumColor.engoPurifierPopupBgGradient.colors,
                    ),
                    border: Border.all(
                      width: 1.0.scale,
                      color: EnumColor.engoBackgroundOrange400.color,
                    ),
                    borderRadius: BorderRadius.circular(8.0.scale),
                  ),
                  child: const Column(
                    children: [
                      FanSpeedOption(EnumPurifierFanSpeed.light),
                      _Divider(),
                      FanSpeedOption(EnumPurifierFanSpeed.weak),
                      _Divider(),
                      FanSpeedOption(EnumPurifierFanSpeed.strong),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FanSpeedOption extends StatelessWidget {
  final EnumPurifierFanSpeed speed;

  const FanSpeedOption(this.speed, {super.key});

  String get _speedText => speed.title;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityPurifierPageController>();
    return GestureDetector(
      onTap: () {
        controller.interactive(EnumAirQualityPurifierPageInteractive.tapFanSpeedOption, data: speed);
      },
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 32.0.scale,
          horizontal: 24.0.scale,
        ),
        child: CustTextWidget(
          _speedText,
          align: TextAlign.center,
          size: 32.0.scale,
          weightType: EnumFontWeightType.regular,
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0.scale,
      ),
      child: Divider(
        height: 1.0.scale,
        thickness: 1.0.scale,
        color: EnumColor.engoTextPrimary.color,
      ),
    );
  }
}
