import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/ui/info_section.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordInfoSection extends StatelessWidget {
  const RecordInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationDetailPageController>();
    final item = controller.getRecordItem!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.0.scale),
          CustTextWidget(
            controller.getReservableItem?.name ?? '',
            size: 54.0.scale,
            weightType: EnumFontWeightType.bold,
            color: EnumColor.textPrimary.color,
          ),
          _spaceH,
          InfoLine(title: '訂單編號', value: item.orderId),
          _spaceH,
          InfoLine(title: '訂單狀態', value: item.orderType.localeTitle),
          _spaceH,
          InfoLine(
              title: '生成日期', value: controller.formatDateTime(item.createdAt)),
          _spaceH,
          InfoLine(title: '付款狀態', value: item.paymentType.localeTitle),
          _spaceH,
          InfoLine(
              title: '付款日期',
              value: controller.formatDateTime(item.paymentCreatedAt)),
          _spaceH,
          InfoLine(title: '開票狀態', value: item.ticketType.localeTitle),
          _spaceH,
          InfoLine(
              title: '開票日期',
              value: controller.formatDateTime(item.ticketCreatedAt)),
          _spaceH,
          InfoLine(
              title: '最後修改日期',
              value: controller.formatDateTime(item.updatedAt)),
          _spaceH,
          InfoLine(title: '使用密碼', value: item.controlKey),
        ],
      ),
    );
  }

  Widget get _spaceH => SizedBox(height: 12.0.scale);
}
