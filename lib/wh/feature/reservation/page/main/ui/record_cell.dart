import 'package:engo_terminal_app3/wh/feature/reservation/page/main/reservation_main_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_network_image.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordCell extends StatelessWidget {
  final RecordItemModel item;

  const RecordCell({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationMainPageController>();
    final info = item.itemReservableInfo;
    final locationText = [
      info.categoryLv1Text,
      info.categoryLv2Text,
      info.categoryLv3Text,
    ].where((e) => e.trim().isNotEmpty).join(' / ');
    final imageUrl = info.imageUrls.firstOrNull ?? '';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          controller.interactive(
              EnumReservationMainPageInteractive.tapRecordItem,
              data: item);
        },
        child: Container(
          padding: EdgeInsets.all(24.0.scale),
          decoration: BoxDecoration(
            color: EnumColor.backgroundPrimary.color,
            borderRadius: BorderRadius.circular(20.0.scale),
            border: Border.all(
              width: 1.0.scale,
              color: EnumColor.lineDividerLight.color,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: preview image
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: EnumColor.backgroundSecondary.color,
                    borderRadius: BorderRadius.circular(16.0.scale),
                  ),
                  child: CustNetworkImage(url: imageUrl),
                ),
              ),
              SizedBox(width: 24.0.scale),
              // Right: info
              Expanded(
                flex: 3,
                child: _InfoBlock(
                  title: info.name,
                  location: locationText,
                  startTimeText: controller.formatDateTime(item.bookingStartAt),
                  endTimeText: controller.formatDateTime(item.bookingEndAt),
                  orderTypeText: item.orderType.localeTitle,
                  orderTypeColor: item.orderType.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String title;
  final String location;
  final String startTimeText;
  final String endTimeText;
  final String orderTypeText;
  final Color orderTypeColor;

  const _InfoBlock({
    required this.title,
    required this.location,
    required this.startTimeText,
    required this.endTimeText,
    required this.orderTypeText,
    required this.orderTypeColor,
  });

  @override
  Widget build(BuildContext context) {
    final textSize = 36.0.scale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustTextWidget(
          title,
          size: textSize,
          weightType: EnumFontWeightType.bold,
          color: EnumColor.textPrimary.color,
        ),
        SizedBox(height: 8.0.scale),
        CustTextWidget(
          location,
          size: textSize * 0.8,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 8.0.scale),
        CustTextWidget(
          '開始：$startTimeText',
          size: textSize * 0.8,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 4.0.scale),
        CustTextWidget(
          '結束：$endTimeText',
          size: textSize * 0.8,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 8.0.scale),
        CustTextWidget(
          orderTypeText,
          size: textSize * 0.8,
          color: orderTypeColor,
        ),
      ],
    );
  }
}
