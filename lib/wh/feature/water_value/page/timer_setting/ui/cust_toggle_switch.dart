import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter/material.dart';

class CustToggleSwitch extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;

  const CustToggleSwitch({
    super.key,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 101.0.scale,
        height: 58.0.scale,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: value ? EnumColor.engoWaterValueStatusOpening.color : EnumColor.textSecondary.color,
                  borderRadius: BorderRadius.circular(30.0.scale),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: value ? 50.50.scale : 7.31.scale,
              top: 8.44.scale,
              child: Container(
                width: 42.08.scale,
                height: 42.18.scale,
                decoration: ShapeDecoration(
                  color: EnumColor.textWhite.color,
                  shape: const OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: EnumColor.shadowCard.color,
                      blurRadius: 6.0.scale,
                      offset: Offset(0, 5.0.scale),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
