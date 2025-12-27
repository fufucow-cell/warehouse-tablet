import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class SearchInfo extends StatelessWidget {
  const SearchInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseItemPageController>();
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Obx(
              () {
                final count = controller.visibleItemsRx.value.length;
                return WidgetUtil.textWidget(
                  EnumLocale.searchResultCount.trArgs(['$count']),
                );
              },
            ),
          ),
          SizedBox(width: 24.0.scale),
          OutlinedButton(
            onPressed: () => controller.interactive(
              EnumWarehouseItemPageInteractive.tapClearSearch,
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(0, 70.0.scale),
              padding: EdgeInsets.symmetric(horizontal: 24.0.scale),
              backgroundColor: EnumColor.backgroundPrimary.color,
              side: BorderSide(
                width: 1.0.scale,
                color: EnumColor.accentBlue.color,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0.scale),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EnumImage.cTrash.image(
                  size: Size.square(48.0.scale),
                ),
                SizedBox(width: 10.0.scale),
                WidgetUtil.textWidget(
                  EnumLocale.searchClearResult.tr,
                  color: EnumColor.accentBlue.color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
