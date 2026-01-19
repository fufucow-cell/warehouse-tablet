import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:flutter/material.dart';

class CustIconButton extends StatelessWidget {
  final EnumImage icon;
  final double size;
  final VoidCallback onTap;
  final Color? color;

  const CustIconButton({
    super.key,
    required this.icon,
    required this.size,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          child: icon.image(
            color: color,
          ),
        ),
      ),
    );
  }
}
