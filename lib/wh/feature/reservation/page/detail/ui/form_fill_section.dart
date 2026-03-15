import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_border_button.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_date_picker_text_field.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_dropdown_menu_button.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_field.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_time_picker_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormFillSection extends StatelessWidget {
  const FormFillSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationDetailPageController>();
    final canEdit = controller.isReservableDetail;
    return Container(
      padding: EdgeInsets.all(16.0.scale),
      decoration: BoxDecoration(
        color: EnumColor.backgroundPrimary.color,
        borderRadius: BorderRadius.circular(12.0.scale),
        gradient: LinearGradient(
          colors: EnumColor.backgroundItemGradient.colors,
        ),
        border: Border.all(
          width: 3.0.scale,
          color: EnumColor.lineDividerLight.color,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MetaLine(
            title: '預約日期',
            child: SizedBox(
              height: 70.0.scale,
              child: _buildDateSelector(controller, canEdit),
            ),
          ),
          _spaceH,
          _MetaLine(
            title: '開始時間',
            child: SizedBox(
              height: 70.0.scale,
              child: CustTimePickerTextField(
                canEdit: canEdit,
                selectedTime: controller.startTimeRx.value,
                onTimeSelected: (time) {
                  controller.interactive(
                    EnumReservationDetailPageInteractive.startTimeChanged,
                    data: time,
                  );
                },
              ),
            ),
          ),
          _spaceH,
          _MetaLine(
            title: '結束時間',
            child: SizedBox(
              height: 70.0.scale,
              child: CustTimePickerTextField(
                canEdit: canEdit,
                selectedTime: controller.endTimeRx.value,
                onTimeSelected: (time) {
                  controller.interactive(
                    EnumReservationDetailPageInteractive.endTimeChanged,
                    data: time,
                  );
                },
              ),
            ),
          ),
          _spaceH,
          _MetaLine(
            title: '成人總數',
            child: CustTextField(
              isReadOnly: !canEdit,
              controller: controller.adultTextController,
              hintText: '請輸入整數',
              keyboardType: EnumTextFieldType.integer.keyboardType,
              additionalInputFormatters: EnumTextFieldType.integer.inputFormatters,
            ),
          ),
          _spaceH,
          _MetaLine(
            title: '兒童總數',
            child: CustTextField(
              isReadOnly: !canEdit,
              controller: controller.childTextController,
              hintText: '請輸入整數',
              keyboardType: EnumTextFieldType.integer.keyboardType,
              additionalInputFormatters: EnumTextFieldType.integer.inputFormatters,
            ),
          ),
          _spaceH,
          Obx(
            () {
              controller.startTimeRx.value;
              controller.endTimeRx.value;
              return Row(
                children: [
                  Expanded(
                    child: _MetaLine(
                      title: '支付總額',
                      child: CustTextWidget(
                        controller.totalBillingRx.value,
                        size: 28.0.scale,
                        weightType: EnumFontWeightType.semibold,
                        color: EnumColor.textPrimary.color,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0.scale),
                  Expanded(
                    child: _MetaLine(
                      title: '預約時長',
                      child: Obx(
                        () => CustTextWidget(
                          controller.totalDurationRx.value,
                          size: 28.0.scale,
                          weightType: EnumFontWeightType.semibold,
                          color: EnumColor.textPrimary.color,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          _spaceH,
          SizedBox(
            height: 100.0.scale,
            child: CustBorderButton(
              text: '預約',
              onTap: () => controller.interactive(EnumReservationDetailPageInteractive.tapConfirm),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(
    ReservationDetailPageController controller,
    bool canEdit,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : null;

        final ruleType = controller.dateRuleType;

        if (ruleType == EnumReservationDateRuleType.unlimited) {
          return CustDatePickerTextField(
            canEdit: canEdit,
            selectedDate: controller.dateRx.value,
            firstDate: controller.firstDate,
            lastDate: controller.lastDate,
            onDateSelected: (date) {
              controller.interactive(
                EnumReservationDetailPageInteractive.dateChanged,
                data: date,
              );
            },
          );
        }

        if (ruleType == EnumReservationDateRuleType.none) {
          final list = controller.getSpecificDateList;

          if (list.isEmpty) {
            return _dateDropdownPlaceholder();
          }

          final values = list.map((d) => controller.formatDate(d.bookingDate)).toList();
          return Obx(() {
            final selected = controller.selectedDateDisplayForSpecificDate;
            return CustDropdownMenuButton.popupMenuButton(
              selectedValue: values.contains(selected) ? selected : null,
              values: values,
              placeholder: '請選擇日期',
              placeholderColor: EnumColor.textSecondary.color,
              onValueSelected: (v) {
                if (v != null) {
                  controller.interactive(
                    EnumReservationDetailPageInteractive.dateChanged,
                    data: v,
                  );
                }
              },
              height: 70.0.scale,
              width: availableWidth,
              enable: canEdit,
            );
          });
        }

        // 每週重複：下拉選單為有 enable 的星期
        final dayList = controller.getEnableWeekDayList();
        if (dayList.isEmpty) {
          return _dateDropdownPlaceholder();
        }
        final values = dayList.map((e) => controller.getWeekDayDisplayText(e.day)).toList();
        return Obx(() {
          final selected = controller.selectedDateDisplayForWeekly;
          return CustDropdownMenuButton.popupMenuButton(
            selectedValue: values.contains(selected) ? selected : null,
            values: values,
            placeholder: '請選擇日期',
            placeholderColor: EnumColor.textSecondary.color,
            onValueSelected: (v) {
              if (v != null) {
                controller.interactive(
                  EnumReservationDetailPageInteractive.dateChanged,
                  data: v,
                );
              }
            },
            height: 70.0.scale,
            width: availableWidth,
            enable: canEdit,
          );
        });
      },
    );
  }

  Widget _dateDropdownPlaceholder() {
    return Container(
      height: 70.0.scale,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16.0.scale),
      decoration: BoxDecoration(
        color: EnumColor.backgroundSecondary.color,
        borderRadius: BorderRadius.circular(8.0.scale),
        border: Border.all(color: EnumColor.lineBorder.color),
      ),
      child: CustTextWidget(
        '無可選日期',
        size: 14.0.scale,
        color: EnumColor.textSecondary.color,
      ),
    );
  }

  Widget get _spaceH => SizedBox(height: 12.0.scale);
}

class _MetaLine extends StatelessWidget {
  final String title;
  final Widget child;

  const _MetaLine({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        CustTextWidget(
          title,
          size: 28.0.scale,
          color: EnumColor.textPrimary.color,
          weightType: EnumFontWeightType.bold,
        ),
        SizedBox(width: 12.0.scale),
        Expanded(child: child),
      ],
    );
  }
}
