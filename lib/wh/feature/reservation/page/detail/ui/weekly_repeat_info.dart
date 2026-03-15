import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_controller.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/weekly_repeat_response_model/period.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeeklyRepeatInfo extends StatelessWidget {
  const WeeklyRepeatInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustTextWidget(
          '可預約時段:',
          size: 32.0.scale,
          weightType: EnumFontWeightType.bold,
          color: EnumColor.textPrimary.color,
        ),
        SizedBox(width: 12.0.scale),
        const Expanded(
          child: _Body(),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationDetailPageController>();
    final dayList = controller.getEnableWeekDayList();

    if (dayList.isEmpty) {
      return CustTextWidget(
        '-',
        size: 28.0.scale,
        color: EnumColor.textPrimary.color,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: dayList
          .map(
            (dayItem) => _DayRow(
              day: controller.getWeekDayDisplayText(dayItem.day),
              isAllDay: dayItem.isAllDay == true,
              periods: dayItem.period ?? [],
            ),
          )
          .toList(),
    );
  }
}

class _DayRow extends StatelessWidget {
  final String day;
  final bool isAllDay;
  final List<Period> periods;

  const _DayRow({
    required this.day,
    required this.isAllDay,
    required this.periods,
  });

  @override
  Widget build(BuildContext context) {
    const dayLabelWidth = 72.0;
    final controller = Get.find<ReservationDetailPageController>();

    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: dayLabelWidth.scale,
            child: CustTextWidget(
              day,
              size: 28.0.scale,
              color: EnumColor.textPrimary.color,
            ),
          ),
          SizedBox(width: 6.0.scale),
          Expanded(
            child: isAllDay
                ? CustTextWidget(
                    '全時段',
                    size: 28.0.scale,
                    color: EnumColor.textPrimary.color,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var i = 0; i < periods.length; i++) ...[
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0.scale),
                          child: CustTextWidget(
                            controller.formatPeriod(periods[i]),
                            size: 28.0.scale,
                            color: EnumColor.textPrimary.color,
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
