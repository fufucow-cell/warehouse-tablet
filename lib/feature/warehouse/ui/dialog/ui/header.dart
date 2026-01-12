import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class DialogHeader extends StatelessWidget {
  final String title;

  const DialogHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 56.0.scale,
        vertical: 28.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundPrimary.color,
        border: Border(
          bottom: BorderSide(
            width: 2.0.scale,
            color: EnumColor.lineDividerLight.color,
          ),
        ),
      ),
      child: WidgetUtil.textWidget(
        title,
        size: 32.0.scale,
        weightType: EnumFontWeightType.bold,
      ),
    );
  }
}
