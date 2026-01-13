import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';

class DialogSectionWidget extends StatelessWidget {
  final bool isRequired;
  final String title;
  final Widget child;

  const DialogSectionWidget({
    super.key,
    this.isRequired = false,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isRequired
            ? CustTextRequiredWidget(
                title,
                size: 26.0.scale,
                color: EnumColor.textSecondary.color,
              )
            : CustTextWidget(
                title,
                size: 26.0.scale,
                color: EnumColor.textSecondary.color,
              ),
        SizedBox(height: 12.0.scale),
        child,
      ],
    );
  }
}
