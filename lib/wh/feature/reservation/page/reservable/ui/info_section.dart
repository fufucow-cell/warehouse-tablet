import 'package:engo_terminal_app3/wh/feature/reservation/page/reservable/reservation_reservable_page_controller.dart';
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
    final controller = Get.find<ReservationReservablePageController>();
    final item = controller.getReservableItem!;
    final position = '${item.categoryLv1Text} / ${item.categoryLv2Text} / ${item.categoryLv3Text}';
    const openTime = '（週一 ～ 週五）08:00 － 22:00';
    const inviteRule = '同時段多組';
    const peopleLimit = '20';
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
          _MetaLine(title: '位置', value: position),
          _spaceH,
          const _MetaLine(title: '開放時段', value: openTime),
          _spaceH,
          const _MetaLine(title: '招待限制', value: inviteRule),
          _spaceH,
          const _MetaLine(title: '容納人數限制', value: peopleLimit),
          _spaceH,
          const _MetaLine(title: '說明', value: '說明內容（待接 API）'),
          _spaceH,
          const _MetaLine(title: '規格', value: '規格內容（待接 API）'),
          _spaceH,
          const _MetaLine(title: '注意事項&限制', value: '注意事項&限制（待接 API）'),
        ],
      ),
    );
  }

  Widget get _spaceH => SizedBox(height: 12.0.scale);
}

class _MetaLine extends StatelessWidget {
  final String title;
  final String value;
  const _MetaLine({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustTextWidget(
          title,
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
