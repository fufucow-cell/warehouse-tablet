import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

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
            ? WidgetUtil.textRequiredWidget(
                title,
                size: 26.0.scale,
                color: EnumColor.textSecondary.color,
              )
            : WidgetUtil.textWidget(
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
