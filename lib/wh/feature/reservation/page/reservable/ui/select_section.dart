import 'package:engo_terminal_app3/wh/feature/reservation/page/reservable/reservation_reservable_page_controller.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_border_button.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_date_picker_text_field.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_field.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_time_picker_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectSection extends StatelessWidget {
  const SelectSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationReservablePageController>();
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
            title: '預約總額',
            child: CustTextWidget(
              r'$200 / 小時',
              size: 28.0.scale,
              weightType: EnumFontWeightType.semibold,
              color: EnumColor.textPrimary.color,
            ),
          ),
          _spaceH,
          _MetaLine(
            title: '預約日期',
            child: SizedBox(
              height: 70.0.scale,
              child: CustDatePickerTextField(
                selectedDate: controller.dateRx.value,
                firstDate: controller.firstDate,
                lastDate: controller.lastDate,
                onDateSelected: (date) {
                  controller.interactive(EnumReservationReservablePageInteractive.dateChanged, data: date);
                },
              ),
            ),
          ),
          _spaceH,
          _MetaLine(
            title: '開始時間',
            child: SizedBox(
              height: 70.0.scale,
              child: CustTimePickerTextField(
                selectedTime: controller.startTimeRx.value,
                onTimeSelected: (time) {
                  controller.interactive(EnumReservationReservablePageInteractive.startTimeChanged, data: time);
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
                selectedTime: controller.endTimeRx.value,
                onTimeSelected: (time) {
                  controller.interactive(EnumReservationReservablePageInteractive.endTimeChanged, data: time);
                },
              ),
            ),
          ),
          _spaceH,
          _MetaLine(
            title: '成人總數',
            child: CustTextField(
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
              controller: controller.childTextController,
              hintText: '請輸入整數',
              keyboardType: EnumTextFieldType.integer.keyboardType,
              additionalInputFormatters: EnumTextFieldType.integer.inputFormatters,
            ),
          ),
          _spaceH,
          SizedBox(
            height: 100.0.scale,
            child: CustBorderButton(
              text: '預約',
              onTap: () => controller.interactive(EnumReservationReservablePageInteractive.tapConfirm),
            ),
          ),
        ],
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
