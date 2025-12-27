import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/actions.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/minor_list.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/warehouse_category_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class MajorListWidget extends StatelessWidget {
  const MajorListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCategoryPageController>();
    final level1Cats = controller.getChildrenList();

    if (level1Cats.isEmpty) {
      return const SizedBox.shrink();
    }

    return CustomScrollView(
      controller: controller.scrollController,
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _MajorHeader(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final category = level1Cats[index];

              return Obx(
                () {
                  controller.expandedCategoryIdsRx.value;
                  final isExpanded = controller.isCategoryExpanded(category);
                  return Column(
                    children: [
                      if (!isExpanded && index != 0)
                        Divider(
                          height: 1.0.scale,
                          thickness: 1.0.scale,
                          color: EnumColor.lineDividerLight.color,
                        ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.only(
                          left: 32.0.scale,
                          right: controller.rowRightGap.scale,
                          top: 24.0.scale,
                          bottom: 24.0.scale,
                        ),
                        decoration: BoxDecoration(
                          color: isExpanded ? EnumColor.menuBgFocused.color : EnumColor.backgroundPrimary.color,
                          borderRadius: BorderRadius.circular(20.0.scale),
                        ),
                        child: _MajorRowWithChildren(
                          category,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            childCount: level1Cats.length,
          ),
        ),
      ],
    );
  }
}

class _MajorHeader extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 78.0.scale;

  @override
  double get maxExtent => 78.0.scale;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final controller = Get.find<WarehouseCategoryPageController>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 32.0.scale,
        right: controller.rowRightGap.scale,
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
              EnumLocale.warehouseSubCategoryCount.tr,
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
          SizedBox(width: (controller.rowRightGap * 2).scale), // 為了跟子類別 Column 切齊
        ],
      ),
    );
  }
}

class _MajorRowWithChildren extends StatelessWidget {
  final Category category;

  const _MajorRowWithChildren(this.category);

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
            _MajorRow(category: category),
            if (hasChildren)
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment.topLeft,
                child: isExpanded
                    ? Padding(
                        padding: EdgeInsets.only(top: 24.0.scale),
                        child: MinorListWidget(
                          children: category.children!,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
          ],
        );
      },
    );
  }
}

class _MajorRow extends StatelessWidget {
  final Category category;

  const _MajorRow({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCategoryPageController>();
    final childrenCount = category.children?.length ?? 0;

    return Row(
      children: [
        Expanded(
          child: WidgetUtil.textWidget(
            category.name ?? '',
            weightType: EnumFontWeightType.bold,
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
          child: ActionsWidget(
            category: category,
          ),
        ),
        SizedBox(width: (controller.rowRightGap * 2).scale), // 為了跟子類別 Column 切齊
      ],
    );
  }
}
