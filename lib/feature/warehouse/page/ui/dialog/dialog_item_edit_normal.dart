import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class DialogItemEditNormal extends StatelessWidget {
  const DialogItemEditNormal({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogFrame(
      header: DialogHeader(title: EnumLocale.warehouseItemEdit.tr),
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
          _PhotoSection(),
          SizedBox(height: 24.0.scale),
          _NameField(),
          SizedBox(height: 24.0.scale),
          _DescriptionField(),
          SizedBox(height: 24.0.scale),
          _MinStockAlertField(),
          SizedBox(height: 24.0.scale),
          _CategoryField(),
        ],
      ),
    );
  }
}

class _PhotoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          EnumLocale.warehousePhotoLabel.tr,
          size: 26.0.scale,
          color: EnumColor.textSecondary.color,
        ),
        SizedBox(height: 12.0.scale),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _PhotoPreview(),
            SizedBox(width: 24.0.scale),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ChangePhotoButton(),
                SizedBox(height: 12.0.scale),
                _DeletePhotoButton(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _PhotoPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0.scale),
      child: Container(
        width: 360.0.scale,
        height: 200.0.scale,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://placehold.co/360x200'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: EnumColor.backgroundSecondary.color.withOpacity(0.3),
        ),
      ),
    );
  }
}

class _ChangePhotoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // TODO: 实现更换照片逻辑
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 32.0.scale,
          vertical: 16.0.scale,
        ),
        side: BorderSide(
          width: 1.0.scale,
          color: EnumColor.textLink.color,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0.scale),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.image_outlined,
            size: 32.0.scale,
            color: EnumColor.textLink.color,
          ),
          SizedBox(width: 12.0.scale),
          WidgetUtil.textWidget(
            '更換照片',
            size: 26.0.scale,
            color: EnumColor.textLink.color,
          ),
        ],
      ),
    );
  }
}

class _DeletePhotoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // TODO: 实现删除照片逻辑
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 32.0.scale,
          vertical: 16.0.scale,
        ),
        side: BorderSide(
          width: 1.0.scale,
          color: EnumColor.accentRed.color,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0.scale),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.delete_outline,
            size: 32.0.scale,
            color: EnumColor.accentRed.color,
          ),
          SizedBox(width: 12.0.scale),
          WidgetUtil.textWidget(
            '刪除照片',
            size: 26.0.scale,
            color: EnumColor.accentRed.color,
          ),
        ],
      ),
    );
  }
}

class _NameField extends StatelessWidget {
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
              EnumLocale.createItemName.tr,
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
            controller: TextEditingController(text: '黑色金屬玻璃'),
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

class _DescriptionField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.0.scale,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetUtil.textWidget(
            EnumLocale.warehouseDescriptionLabel.tr,
            size: 26.0.scale,
            color: EnumColor.textSecondary.color,
          ),
          SizedBox(height: 12.0.scale),
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
              child: TextField(
                controller: TextEditingController(
                  text: '這是一個來自的黑色玻璃杯，帶有品牌標誌。',
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
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
          ),
        ],
      ),
    );
  }
}

class _MinStockAlertField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          '最低庫存警報',
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
          child: TextField(
            controller: TextEditingController(text: '0'),
            keyboardType: TextInputType.number,
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

class _CategoryField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetUtil.textWidget(
          EnumLocale.warehouseCategory.tr,
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
                  '建築材料> 門',
                  size: 32.0.scale,
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
