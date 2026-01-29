import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/air_quality_purifier_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/purifier/ui/cust_hour_timer.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerPopup extends StatelessWidget {
  const TimerPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityPurifierPageController>();
    int selectedHour = 1;
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              controller.interactive(EnumAirQualityPurifierPageInteractive.tapPopupOutside);
            },
          ),
        ),
        Positioned(
          left: 16.0.scale,
          top: 336.0.scale,
          child: Container(
            padding: EdgeInsets.all(16.0.scale),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 133,
                      child: CustHourTimer(
                        initialHour: 1,
                        onTimeChanged: (hour) {
                          if (hour != null) {
                            selectedHour = hour;
                          }
                        },
                        textSize: 50.0.scale,
                        selectionBackgroundColor: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    SizedBox(height: 16.0.scale),
                    CustTextWidget(
                      EnumLocale.purifierTimerHour.tr,
                      size: 50.0.scale,
                      color: EnumColor.engoBackgroundOrange400.color,
                    ),
                  ],
                ),
                SizedBox(width: 16.0.scale),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimerButton(
                      text: EnumLocale.commonConfirm.tr,
                      isConfirm: true,
                      onTap: () {
                        controller.interactive(EnumAirQualityPurifierPageInteractive.tapTimerConfirm, data: selectedHour);
                      },
                    ),
                    SizedBox(height: 16.0.scale),
                    TimerButton(
                      text: EnumLocale.commonCancel.tr,
                      isConfirm: false,
                      onTap: () {
                        controller.interactive(EnumAirQualityPurifierPageInteractive.tapPopupOutside);
                      },
                    ),
                    SizedBox(height: 16.0.scale),
                    TimerButton(
                      text: EnumLocale.purifierTimerClear.tr,
                      isConfirm: false,
                      onTap: () {
                        controller.interactive(EnumAirQualityPurifierPageInteractive.tapTimerClean, data: 0);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimerButton extends StatelessWidget {
  final String text;
  final bool isConfirm;
  final VoidCallback onTap;

  const TimerButton({
    super.key,
    required this.text,
    required this.isConfirm,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.0.scale);
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35.0.scale, vertical: 20.0.scale),
          decoration: BoxDecoration(
            color: isConfirm ? EnumColor.engoBackgroundOrange400.color : Colors.transparent,
            border: isConfirm
                ? null
                : Border.all(
                    width: 2.0.scale,
                    color: EnumColor.engoBackgroundOrange400.color,
                  ),
            borderRadius: borderRadius,
          ),
          child: CustTextWidget(
            text,
            size: 32.0.scale,
            weightType: EnumFontWeightType.regular,
            color: isConfirm ? Colors.white : EnumColor.engoBackgroundOrange400.color,
          ),
        ),
      ),
    );
  }
}
