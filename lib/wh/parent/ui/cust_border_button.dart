import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';

class CustBorderButton extends StatelessWidget {
  final Widget? icon;
  final String text;
  final VoidCallback onTap;

  const CustBorderButton({
    super.key,
    this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0x66FFFFFF), Color(0x00FBBB84)],
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: EnumColor.engoButtonBorder.color,
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 16.0),
              ],
              CustTextWidget(
                text,
                size: 32.0.scale,
                color: EnumColor.textPrimary.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
