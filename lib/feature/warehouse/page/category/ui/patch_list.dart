import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/actions.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/warehouse_category_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class PatchListWidget extends StatelessWidget {
  final List<Category> children;

  const PatchListWidget({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCategoryPageController>();
    return Container(
      padding: EdgeInsets.only(
        left: 32.0.scale,
        right: controller.rowRightGap,
      ),
      decoration: BoxDecoration(
        color: EnumColor.menuBgFocused.color,
        borderRadius: BorderRadius.circular(20.0.scale),
      ),
      child: Column(
        children: [
          ...children.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final category = entry.value;
              return Column(
                children: [
                  if (index != 0)
                    Divider(
                      height: 1.0.scale,
                      thickness: 1.0.scale,
                      color: EnumColor.lineDividerLight.color,
                    ),
                  _PatchRow(
                    category: category,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PatchRow extends StatelessWidget {
  final Category category;

  const _PatchRow({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCategoryPageController>();

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 35.0.scale,
      ),
      child: Row(
        children: [
          Expanded(
            child: WidgetUtil.textWidget(
              category.name ?? '',
              size: 28.0.scale,
            ),
          ),
          SizedBox(width: 44.0.scale),
          SizedBox(
            width: controller.rowActionWidth,
            child: ActionsWidget(
              category: category,
            ),
          ),
        ],
      ),
    );
  }
}
