import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/category_row.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class CategoryChildrenList extends StatelessWidget {
  final List<Category> children;
  final int level;

  const CategoryChildrenList({
    super.key,
    required this.children,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 32.0.scale,
        vertical: 31.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundPrimary.color,
        borderRadius: BorderRadius.circular(20.0.scale),
      ),
      child: Column(
        children: [
          if (level == 2) _SubCategoryHeader(),
          ...children.map((child) => CategoryRow(
                category: child,
                level: level,
              )),
          if (level == 2 && children.isNotEmpty)
            Container(
              width: double.infinity,
              height: 1.0.scale,
              color: EnumColor.lineDivider.color,
            ),
        ],
      ),
    );
  }
}

class _SubCategoryHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 22.0.scale,
        left: 24.0.scale,
        bottom: 22.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundSecondary.color,
        borderRadius: BorderRadius.circular(20.0.scale),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 584.0.scale,
            child: WidgetUtil.textWidget(
              EnumLocale.warehouseNameLabel.tr,
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
          SizedBox(
            width: 501.0.scale,
            child: WidgetUtil.textWidget(
              '分類量',
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
          SizedBox(
            width: 280.0.scale,
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
