import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_empty_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_list/water_value_timer_list_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_list/water_value_timer_list_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/timer_setting/ui/cust_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterValueTimerListPage extends GetView<WaterValueTimerListPageController> {
  final WaterValueTimerListPageRouterData routerData;
  const WaterValueTimerListPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaterValueTimerListPageController>(
      init: WaterValueTimerListPageController(routerData),
      builder: (controller) {
        return Scaffold(
          body: FirstBackgroundCard(
            child: Column(
              children: [
                const _TopBar(),
                SizedBox(height: 48.0.scale),
                Expanded(
                  child: Obx(
                    () {
                      final items = controller.timerItemsRx.value;
                      if (items.isEmpty) {
                        return const CustEmptyWidget();
                      }
                      return const _TimerList();
                    },
                  ),
                ),
                SizedBox(height: 32.0.scale),
                const _AddButton(),
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
    final controller = Get.find<WaterValueTimerListPageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            controller.interactive(EnumWaterValueTimerListPageInteractive.tapBackButton);
          },
        ),
        Expanded(
          child: Center(
            child: CustTextWidget(
              EnumLocale.waterValueTimerList.tr,
              size: 40.0.scale,
              weightType: EnumFontWeightType.bold,
              color: EnumColor.textPrimary.color,
            ),
          ),
        ),
        CustIconButton(
          icon: EnumImage.cPencilLine,
          size: 62.0.scale,
          color: EnumColor.engoTextPrimary.color,
          onTap: () {
            controller.interactive(EnumWaterValueTimerListPageInteractive.tapSettingButton);
          },
        ),
      ],
    );
  }
}

class _TimerList extends StatelessWidget {
  const _TimerList();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerListPageController>();
    return Obx(
      () {
        final items = controller.timerItemsRx.value;
        final isEditMode = controller.isEditModeRx.value;
        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            thickness: 1,
            color: EnumColor.lineDividerLight.color,
          ),
          itemBuilder: (context, index) {
            return _TimerItemCell(
              item: items[index],
              isEditMode: isEditMode,
            );
          },
        );
      },
    );
  }
}

class _TimerItemCell extends StatelessWidget {
  final WaterValueTimerInfo item;
  final bool isEditMode;

  const _TimerItemCell({
    required this.item,
    required this.isEditMode,
  });

  String _formatTime(TimeOfDay? time) {
    if (time == null) {
      return '-';
    }
    final hour = time.hour;
    final minute = time.minute;
    final period = hour < 12 ? EnumLocale.waterValueTimerAM.tr : EnumLocale.waterValueTimerPM.tr;
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$period ${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  String _formatRepeatCycle() {
    if (item.isRepeat != true) {
      return EnumLocale.waterValueTimerExecuteOnce.tr;
    }
    final ed = item.enumRepeatDay;
    if (ed == EnumRepeatDay.weekday) {
      return EnumLocale.waterValueTimerWeekday.tr;
    }
    if (ed == EnumRepeatDay.everyday) {
      return EnumLocale.waterValueTimerEveryday.tr;
    }
    final days = item.selectedDays ?? <int>{};
    if (days.isEmpty) {
      return EnumLocale.waterValueTimerExecuteOnce.tr;
    }
    final dayNames = [
      EnumLocale.waterValueTimerMonday.tr,
      EnumLocale.waterValueTimerTuesday.tr,
      EnumLocale.waterValueTimerWednesday.tr,
      EnumLocale.waterValueTimerThursday.tr,
      EnumLocale.waterValueTimerFriday.tr,
      EnumLocale.waterValueTimerSaturday.tr,
      EnumLocale.waterValueTimerSunday.tr,
    ];
    final sorted = days.toList()..sort();
    return sorted.map((day) => dayNames[day - 1]).join('、');
  }

  String _getActionText() => item.enumStatus?.title ?? '-';

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerListPageController>();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 24.0.scale,
        horizontal: 32.0.scale,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.interactive(
                  EnumWaterValueTimerListPageInteractive.tapCell,
                  data: item,
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (item.time != null)
                        CustTextWidget(
                          _formatTime(item.time),
                          size: 28.0.scale,
                          color: EnumColor.textPrimary.color,
                        ),
                    ],
                  ),
                  SizedBox(height: 12.0.scale),
                  CustTextWidget(
                    _formatRepeatCycle(),
                    size: 24.0.scale,
                    color: EnumColor.textSecondary.color,
                  ),
                  SizedBox(height: 12.0.scale),
                  Row(
                    children: [
                      CustTextWidget(
                        '${EnumLocale.waterValueStatus.tr}: ${_getActionText()}',
                        size: 24.0.scale,
                        color: EnumColor.textSecondary.color,
                      ),
                      SizedBox(width: 24.0.scale),
                      CustTextWidget(
                        '${EnumLocale.waterValueTimerExecuteNotification.tr}: ${(item.isNotify ?? false) ? EnumLocale.waterValueOpen.tr : EnumLocale.waterValueClose.tr}',
                        size: 24.0.scale,
                        color: EnumColor.textSecondary.color,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.0.scale),
          // Switch 或删除按钮
          Obx(
            () {
              final isEditMode = controller.isEditModeRx.value;
              if (isEditMode) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.interactive(
                        EnumWaterValueTimerListPageInteractive.tapDeleteButton,
                        data: item,
                      );
                    },
                    borderRadius: BorderRadius.circular(20.0.scale),
                    child: Ink(
                      padding: EdgeInsets.all(15.0.scale),
                      child: EnumImage.cTrash3.image(
                        size: Size.square(40.0.scale),
                        color: EnumColor.iconSecondary.color,
                      ),
                    ),
                  ),
                );
              } else {
                return CustToggleSwitch(
                  value: item.isEnable ?? false,
                  onTap: () {
                    controller.interactive(
                      EnumWaterValueTimerListPageInteractive.tapToggleSwitch,
                      data: item,
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerListPageController>();
    return GestureDetector(
      onTap: () {
        controller.interactive(EnumWaterValueTimerListPageInteractive.tapAddTimerButton);
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
          EnumLocale.waterValueTimerAddNew.tr,
          size: 32.0.scale,
          color: EnumColor.textWhite.color,
        ),
      ),
    );
  }
}
