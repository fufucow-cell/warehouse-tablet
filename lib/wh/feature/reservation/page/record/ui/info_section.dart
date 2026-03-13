import 'package:engo_terminal_app3/wh/feature/reservation/page/record/reservation_record_page_controller.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationRecordPageController>();
    final item = controller.getRecordItem;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoRow(title: '訂單編號', value: item.orderId),
        spaceH,
        _InfoRow(title: '訂單狀態', value: item.orderType.localeTitle),
        spaceH,
        // _InfoRow(title: '生成日期', value: controller.formatDateTime(item.createdAt)),
        spaceH,
        // _InfoRow(title: '付款狀態', value: controller.selectedPaymentStatusRx.value.title),
        spaceH,
        // _InfoRow(title: '付款日期', value: controller.formatDateTime(item.createdAt)),
        spaceH,
        // _InfoRow(title: '開票狀態', value: controller.selectedTicketStatusRx.value.title),
        spaceH,
        // _InfoRow(title: '開票日期', value: controller.formatDateTime(item.createdAt)),
        spaceH,
        // _InfoRow(title: '最後修改日期', value: controller.formatDateTime(item.createdAt)),
        spaceH,
        const _InfoRow(title: '使用密碼', value: '1357'),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustTextWidget(
          title,
          size: 36.0.scale,
          color: EnumColor.textPrimary.color,
          weightType: EnumFontWeightType.bold,
        ),
        spaceW,
        CustTextWidget(
          value,
          size: 28.0.scale,
          color: EnumColor.textPrimary.color,
        ),
      ],
    );
  }
}

Widget get spaceH => SizedBox(height: 12.0.scale);
Widget get spaceW => SizedBox(width: 12.0.scale);
