import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_controller.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecificDateInfo extends StatelessWidget {
  const SpecificDateInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustTextWidget(
          '可預約時段',
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
    final item = controller.getReservableItem;

    if (item == null || item.specificDate.isEmpty) {
      return CustTextWidget(
        '-',
        size: 28.0.scale,
        color: EnumColor.textPrimary.color,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: item.specificDate
          .map(
            (d) => Padding(
              padding: EdgeInsets.only(bottom: 8.0.scale),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustTextWidget(
                    controller.formatDate(d.bookingDate),
                    size: 28.0.scale,
                    color: EnumColor.textPrimary.color,
                  ),
                  SizedBox(width: 16.0.scale),
                  Expanded(
                    child: CustTextWidget(
                      d.isAllDay == true ? '全時段' : '${d.startTime ?? '--:--'} - ${d.endTime ?? '--:--'}',
                      size: 28.0.scale,
                      color: EnumColor.textPrimary.color,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
