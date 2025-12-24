import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class DialogCategoryEdit extends StatelessWidget {
  final Category? category;

  const DialogCategoryEdit({
    super.key,
    this.category,
  });

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
          _CurrentCategoryInfo(),
          SizedBox(height: 24.0.scale),
          _Level1Field(),
          SizedBox(height: 24.0.scale),
          _Level2Field(),
        ],
      ),
    );
  }
}

class _CurrentCategoryInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetUtil.textWidget(
      '現在分類： 衛浴用品 > 毛巾',
      size: 28.0.scale,
      color: EnumColor.textPrimary.color,
    );
  }
}

class _Level1Field extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          EnumLocale.createLevel1.tr,
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
          child: Row(
            children: [
              Expanded(
                child: WidgetUtil.textWidget(
                  '衛浴用品',
                  size: 32.0.scale,
                  color: EnumColor.textPrimary.color,
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

class _Level2Field extends StatelessWidget {
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
              '第二層分類名稱',
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
            controller: TextEditingController(text: '毛巾'),
            style: TextStyle(
              fontSize: 32.0.scale,
              color: EnumColor.textPrimary.color,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
