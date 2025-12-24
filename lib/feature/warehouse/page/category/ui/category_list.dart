import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/category_row.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/warehouse_category_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseCategoryPageController>(
      builder: (controller) {
        return Obx(() {
          final categories = controller.allCategoriesRx.value;
          if (categories == null || categories.isEmpty) {
            return const SizedBox.shrink();
          }

          final topLevelCategories = controller.getTopLevelCategories();

          return Column(
            children: [
              _CategoryHeader(),
              ...topLevelCategories.map((category) => CategoryRow(
                    category: category,
                    level: 1,
                    isExpanded: controller.isCategoryExpanded(category),
                  )),
            ],
          );
        });
      },
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 32.0.scale,
        vertical: 22.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundSecondary.color,
        borderRadius: BorderRadius.circular(20.0.scale),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 640.0.scale,
            child: WidgetUtil.textWidget(
              EnumLocale.warehouseNameLabel.tr,
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
          SizedBox(
            width: 501.0.scale,
            child: WidgetUtil.textWidget(
              '子類別數量',
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
          SizedBox(
            width: 312.0.scale,
            child: WidgetUtil.textWidget(
              '操作',
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
        ],
      ),
    );
  }
}
