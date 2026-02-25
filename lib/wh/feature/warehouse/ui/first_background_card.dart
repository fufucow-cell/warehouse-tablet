import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
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
    final envService = EnvironmentService.instance;
    return Container(
      color: EnumColor.backgroundPrimary.color,
      padding: envService.getIsModuleMode
          ? EdgeInsets.only(
              top: 12.0.scale,
            )
          : EdgeInsets.symmetric(
              vertical: 48.0.scale,
              horizontal: 32.0.scale,
            ),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.all(
          Radius.circular(32.0.scale),
        ),
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
