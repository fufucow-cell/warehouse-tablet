import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog_section_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class DialogWithPhotoWidget extends StatelessWidget {
  final Widget imageWidget;
  final VoidCallback? onReplacePhoto;
  final VoidCallback? onDeletePhoto;

  const DialogWithPhotoWidget({
    super.key,
    required this.imageWidget,
    this.onReplacePhoto,
    this.onDeletePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return DialogSectionWidget(
      title: '物品照片',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0.scale),
            child: imageWidget,
          ),
          SizedBox(width: 24.0.scale),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PhotoActionButton(
                eImage: EnumImage.cChangeImage,
                text: '更換照片',
                color: EnumColor.textLink.color,
                onPressed: onReplacePhoto,
              ),
              SizedBox(height: 12.0.scale),
              _PhotoActionButton(
                eImage: EnumImage.cDeleteImage,
                text: '刪除照片',
                color: EnumColor.accentRed.color,
                onPressed: onDeletePhoto,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PhotoActionButton extends StatelessWidget {
  final EnumImage eImage;
  final String text;
  final Color color;
  final VoidCallback? onPressed;

  const _PhotoActionButton({
    required this.eImage,
    required this.text,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 32.0.scale,
          vertical: 16.0.scale,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: EnumColor.backgroundPrimary.color,
        side: BorderSide(
          width: 1.0.scale,
          color: color,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0.scale),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          eImage.image(
            size: Size.square(32.0.scale),
            color: color,
          ),
          SizedBox(width: 12.0.scale),
          WidgetUtil.textWidget(
            text,
            size: 26.0.scale,
            color: color,
          ),
        ],
      ),
    );
  }
}
