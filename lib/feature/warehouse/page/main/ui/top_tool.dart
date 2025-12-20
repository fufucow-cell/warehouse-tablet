import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';

class TopTool extends StatelessWidget {
  const TopTool({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 23.0.scale,
        bottom: 23.0.scale,
        right: 40.0.scale,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          EnumImage.cPlus.image(
            size: Size.square(48.0.scale),
            color: EnumColor.iconSecondary.color,
          ),
          SizedBox(width: 32.0.scale),
          EnumImage.cSearch.image(
            size: Size.square(48.0.scale),
            color: EnumColor.iconSecondary.color,
          ),
          SizedBox(width: 32.0.scale),
          EnumImage.cSetting.image(
            size: Size.square(48.0.scale),
            color: EnumColor.iconSecondary.color,
          ),
        ],
      ),
    );
  }
}
