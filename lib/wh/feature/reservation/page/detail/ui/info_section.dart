import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/ui/booking_info_section.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/ui/record_info_section.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_tab_bar.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationDetailPageController>();

    if (controller.isReservableDetail) {
      return const BookingInfoSection();
    }

    return Obx(
      () {
        return Column(
          children: [
            CustTabBar(
              titles: controller.getInfoTabTitles,
              selectedIndex: controller.infoTabTypeRx.value.index,
              onChanged: (index) => controller.interactive(
                EnumReservationDetailPageInteractive.tapInfoTabItem,
                data: index,
              ),
            ),
            _spaceH,
            Expanded(
              child: controller.infoTabTypeRx.value == EnumReservationInfoTabType.order ? const RecordInfoSection() : const BookingInfoSection(),
            ),
          ],
        );
      },
    );
  }

  Widget get _spaceH => SizedBox(height: 12.0.scale);
}

class InfoLine extends StatelessWidget {
  final String title;
  final String value;
  const InfoLine({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustTextWidget(
          '$title:',
          size: 32.0.scale,
          weightType: EnumFontWeightType.bold,
          color: EnumColor.textPrimary.color,
        ),
        _spaceW,
        Expanded(
          child: CustTextWidget(
            value,
            size: 28.0.scale,
            color: EnumColor.textPrimary.color,
          ),
        ),
      ],
    );
  }

  Widget get _spaceW => SizedBox(width: 12.0.scale);
}
