import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_list/water_value_timer_list_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/ui/cust_apm_timer.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/ui/cust_toggle_switch.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/water_value_timer_setting_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterValueTimerSettingPage extends GetView<WaterValueTimerSettingPageController> {
  final WaterValueTimerInfo info;
  const WaterValueTimerSettingPage({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaterValueTimerSettingPageController>(
      init: WaterValueTimerSettingPageController(info),
      builder: (controller) {
        return Scaffold(
          body: FirstBackgroundCard(
            child: Column(
              children: [
                const _TopBar(),
                SizedBox(height: 48.0.scale),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 200.0.scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _TabBar(),
                        SizedBox(height: 48.0.scale),
                        const _TimePickerSection(),
                        SizedBox(height: 48.0.scale),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const _RepeatAndWeekdaySection(),
                                SizedBox(height: 32.0.scale),
                                const _NoteSection(),
                                SizedBox(height: 32.0.scale),
                                const _NotificationSection(),
                                SizedBox(height: 32.0.scale),
                                const _SaveButton(),
                                SizedBox(height: 32.0.scale),
                              ],
                            ),
                          ),
                        ),
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
    final controller = Get.find<WaterValueTimerSettingPageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            controller.interactive(EnumWaterValueTimerSettingPageInteractive.tapBackButton);
          },
        ),
        Expanded(
          child: Center(
            child: CustTextWidget(
              EnumLocale.waterValueTimerSetting.tr,
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

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerSettingPageController>();
    return Obx(
      () {
        final enumStatus = controller.enumStatusRx.value;
        return Container(
          height: 68.0.scale,
          decoration: ShapeDecoration(
            color: EnumColor.backgroundQuaternary.color,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: EnumColor.engoWaterValueFunctionCardBorder.color,
              ),
              borderRadius: BorderRadius.circular(12.0.scale),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.interactive(
                      EnumWaterValueTimerSettingPageInteractive.tapTab,
                      data: EnumStatusTab.open,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: enumStatus == EnumStatusTab.open ? EnumColor.engoWaterValueFunctionCardBorder.color : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0.scale),
                        bottomLeft: Radius.circular(12.0.scale),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CustTextWidget(
                      EnumLocale.waterValueOpen.tr,
                      size: 32.0.scale,
                      color: enumStatus == EnumStatusTab.open ? EnumColor.textWhite.color : EnumColor.textSecondary.color,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.interactive(
                      EnumWaterValueTimerSettingPageInteractive.tapTab,
                      data: EnumStatusTab.close,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: enumStatus == EnumStatusTab.close ? EnumColor.engoWaterValueFunctionCardBorder.color : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.0.scale),
                        bottomRight: Radius.circular(12.0.scale),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CustTextWidget(
                      EnumLocale.waterValueClose.tr,
                      size: 32.0.scale,
                      color: enumStatus == EnumStatusTab.close ? EnumColor.textWhite.color : EnumColor.textSecondary.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TimePickerSection extends StatelessWidget {
  const _TimePickerSection();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerSettingPageController>();
    return Obx(
      () {
        return Center(
          child: SizedBox(
            width: 593.0.scale,
            height: 250.0.scale,
            child: CustAPMTimer(
              time: controller.timeRx.value,
              onTimeChanged: (time) {
                controller.interactive(
                  EnumWaterValueTimerSettingPageInteractive.tapTime,
                  data: time,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _RepeatAndWeekdaySection extends StatelessWidget {
  const _RepeatAndWeekdaySection();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerSettingPageController>();
    return Obx(
      () {
        final isEnabled = controller.isRepeatRx.value;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustTextWidget(
                  EnumLocale.waterValueTimerRepeat.tr,
                  size: 32.0.scale,
                  color: EnumColor.textPrimary.color,
                ),
                CustToggleSwitch(
                  value: isEnabled,
                  onTap: () {
                    controller.interactive(EnumWaterValueTimerSettingPageInteractive.tapRepeatToggle);
                  },
                ),
              ],
            ),
            if (isEnabled) ...[
              SizedBox(height: 32.0.scale),
              const _RepeatTabbar(),
              if (controller.isRepeatRx.value && controller.enumRepeatDayRx.value == EnumRepeatDay.custom) ...[
                SizedBox(height: 32.0.scale),
                const _WeekdayList(),
              ],
            ],
            SizedBox(height: 32.0.scale),
            const _Divider(),
          ],
        );
      },
    );
  }
}

class _RepeatTabbar extends StatelessWidget {
  const _RepeatTabbar();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerSettingPageController>();
    return Obx(
      () {
        final enumRepeatDay = controller.enumRepeatDayRx.value;
        return Container(
          height: 68.0.scale,
          decoration: ShapeDecoration(
            color: EnumColor.backgroundQuaternary.color,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: EnumColor.engoWaterValueFunctionCardBorder.color,
              ),
              borderRadius: BorderRadius.circular(12.0.scale),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.interactive(
                      EnumWaterValueTimerSettingPageInteractive.tapWeekday,
                      data: EnumRepeatDay.weekday,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: enumRepeatDay == EnumRepeatDay.weekday ? EnumColor.engoWaterValueFunctionCardBorder.color : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0.scale),
                        bottomLeft: Radius.circular(12.0.scale),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CustTextWidget(
                      EnumLocale.waterValueTimerWeekday.tr,
                      size: 32.0.scale,
                      color: enumRepeatDay == EnumRepeatDay.weekday ? EnumColor.textWhite.color : EnumColor.textSecondary.color,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.interactive(
                      EnumWaterValueTimerSettingPageInteractive.tapWeekday,
                      data: EnumRepeatDay.everyday,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: enumRepeatDay == EnumRepeatDay.everyday ? EnumColor.engoWaterValueFunctionCardBorder.color : Colors.transparent,
                      borderRadius: BorderRadius.zero,
                    ),
                    alignment: Alignment.center,
                    child: CustTextWidget(
                      EnumLocale.waterValueTimerEveryday.tr,
                      size: 32.0.scale,
                      color: enumRepeatDay == EnumRepeatDay.everyday ? EnumColor.textWhite.color : EnumColor.textSecondary.color,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.interactive(
                      EnumWaterValueTimerSettingPageInteractive.tapWeekday,
                      data: EnumRepeatDay.custom,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: enumRepeatDay == EnumRepeatDay.custom ? EnumColor.engoWaterValueFunctionCardBorder.color : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.0.scale),
                        bottomRight: Radius.circular(12.0.scale),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CustTextWidget(
                      EnumLocale.waterValueTimerCustom.tr,
                      size: 32.0.scale,
                      color: enumRepeatDay == EnumRepeatDay.custom ? EnumColor.textWhite.color : EnumColor.textSecondary.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WeekdayList extends StatelessWidget {
  const _WeekdayList();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerSettingPageController>();
    final weekdayLabels = [
      EnumLocale.waterValueTimerMonday,
      EnumLocale.waterValueTimerTuesday,
      EnumLocale.waterValueTimerWednesday,
      EnumLocale.waterValueTimerThursday,
      EnumLocale.waterValueTimerFriday,
      EnumLocale.waterValueTimerSaturday,
      EnumLocale.waterValueTimerSunday,
    ];

    return Obx(
      () {
        final selectedDays = controller.selectedDaysRx.value;
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(7, (index) {
            final day = index + 1; // 1-7: 周一到周日
            final isSelected = selectedDays.contains(day);
            return Padding(
              padding: EdgeInsets.only(right: index < 6 ? 48.0.scale : 0),
              child: GestureDetector(
                onTap: () {
                  controller.interactive(
                    EnumWaterValueTimerSettingPageInteractive.tapDay,
                    data: day,
                  );
                },
                child: Container(
                  width: 100.0.scale,
                  height: 100.0.scale,
                  decoration: ShapeDecoration(
                    color: isSelected ? EnumColor.engoWaterValueStatusOpening.color : EnumColor.engoBottomSheetBackground.color,
                    shape: const OvalBorder(),
                  ),
                  child: Center(
                    child: CustTextWidget(
                      weekdayLabels[index].tr,
                      size: 26.0.scale,
                      color: isSelected ? EnumColor.textWhite.color : EnumColor.textSecondary.color,
                      align: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          }),
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
      color: EnumColor.textSecondary.color,
      height: 1,
    );
  }
}

class _NoteSection extends StatelessWidget {
  const _NoteSection();

  @override
  Widget build(BuildContext context) {
    final pageController = Get.find<WaterValueTimerSettingPageController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 58.0.scale,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustTextWidget(
                EnumLocale.waterValueTimerNote.tr,
                size: 32.0.scale,
                color: EnumColor.textPrimary.color,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 32.0.scale),
                  child: TextField(
                    controller: pageController.textController,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 26.0.scale,
                      color: EnumColor.textSecondary.color,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      hintText: '',
                      hintStyle: TextStyle(
                        fontSize: 26.0.scale,
                        color: EnumColor.textSecondary.color,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32.0.scale),
        Container(
          width: double.infinity,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: EnumColor.textSecondary.color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationSection extends StatelessWidget {
  const _NotificationSection();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerSettingPageController>();
    return Obx(
      () {
        final isEnabled = controller.isNotifyRx.value;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 58.0.scale,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustTextWidget(
                    EnumLocale.waterValueTimerExecuteNotification.tr,
                    size: 32.0.scale,
                    color: EnumColor.textPrimary.color,
                  ),
                  CustToggleSwitch(
                    value: isEnabled,
                    onTap: () {
                      controller.interactive(EnumWaterValueTimerSettingPageInteractive.tapNotificationToggle);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0.scale),
            Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: EnumColor.textSecondary.color,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerSettingPageController>();
    return GestureDetector(
      onTap: () {
        controller.interactive(EnumWaterValueTimerSettingPageInteractive.tapSave);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 235.0.scale,
          vertical: 24.0.scale,
        ),
        decoration: ShapeDecoration(
          color: EnumColor.engoWaterValueStatusOpening.color,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(12.0.scale),
          ),
        ),
        child: CustTextWidget(
          EnumLocale.waterValueTimerSave.tr,
          size: 32.0.scale,
          color: EnumColor.textWhite.color,
        ),
      ),
    );
  }
}
