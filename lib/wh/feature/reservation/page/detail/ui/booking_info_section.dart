import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/ui/info_section.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingInfoSection extends StatelessWidget {
  const BookingInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationDetailPageController>();
    final item = controller.getReservableItem!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.0.scale),
          CustTextWidget(
            item.name,
            size: 54.0.scale,
            weightType: EnumFontWeightType.bold,
            color: EnumColor.textPrimary.color,
          ),
          _spaceH,
          InfoLine(title: '位置', value: controller.getPositionText),
          _spaceH,
          InfoLine(title: '預約開放日期', value: controller.formatDateTime(item.startAt)),
          _spaceH,
          InfoLine(title: '預約截止日期', value: controller.formatDateTime(item.endAt)),
          _spaceH,
          if (controller.isShowHourLimitText) ...[
            InfoLine(title: '預約時長限制', value: controller.getHourLimitText),
            _spaceH,
          ],
          if (controller.isShowReservationDateRuleTypeText) ...[
            InfoLine(title: '日期規則', value: controller.getReservationDateRuleTypeText),
            _spaceH,
            const InfoLine(title: '可預約時段', value: '(需要改內容)'),
            _spaceH,
          ],
          if (controller.isShowReservationBookingLimitTypeText) ...[
            InfoLine(title: '預約規則', value: controller.getReservationBookingLimitTypeText),
            _spaceH,
          ],
          InfoLine(title: '單次預約人數限制', value: controller.getPerBookingPeopleLimitText),
          _spaceH,
          InfoLine(title: '預約總人數限制', value: controller.getTotalPeopleLimitText),
          _spaceH,
          InfoLine(title: '付費方式', value: controller.getPaymentTypeText),
          _spaceH,
          InfoLine(title: '計費方式', value: controller.getBillingMethodText),
          _spaceH,
          InfoLine(title: '說明', value: item.description),
          _spaceH,
          InfoLine(title: '規格', value: item.specification),
          _spaceH,
          InfoLine(title: '注意事項&限制', value: item.notice),
        ],
      ),
    );
  }

  Widget get _spaceH => SizedBox(height: 12.0.scale);
}
