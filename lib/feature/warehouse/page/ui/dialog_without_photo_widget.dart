import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dashed_border_container.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class DialogWithoutPhotoWidget extends StatelessWidget {
  final bool isError;
  final VoidCallback onTap;

  const DialogWithoutPhotoWidget({
    super.key,
    this.isError = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DashedBorderContainer(
      width: double.infinity,
      height: 200.0.scale,
      borderRadius: BorderRadius.circular(16.0.scale),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: EnumColor.backgroundSecondary.color,
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EnumImage.cPhoto.image(size: Size.square(40.0.scale)),
              SizedBox(height: 16.0.scale),
              WidgetUtil.textWidget(
                isError ? '照片讀取失敗，請重新上傳' : '點選上傳照片',
                size: 22.0.scale,
                color: EnumColor.textSecondary.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
