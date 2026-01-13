import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_text_widget.dart';
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
                return CustTextWidget(
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
                  color: EnumColor.accentBlue.color,
                ),
                SizedBox(width: 10.0.scale),
                CustTextWidget(
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
