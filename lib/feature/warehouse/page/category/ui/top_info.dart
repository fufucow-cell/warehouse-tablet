import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/warehouse_category_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class TopInfo extends StatelessWidget {
  const TopInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseCategoryPageController>(
      builder: (controller) {
        final totalCategories = controller.getTotalCategoryCount();

        return SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    WidgetUtil.textWidget(
                      '共 $totalCategories 個分類',
                      size: 32.0.scale,
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    controller.interactive(
                      EnumWarehouseCategoryPageInteractive.tapCreateCategory,
                    );
                  },
                  borderRadius: BorderRadius.circular(16.0.scale),
                  child: Container(
                    height: 70.0.scale,
                    padding: EdgeInsets.all(24.0.scale),
                    decoration: BoxDecoration(
                      color: EnumColor.backgroundPrimary.color,
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
                        Icon(
                          Icons.category_outlined,
                          size: 48.0.scale,
                          color: EnumColor.accentBlue.color,
                        ),
                        SizedBox(width: 10.0.scale),
                        WidgetUtil.textWidget(
                          EnumLocale.warehouseCategory.tr,
                          size: 32.0.scale,
                          color: EnumColor.accentBlue.color,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
