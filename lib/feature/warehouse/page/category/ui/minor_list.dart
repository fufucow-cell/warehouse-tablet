import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/actions.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/patch_list.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/warehouse_category_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class MinorListWidget extends StatelessWidget {
  final List<Category> children;

  const MinorListWidget({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCategoryPageController>();
    return Container(
      padding: EdgeInsets.only(
        top: 31.0.scale,
        left: 32.0.scale,
        right: controller.rowRightGap,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundQuaternary.color,
        borderRadius: BorderRadius.circular(20.0.scale),
      ),
      child: Column(
        children: [
          _MinorHeader(),
          ...children.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final category = entry.value;
              final isExpanded = controller.isCategoryExpanded(category);
              final lastPadding = ((index == children.length - 1) && isExpanded)
                  ? 24.0.scale
                  : 0.0.scale;
              bool isPreviousExpanded = false;

              if (index > 0) {
                final previousCategory = children[index - 1];
                isPreviousExpanded =
                    controller.isCategoryExpanded(previousCategory);
              }

              return Column(
                children: [
                  if (index != 0 && !isPreviousExpanded)
                    Divider(
                      height: 1.0.scale,
                      thickness: 1.0.scale,
                      color: EnumColor.lineDividerLight.color,
                    ),
                  Padding(
                    padding: EdgeInsets.only(bottom: lastPadding),
                    child: _MinorRowWithChildren(
                      category: category,
                    ),
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

class _MinorHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCategoryPageController>();
    return Container(
      height: 78.0.scale,
      padding: EdgeInsets.only(
        left: controller.rowLeftGap,
        top: 22.0.scale,
        bottom: 22.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundSecondary.color,
        borderRadius: BorderRadius.circular(20.0.scale),
      ),
      child: Row(
        children: [
          Expanded(
            child: WidgetUtil.textWidget(
              EnumLocale.warehouseNameLabel.tr,
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
          SizedBox(width: 44.0.scale),
          SizedBox(
            width: controller.rowCountWidth,
            child: WidgetUtil.textWidget(
              EnumLocale.warehouseCategoryCount.tr,
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
          SizedBox(width: 44.0.scale),
          SizedBox(
            width: controller.rowActionWidth,
            child: WidgetUtil.textWidget(
              EnumLocale.warehouseAlarmOperation.tr,
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
          SizedBox(width: controller.rowRightGap), // 為了跟子類別 Column 切齊
        ],
      ),
    );
  }
}

class _MinorRowWithChildren extends StatelessWidget {
  final Category category;

  const _MinorRowWithChildren({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCategoryPageController>();
    final children = controller.getChildrenList(category);
    final hasChildren = children.isNotEmpty;

    return Obx(
      () {
        final isExpanded = controller.isCategoryExpanded(category);
        return Column(
          children: [
            _MinorRow(category: category),
            if (hasChildren)
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment.topLeft,
                child: isExpanded
                    ? PatchListWidget(
                        children: category.children!,
                      )
                    : const SizedBox.shrink(),
              ),
          ],
        );
      },
    );
  }
}

class _MinorRow extends StatelessWidget {
  final Category category;

  const _MinorRow({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCategoryPageController>();
    final childrenCount = category.children?.length ?? 0;

    return Padding(
      padding: EdgeInsets.only(
        left: controller.rowLeftGap,
        top: 35.0.scale,
        bottom: 35.0.scale,
      ),
      child: Row(
        children: [
          Expanded(
            child: WidgetUtil.textWidget(
              category.name ?? '',
              size: 28.0.scale,
              weightType: EnumFontWeightType.medium,
            ),
          ),
          SizedBox(width: 44.0.scale),
          SizedBox(
            width: controller.rowCountWidth,
            child: WidgetUtil.textWidget(
              '$childrenCount',
              size: 28.0.scale,
            ),
          ),
          SizedBox(width: 44.0.scale),
          SizedBox(
            width: controller.rowActionWidth,
            child: ActionsWidget(category: category),
          ),
          SizedBox(width: controller.rowRightGap), // 為了跟子類別 Column 切齊
        ],
      ),
    );
  }
}
