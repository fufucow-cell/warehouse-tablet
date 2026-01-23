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
        controller.setContext(context);
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
  final WaterValueTimerItem item;
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
    if (!item.isRepeatEnabled) {
      return EnumLocale.waterValueTimerExecuteOnce.tr;
    }

    switch (item.selectedWeekday) {
      case 0: // 工作日
        return EnumLocale.waterValueTimerWeekday.tr;
      case 1: // 每天
        return EnumLocale.waterValueTimerEveryday.tr;
      case 2: // 自定義
        if (item.selectedDays.isEmpty) {
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
        final selectedDayNames = item.selectedDays.toList()..sort();
        return selectedDayNames.map((day) => dayNames[day]).join('、');
      default:
        return EnumLocale.waterValueTimerExecuteOnce.tr;
    }
  }

  String _getActionText() {
    if (item.openTime != null && item.closeTime != null) {
      return '${EnumLocale.waterValueOpen.tr}/${EnumLocale.waterValueClose.tr}';
    } else if (item.openTime != null) {
      return EnumLocale.waterValueOpen.tr;
    } else if (item.closeTime != null) {
      return EnumLocale.waterValueClose.tr;
    }
    return '-';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueTimerListPageController>();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 24.0.scale,
        horizontal: 32.0.scale,
      ),
      color: EnumColor.backgroundSecondary.color,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 时间
                Row(
                  children: [
                    if (item.openTime != null) ...[
                      CustTextWidget(
                        _formatTime(item.openTime),
                        size: 28.0.scale,
                        color: EnumColor.textPrimary.color,
                      ),
                    ],
                    if (item.openTime != null && item.closeTime != null) ...[
                      SizedBox(width: 16.0.scale),
                      CustTextWidget(
                        '/',
                        size: 28.0.scale,
                        color: EnumColor.textSecondary.color,
                      ),
                      SizedBox(width: 16.0.scale),
                    ],
                    if (item.closeTime != null) ...[
                      CustTextWidget(
                        _formatTime(item.closeTime),
                        size: 28.0.scale,
                        color: EnumColor.textPrimary.color,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 12.0.scale),
                // 重复周期
                CustTextWidget(
                  _formatRepeatCycle(),
                  size: 24.0.scale,
                  color: EnumColor.textSecondary.color,
                ),
                SizedBox(height: 12.0.scale),
                // 水閥狀態和通知狀態
                Row(
                  children: [
                    CustTextWidget(
                      '${EnumLocale.waterValueStatus.tr}: ${_getActionText()}',
                      size: 24.0.scale,
                      color: EnumColor.textSecondary.color,
                    ),
                    SizedBox(width: 24.0.scale),
                    CustTextWidget(
                      '${EnumLocale.waterValueTimerExecuteNotification.tr}: ${item.isNotificationEnabled ? EnumLocale.waterValueOpen.tr : EnumLocale.waterValueClose.tr}',
                      size: 24.0.scale,
                      color: EnumColor.textSecondary.color,
                    ),
                  ],
                ),
              ],
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
                        data: item.id,
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
                return Switch(
                  value: item.isEnabled,
                  onChanged: (value) {
                    controller.interactive(
                      EnumWaterValueTimerListPageInteractive.tapToggleSwitch,
                      data: item.id,
                    );
                  },
                  activeColor: EnumColor.engoWaterValueStatusOpening.color,
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
