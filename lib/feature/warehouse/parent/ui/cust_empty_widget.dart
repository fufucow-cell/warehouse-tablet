import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_text_widget.dart';

class CustEmptyWidget extends StatelessWidget {
  const CustEmptyWidget({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EnumImage.cEmpty.image(size: Size(422.0.scale, 298.0.scale)),
          SizedBox(height: 24.0.scale),
          CustTextWidget(
            EnumLocale.commonNoData.tr,
            size: 28.0.scale,
            color: const Color(0xFFBDBDBD),
          ),
        ],
      ),
    );
  }
}
