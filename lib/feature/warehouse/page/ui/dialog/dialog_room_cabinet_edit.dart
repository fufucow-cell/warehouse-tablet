import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class DialogRoomCabinetEdit extends StatelessWidget {
  const DialogRoomCabinetEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogFrame(
      header: DialogHeader(title: EnumLocale.commonEdit.tr),
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
          _RoomNameField(),
          SizedBox(height: 24.0.scale),
          _CabinetField(
            label: '櫥櫃一',
            value: '側櫥櫃',
            onDelete: () {
              // TODO: 实现删除逻辑
            },
          ),
          SizedBox(height: 24.0.scale),
          _CabinetField(
            label: '櫥櫃二',
            value: '主櫥櫃',
            onDelete: () {
              // TODO: 实现删除逻辑
            },
          ),
          SizedBox(height: 24.0.scale),
          _CabinetField(
            label: '櫥櫃三',
            value: null,
            onDelete: () {
              // TODO: 实现删除逻辑
            },
          ),
        ],
      ),
    );
  }
}

class _RoomNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          '房間名稱',
          size: 26.0.scale,
          color: EnumColor.textSecondary.color,
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
          child: WidgetUtil.textWidget(
            '辦公室',
            size: 32.0.scale,
            color: EnumColor.textSecondary.color,
          ),
        ),
      ],
    );
  }
}

class _CabinetField extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onDelete;

  const _CabinetField({
    required this.label,
    this.value,
    required this.onDelete,
  });

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
              label,
              size: 26.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ],
        ),
        SizedBox(height: 12.0.scale),
        Row(
          children: [
            Expanded(
              child: Container(
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
                child: value != null
                    ? WidgetUtil.textWidget(
                        value!,
                        size: 32.0.scale,
                        color: EnumColor.textPrimary.color,
                      )
                    : TextField(
                        style: TextStyle(
                          fontSize: 32.0.scale,
                          color: EnumColor.textPrimary.color,
                        ),
                        decoration: InputDecoration(
                          hintText: '請輸入',
                          hintStyle: TextStyle(
                            fontSize: 32.0.scale,
                            color: EnumColor.textSecondary.color,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
              ),
            ),
            SizedBox(width: 12.0.scale),
            Container(
              width: 70.0.scale,
              height: 70.0.scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.scale),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onDelete,
                  borderRadius: BorderRadius.circular(12.0.scale),
                  child: Icon(
                    Icons.delete_outline,
                    size: 40.0.scale,
                    color: EnumColor.textPrimary.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
