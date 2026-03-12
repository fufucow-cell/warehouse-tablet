import 'package:engo_terminal_app3/wh/feature/reservation/page/main/reservation_main_page_model.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter/material.dart';

class RecordCell extends StatelessWidget {
  final RecordItemModel item;

  const RecordCell({
    super.key,
    required this.item,
  });

  String _fmt(DateTime dt) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${dt.year}/${two(dt.month)}/${two(dt.day)} ${two(dt.hour)}:${two(dt.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final info = item.itemReservableInfo;
    final locationText = [
      info.categoryLv1Text,
      info.categoryLv2Text,
      info.categoryLv3Text,
    ].where((e) => e.trim().isNotEmpty).join(' / ');

    return Material(
      color: Colors.transparent,
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
            Container(
              width: 260.0.scale,
              height: 170.0.scale,
              decoration: BoxDecoration(
                color: EnumColor.backgroundSecondary.color,
                borderRadius: BorderRadius.circular(16.0.scale),
              ),
              child: Icon(
                Icons.image_outlined,
                size: 48.0.scale,
                color: EnumColor.iconSecondary.color,
              ),
            ),
            SizedBox(width: 24.0.scale),
            // Right: info
            Expanded(
              child: _InfoBlock(
                title: info.name,
                location: locationText,
                startTimeText: _fmt(item.bookingStartAt),
                endTimeText: _fmt(item.bookingEndAt),
                orderTypeText: item.orderType.title,
                orderTypeColor: item.orderType.color,
              ),
            ),
          ],
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

  TextStyle _labelStyle() {
    return TextStyle(
      fontSize: 22.0.scale,
      color: EnumColor.textSecondary.color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 30.0.scale,
            fontWeight: FontWeight.w700,
            color: EnumColor.textPrimary.color,
          ),
        ),
        SizedBox(height: 8.0.scale),
        Text(
          location,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: _labelStyle(),
        ),
        SizedBox(height: 8.0.scale),
        Text(
          '開始：$startTimeText',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: _labelStyle(),
        ),
        SizedBox(height: 4.0.scale),
        Text(
          '結束：$endTimeText',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: _labelStyle(),
        ),
        SizedBox(height: 8.0.scale),
        Text(
          orderTypeText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 22.0.scale,
            color: orderTypeColor,
          ),
        ),
      ],
    );
  }
}
