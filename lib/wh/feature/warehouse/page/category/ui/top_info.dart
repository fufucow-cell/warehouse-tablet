import 'package:engo_terminal_app3/wh/feature/warehouse/page/category/warehouse_category_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopInfo extends StatelessWidget {
  const TopInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCategoryPageController>();
    final eachLevelCount = controller.getEachLevelCategoryCount();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustTextWidget(
          EnumLocale.warehouseCategoryTotalCount.trArgs([
            eachLevelCount[0].toString(),
            eachLevelCount[1].toString(),
            eachLevelCount[2].toString(),
          ]),
          size: 32.0.scale,
        ),
        const Spacer(),
        Material(
          color: EnumColor.backgroundPrimary.color,
          borderRadius: BorderRadius.circular(16.0.scale),
          child: InkWell(
            onTap: () {
              controller.interactive(
                EnumWarehouseCategoryPageInteractive.tapCreateCategory,
              );
            },
            borderRadius: BorderRadius.circular(16.0.scale),
            splashColor: EnumColor.accentBlue.color.withOpacity(0.2),
            highlightColor: EnumColor.accentBlue.color.withOpacity(0.1),
            child: Ink(
              height: 70.0.scale,
              padding: EdgeInsets.symmetric(horizontal: 24.0.scale),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0.scale,
                  color: EnumColor.accentBlue.color,
                ),
                borderRadius: BorderRadius.circular(16.0.scale),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EnumImage.cPlus2.image(
                    size: Size.square(48.0.scale),
                    color: EnumColor.accentBlue.color,
                  ),
                  SizedBox(width: 10.0.scale),
                  CustTextWidget(
                    EnumLocale.category.tr,
                    size: 32.0.scale,
                    color: EnumColor.accentBlue.color,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
