import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';

class FirstBackgroundCard extends StatelessWidget {
  final Widget child;

  const FirstBackgroundCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0.scale),
        topRight: Radius.circular(32.0.scale),
      ),
      child: Container(
        color: EnumColor.backgroundPrimary.color,
        child: Container(
          padding: EdgeInsets.only(
            left: 32.0.scale,
            right: 32.0.scale,
            top: 32.0.scale,
          ),
          decoration: BoxDecoration(
            image: EnumImage.tBgContent.decorationImage,
          ),
          child: child,
        ),
      ),
    );
  }
}
