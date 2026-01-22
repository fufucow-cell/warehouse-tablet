import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/water_value_timer_setting_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/water_value_timer_setting_page_model.dart';
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

class WaterValueTimerSettingPage extends GetView<WaterValueTimerSettingPageController> {
  final WaterValueTimerSettingPageRouterData routerData;
  const WaterValueTimerSettingPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaterValueTimerSettingPageController>(
      init: WaterValueTimerSettingPageController(routerData),
      builder: (controller) {
        controller.setContext(context);
        return Scaffold(
          body: FirstBackgroundCard(
            child: Column(
              children: [
                const _TopBar(),
                SizedBox(height: 48.0.scale),
                const _TabBar(),
                SizedBox(height: 48.0.scale),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const _TimePickerSection(),
                        SizedBox(height: 48.0.scale),
                        const _RepeatSection(),
                        SizedBox(height: 32.0.scale),
                        const _WeekdaySelector(),
                        Obx(
                          () {
                            final controller = Get.find<WaterValueTimerSettingPageController>();
                            // 当重复开关开启且选中自定義模式时，显示周一到周日列表
                            if (controller.isRepeatEnabledRx.value && controller.selectedWeekdayRx.value == 2) {
                              return Column(
                                children: [
                                  SizedBox(height: 32.0.scale),
                                  const _WeekdayList(),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        SizedBox(height: 32.0.scale),
                        const _NoteSection(),
                        SizedBox(height: 32.0.scale),
                        const _NotificationSection(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 48.0.scale),
                const _SaveButton(),
                SizedBox(height: 48.0.scale),
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
        CustIconButton(
          icon: EnumImage.cSetting,
          size: 62.0.scale,
          color: EnumColor.engoTextPrimary.color,
          onTap: () {
            controller.interactive(EnumWaterValueTimerSettingPageInteractive.tapSettingButton);
          },
        ),
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
        final selectedTab = controller.selectedTabRx.value;
        return Container(
          width: 1195.0.scale,
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
                    controller.interactive(EnumWaterValueTimerSettingPageInteractive.tapTab, data: 0);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedTab == 0
                          ? EnumColor.engoWaterValueFunctionCardBorder.color
                          : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0.scale),
                        bottomLeft: Radius.circular(12.0.scale),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CustTextWidget(
                      EnumLocale.waterValueOpen.tr,
                      size: 32.0.scale,
                      color: selectedTab == 0
                          ? EnumColor.textWhite.color
                          : EnumColor.textSecondary.color,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.interactive(EnumWaterValueTimerSettingPageInteractive.tapTab, data: 1);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedTab == 1
                          ? EnumColor.engoWaterValueFunctionCardBorder.color
                          : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.0.scale),
                        bottomRight: Radius.circular(12.0.scale),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CustTextWidget(
                      EnumLocale.waterValueClose.tr,
                      size: 32.0.scale,
                      color: selectedTab == 1
                          ? EnumColor.textWhite.color
                          : EnumColor.textSecondary.color,
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
        final selectedTab = controller.selectedTabRx.value;
        // 根据选中的 tab 决定显示哪个时间选择器
        // 0: 開啟, 1: 關閉
        final isOpenTime = selectedTab == 0;

        return Center(
          child: SizedBox(
            width: 593.0.scale,
            child: _TimePicker(
              title: isOpenTime
                  ? EnumLocale.waterValueTimerOpenTime.tr
                  : EnumLocale.waterValueTimerCloseTime.tr,
              time: isOpenTime
                  ? controller.openTimeRx.value
                  : controller.closeTimeRx.value,
              onTimeChanged: (time) {
                if (isOpenTime) {
                  controller.interactive(
                    EnumWaterValueTimerSettingPageInteractive.tapOpenTime,
                    data: time,
                  );
                } else {
                  // selectedTab == 1 (關閉)
                  controller.interactive(
                    EnumWaterValueTimerSettingPageInteractive.tapCloseTime,
                    data: time,
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class _TimePicker extends StatelessWidget {
  final String title;
  final TimeOfDay? time;
  final Function(TimeOfDay?) onTimeChanged;

  const _TimePicker({
    required this.title,
    required this.time,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hour = time?.hour ?? 8;
    final minute = time?.minute ?? 0;
    final isAM = hour < 12;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 593.0.scale,
          child: CustTextWidget(
            title,
            size: 32.0.scale,
            color: EnumColor.textPrimary.color,
            align: TextAlign.center,
          ),
        ),
        SizedBox(height: 48.0.scale),
        SizedBox(
          width: double.infinity,
          height: 228.0.scale,
          child: Stack(
            children: [
              // 选中背景条
              Positioned(
                left: 0,
                top: 61.0.scale,
                child: Opacity(
                  opacity: 0.30,
                  child: Container(
                    width: 594.0.scale,
                    height: 46.0.scale,
                    padding: EdgeInsets.all(10.0.scale),
                    decoration: BoxDecoration(
                      color: EnumColor.textSecondary.color.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              // 时间选择器内容
              Positioned(
                left: 164.0.scale,
                top: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 上午/下午选择
                    SizedBox(
                      width: 65.0.scale,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final newTime = TimeOfDay(
                                hour: isAM ? hour : hour - 12,
                                minute: minute,
                              );
                              onTimeChanged(newTime);
                            },
                            child: CustTextWidget(
                              EnumLocale.waterValueTimerAM.tr,
                              size: 32.0.scale,
                              color: isAM
                                  ? EnumColor.engoWaterValueStatusOpening.color
                                  : EnumColor.textSecondary.color,
                            ),
                          ),
                          SizedBox(height: 24.0.scale),
                          GestureDetector(
                            onTap: () {
                              final newTime = TimeOfDay(
                                hour: isAM ? hour + 12 : hour,
                                minute: minute,
                              );
                              onTimeChanged(newTime);
                            },
                            child: CustTextWidget(
                              EnumLocale.waterValueTimerPM.tr,
                              size: 32.0.scale,
                              color: !isAM
                                  ? EnumColor.engoWaterValueStatusOpening.color
                                  : EnumColor.textSecondary.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 88.0.scale),
                    // 小时选择
                    SizedBox(
                      width: 38.0.scale,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int h = 8; h <= 11; h++) ...[
                            GestureDetector(
                              onTap: () {
                                final newTime = TimeOfDay(
                                  hour: isAM ? h : h + 12,
                                  minute: minute,
                                );
                                onTimeChanged(newTime);
                              },
                              child: CustTextWidget(
                                h.toString().padLeft(2, '0'),
                                size: 32.0.scale,
                                color: (isAM ? h : h + 12) == hour
                                    ? EnumColor.engoWaterValueStatusOpening.color
                                    : EnumColor.textSecondary.color,
                              ),
                            ),
                            if (h < 11) SizedBox(height: 24.0.scale),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: 88.0.scale),
                    // 分钟选择
                    SizedBox(
                      width: 38.0.scale,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int m in [55, 0, 5, 10]) ...[
                            GestureDetector(
                              onTap: () {
                                final newTime = TimeOfDay(
                                  hour: hour,
                                  minute: m,
                                );
                                onTimeChanged(newTime);
                              },
                              child: CustTextWidget(
                                m.toString().padLeft(2, '0'),
                                size: 32.0.scale,
                                color: m == minute
                                    ? EnumColor.engoWaterValueStatusOpening.color
                                    : EnumColor.textSecondary.color,
                              ),
                            ),
                            if (m != 10) SizedBox(height: 24.0.scale),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RepeatSection extends StatelessWidget {
  const _RepeatSection();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerSettingPageController>();
    return Obx(
      () {
        final isEnabled = controller.isRepeatEnabledRx.value;
        return Container(
          width: 1195.0.scale,
          height: 74.0.scale,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
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
                  GestureDetector(
                    onTap: () {
                      controller.interactive(EnumWaterValueTimerSettingPageInteractive.tapRepeatToggle);
                    },
                    child: Container(
                      width: 101.0.scale,
                      height: 58.0.scale,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: isEnabled
                                    ? EnumColor.engoWaterValueStatusOpening.color
                                    : EnumColor.textSecondary.color,
                                borderRadius: BorderRadius.circular(30.0.scale),
                              ),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            left: isEnabled ? 50.50.scale : 7.31.scale,
                            top: 8.44.scale,
                            child: Container(
                              width: 42.08.scale,
                              height: 42.18.scale,
                              decoration: ShapeDecoration(
                                color: EnumColor.textWhite.color,
                                shape: const OvalBorder(),
                                shadows: [
                                  BoxShadow(
                                    color: EnumColor.shadowCard.color,
                                    blurRadius: 6.0.scale,
                                    offset: Offset(0, 5.0.scale),
                                    spreadRadius: 0,
                                  ),
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
              SizedBox(height: 16.0.scale),
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
          ),
        );
      },
    );
  }
}

class _WeekdaySelector extends StatelessWidget {
  const _WeekdaySelector();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerSettingPageController>();
    return Obx(
      () {
        final selectedWeekday = controller.selectedWeekdayRx.value;
        return Container(
          width: 1195.0.scale,
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
                    controller.interactive(EnumWaterValueTimerSettingPageInteractive.tapWeekday, data: 0);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedWeekday == 0
                          ? EnumColor.engoWaterValueFunctionCardBorder.color
                          : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0.scale),
                        bottomLeft: Radius.circular(12.0.scale),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CustTextWidget(
                      EnumLocale.waterValueTimerWeekday.tr,
                      size: 32.0.scale,
                      color: selectedWeekday == 0
                          ? EnumColor.textWhite.color
                          : EnumColor.textSecondary.color,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.interactive(EnumWaterValueTimerSettingPageInteractive.tapWeekday, data: 1);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: CustTextWidget(
                      EnumLocale.waterValueTimerEveryday.tr,
                      size: 32.0.scale,
                      color: selectedWeekday == 1
                          ? EnumColor.textWhite.color
                          : EnumColor.textSecondary.color,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.interactive(EnumWaterValueTimerSettingPageInteractive.tapWeekday, data: 2);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedWeekday == 2
                          ? EnumColor.engoWaterValueFunctionCardBorder.color
                          : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.0.scale),
                        bottomRight: Radius.circular(12.0.scale),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CustTextWidget(
                      EnumLocale.waterValueTimerCustom.tr,
                      size: 32.0.scale,
                      color: selectedWeekday == 2
                          ? EnumColor.textWhite.color
                          : EnumColor.textSecondary.color,
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
            final isSelected = selectedDays.contains(index);
            return Padding(
              padding: EdgeInsets.only(right: index < 6 ? 48.0.scale : 0),
              child: GestureDetector(
                onTap: () {
                  controller.interactive(
                    EnumWaterValueTimerSettingPageInteractive.tapDay,
                    data: index,
                  );
                },
                child: Container(
                  width: 100.0.scale,
                  height: 100.0.scale,
                  decoration: ShapeDecoration(
                    color: isSelected
                        ? EnumColor.engoWaterValueStatusOpening.color
                        : EnumColor.engoBottomSheetBackground.color,
                    shape: const OvalBorder(),
                  ),
                  child: Center(
                    child: CustTextWidget(
                      weekdayLabels[index].tr,
                      size: 26.0.scale,
                    color: isSelected
                        ? EnumColor.textWhite.color
                        : EnumColor.textSecondary.color,
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

class _NoteSection extends StatefulWidget {
  const _NoteSection();

  @override
  State<_NoteSection> createState() => _NoteSectionState();
}

class _NoteSectionState extends State<_NoteSection> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    final pageController = Get.find<WaterValueTimerSettingPageController>();
    _textController = TextEditingController(text: pageController.noteTextRx.value);
    // 监听 model 的变化，同步到 controller
    ever(pageController.noteTextRx.rx, (value) {
      if (_textController.text != value) {
        _textController.text = value;
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageController = Get.find<WaterValueTimerSettingPageController>();
    return Container(
      width: 1195.0.scale,
      height: 74.0.scale,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
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
                    controller: _textController,
                    onChanged: (value) {
                      pageController.updateNoteText(value);
                    },
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
          SizedBox(height: 16.0.scale),
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
      ),
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
        final isEnabled = controller.isNotificationEnabledRx.value;
        return Container(
          width: 1195.0.scale,
          height: 74.0.scale,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustTextWidget(
                    EnumLocale.waterValueTimerExecuteNotification.tr,
                    size: 32.0.scale,
                    color: EnumColor.textPrimary.color,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.interactive(EnumWaterValueTimerSettingPageInteractive.tapNotificationToggle);
                    },
                    child: Container(
                      width: 101.0.scale,
                      height: 58.0.scale,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: isEnabled
                                    ? EnumColor.engoWaterValueStatusOpening.color
                                    : EnumColor.textSecondary.color,
                                borderRadius: BorderRadius.circular(30.0.scale),
                              ),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            left: isEnabled ? 50.50.scale : 7.31.scale,
                            top: 8.44.scale,
                            child: Container(
                              width: 42.08.scale,
                              height: 42.18.scale,
                              decoration: ShapeDecoration(
                                color: EnumColor.textWhite.color,
                                shape: const OvalBorder(),
                                shadows: [
                                  BoxShadow(
                                    color: EnumColor.shadowCard.color,
                                    blurRadius: 6.0.scale,
                                    offset: Offset(0, 5.0.scale),
                                    spreadRadius: 0,
                                  ),
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
              SizedBox(height: 16.0.scale),
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
          ),
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
