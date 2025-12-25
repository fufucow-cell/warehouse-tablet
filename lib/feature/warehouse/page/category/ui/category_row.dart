import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/category_children_list.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/warehouse_category_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class CategoryRow extends StatelessWidget {
  final Category category;
  final int level;
  final bool isExpanded;

  const CategoryRow({
    super.key,
    required this.category,
    required this.level,
    this.isExpanded = false,
  });

  int _getSubCategoryCount(Category cat) {
    if (cat.children == null || cat.children!.isEmpty) {
      return 0;
    }
    return cat.children!.length;
  }

  @override
  Widget build(BuildContext context) {
    final subCategoryCount = _getSubCategoryCount(category);
    final hasChildren = subCategoryCount > 0;
    final isLevel1 = level == 1;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 32.0.scale,
            vertical: 24.0.scale,
          ),
          decoration: BoxDecoration(
            color: isLevel1 && isExpanded ? EnumColor.menuBgFocused.color : Colors.transparent,
            borderRadius: BorderRadius.circular(isLevel1 ? 20.0.scale : 0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 640.0.scale,
                      child: WidgetUtil.textWidget(
                        category.name ?? '',
                        size: 32.0.scale,
                        weightType: isLevel1 ? EnumFontWeightType.bold : EnumFontWeightType.regular,
                      ),
                    ),
                    SizedBox(
                      width: 501.0.scale,
                      child: WidgetUtil.textWidget(
                        '$subCategoryCount',
                        size: 28.0.scale,
                      ),
                    ),
                    SizedBox(
                      width: 312.0.scale,
                      child: _CategoryActions(
                        category: category,
                        hasChildren: hasChildren,
                        isExpanded: isExpanded,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (hasChildren && isExpanded)
          CategoryChildrenList(
            children: category.children!,
            level: level + 1,
          ),
      ],
    );
  }
}

class _CategoryActions extends StatelessWidget {
  final Category category;
  final bool hasChildren;
  final bool isExpanded;

  const _CategoryActions({
    required this.category,
    required this.hasChildren,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCategoryPageController>();

    return Row(
      children: [
        _ActionButton(
          icon: EnumImage.cEditNormal.image(size: Size.square(40.0.scale)),
          onTap: () {
            controller.interactive(
              EnumWarehouseCategoryPageInteractive.tapEditCategory,
              data: category,
            );
          },
        ),
        if (hasChildren) SizedBox(width: 16.0.scale),
        if (hasChildren)
          _ActionButton(
            icon: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              size: 40.0.scale,
              color: EnumColor.textPrimary.color,
            ),
            onTap: () {
              controller.interactive(
                EnumWarehouseCategoryPageInteractive.tapExpandCategory,
                data: category,
              );
            },
          ),
        SizedBox(width: 16.0.scale),
        _ActionButton(
          icon: Icon(
            Icons.delete_outline,
            size: 40.0.scale,
            color: EnumColor.textPrimary.color,
          ),
          onTap: () {
            controller.interactive(
              EnumWarehouseCategoryPageInteractive.tapDeleteCategory,
              data: category,
            );
          },
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.0.scale),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 13.5.scale,
            vertical: 12.0.scale,
          ),
          decoration: BoxDecoration(
            color: EnumColor.backgroundSecondary.color,
            borderRadius: BorderRadius.circular(20.0.scale),
          ),
          child: icon,
        ),
      ),
    );
  }
}
