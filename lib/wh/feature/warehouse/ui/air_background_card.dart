import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/environment_service/environment_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:flutter/material.dart';

class AirBackgroundCard extends StatelessWidget {
  final Widget child;
  final bool isBox;
  final bool isPurifier;

  const AirBackgroundCard({
    super.key,
    required this.child,
    this.isBox = false,
    this.isPurifier = false,
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
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: EnumImage.tBgContent.decorationImage,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: EnumImage.cBackgroundWind1.decorationImage,
                ),
              ),
            ),
            if (isBox)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 1000.0.scale,
                    height: 1000.0.scale,
                    decoration: BoxDecoration(
                      image: EnumImage.cBackgroundWind2.decorationImage,
                    ),
                  ),
                ),
              ),
            if (isPurifier)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 1100.0.scale,
                  height: 1100.0.scale,
                  decoration: BoxDecoration(
                    image: EnumImage.cBackgroundWind2.decorationImage,
                  ),
                ),
              ),
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.only(
                  left: 32.0.scale,
                  right: 32.0.scale,
                  top: 32.0.scale,
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
