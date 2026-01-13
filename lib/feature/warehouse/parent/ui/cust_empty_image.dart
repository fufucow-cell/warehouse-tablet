import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/image_map.dart';

class CustEmptyImage extends StatelessWidget {
  const CustEmptyImage({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      color: EnumColor.backgroundSecondary.color,
      child: Center(
        child: EnumImage.cEmptyPhoto.image(
          size: Size.square(40.0.scale),
          color: EnumColor.iconSecondary.color,
        ),
      ),
    );
  }
}
