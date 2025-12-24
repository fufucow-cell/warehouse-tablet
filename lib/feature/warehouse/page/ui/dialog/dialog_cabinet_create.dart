import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class DialogCabinetCreate extends StatelessWidget {
  const DialogCabinetCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogFrame(
      header: DialogHeader(title: EnumLocale.createCabinetTitle.tr),
      footer: DialogFooter(
        type: DialogFooterType.cancelAndConfirm,
        onCancel: () => Navigator.of(context).pop(),
        onConfirm: () {
          // TODO: 实现确认逻辑
          Navigator.of(context).pop();
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CabinetNameField(),
          SizedBox(height: 24.0.scale),
          _RoomField(),
        ],
      ),
    );
  }
}

class _CabinetNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            WidgetUtil.textWidget(
              '*',
              size: 26.0.scale,
              color: EnumColor.accentRed.color,
            ),
            WidgetUtil.textWidget(
              EnumLocale.createCabinetName.tr,
              size: 26.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ],
        ),
        SizedBox(height: 12.0.scale),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 32.0.scale,
            vertical: 16.0.scale,
          ),
          decoration: BoxDecoration(
            color: EnumColor.backgroundSecondary.color,
            border: Border.all(
              width: 1.0.scale,
              color: EnumColor.lineBorder.color,
            ),
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
          child: TextField(
            style: TextStyle(
              fontSize: 32.0.scale,
              color: EnumColor.textPrimary.color,
            ),
            decoration: InputDecoration(
              hintText: EnumLocale.createCabinetNameHint.tr,
              hintStyle: TextStyle(
                fontSize: 32.0.scale,
                color: EnumColor.textSecondary.color,
              ),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}

class _RoomField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            WidgetUtil.textWidget(
              '*',
              size: 26.0.scale,
              color: EnumColor.accentRed.color,
            ),
            WidgetUtil.textWidget(
              EnumLocale.warehouseRoomLabel.tr,
              size: 26.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ],
        ),
        SizedBox(height: 12.0.scale),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 32.0.scale,
            vertical: 16.0.scale,
          ),
          decoration: BoxDecoration(
            color: EnumColor.backgroundSecondary.color,
            border: Border.all(
              width: 1.0.scale,
              color: EnumColor.lineBorder.color,
            ),
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
          child: Row(
            children: [
              Expanded(
                child: WidgetUtil.textWidget(
                  '請選擇',
                  size: 32.0.scale,
                  color: EnumColor.textSecondary.color,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 38.0.scale,
                color: EnumColor.textPrimary.color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
