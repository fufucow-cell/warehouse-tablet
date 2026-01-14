import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:flutter/material.dart';

class FirstBackgroundCard extends StatelessWidget {
  final Widget child;

  const FirstBackgroundCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: EnumColor.backgroundPrimary.color,
      padding: EdgeInsets.symmetric(
        horizontal: 32.0.scale,
        vertical: 48.0.scale,
      ),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.all(Radius.circular(32.0.scale)),
        child: Container(
          padding: EdgeInsets.all(32.0.scale),
          decoration: BoxDecoration(
            image: EnumImage.tBgContent.decorationImage,
          ),
          child: child,
        ),
      ),
    );
  }
}
