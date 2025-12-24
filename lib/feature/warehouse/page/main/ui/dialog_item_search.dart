import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class DialogItemSearch extends StatelessWidget {
  const DialogItemSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogFrame(
      maxWidth: 720.0,
      header: DialogHeader(title: EnumLocale.commonSearch.tr),
      footer: DialogFooter(
        type: DialogFooterType.cancelAndConfirm,
        onCancel: () => Navigator.of(context).pop(),
        onConfirm: () {
          // TODO: 实现搜索逻辑
          Navigator.of(context).pop();
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SearchField(),
          SizedBox(height: 24.0.scale),
          _CategoryField(),
          SizedBox(height: 24.0.scale),
          _SubCategoryField(),
          SizedBox(height: 24.0.scale),
          _RoomField(),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.0.scale,
      padding: EdgeInsets.symmetric(
        horizontal: 32.0.scale,
        vertical: 16.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundPrimary.color,
        border: Border.all(
          width: 1.0.scale,
          color: EnumColor.lineBorder.color,
        ),
        borderRadius: BorderRadius.circular(16.0.scale),
      ),
      child: Row(
        children: [
          EnumImage.cSearch.image(
            size: Size.square(38.0.scale),
            color: EnumColor.textSecondary.color,
          ),
          SizedBox(width: 16.0.scale),
          Expanded(
            child: TextField(
              style: TextStyle(
                fontSize: 32.0.scale,
                color: EnumColor.textPrimary.color,
              ),
              decoration: InputDecoration(
                hintText: EnumLocale.searchNameHintItem.tr,
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
      ),
    );
  }
}

class _CategoryField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          EnumLocale.searchCategory.tr,
          size: 26.0.scale,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 12.0.scale),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 32.0.scale,
            vertical: 16.0.scale,
          ),
          decoration: BoxDecoration(
            color: EnumColor.backgroundPrimary.color,
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
                  EnumLocale.optionNotSet.tr,
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

class _SubCategoryField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          EnumLocale.searchCategoryLevel2.tr,
          size: 26.0.scale,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 12.0.scale),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 32.0.scale,
            vertical: 16.0.scale,
          ),
          decoration: BoxDecoration(
            color: EnumColor.backgroundPrimary.color,
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
                  EnumLocale.optionNotSet.tr,
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

class _RoomField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          EnumLocale.searchRoom.tr,
          size: 26.0.scale,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 12.0.scale),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 32.0.scale,
            vertical: 16.0.scale,
          ),
          decoration: BoxDecoration(
            color: EnumColor.backgroundPrimary.color,
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
                  EnumLocale.optionNotSet.tr,
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
