import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EnumImage.cEmpty.image(size: Size(422.0.scale, 298.0.scale)),
          SizedBox(height: 24.0.scale),
          WidgetUtil.textWidget(
            '暫時沒有資料',
            size: 28.0.scale,
            color: const Color(0xFFBDBDBD),
          ),
        ],
      ),
    );
  }
}
