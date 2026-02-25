import 'package:engo_terminal_app3/wh/feature/warehouse/page/category/ui/actions.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/category/ui/minor_list.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/page/category/warehouse_category_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_empty_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_shimmer_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MajorListWidget extends StatelessWidget {
  const MajorListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCategoryPageController>();

    return Obx(
      () {
        final level1Cats = controller.getChildrenList();
        final isLoading = controller.allCategoriesRx.value == null;
        final isEmpty = controller.allCategoriesRx.value?.isEmpty ?? true;

        if (isLoading) {
          return const _MajorRowShimmer();
        } else if (isEmpty) {
          return const CustEmptyWidget();
        }

        return ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0.scale),
            topRight: Radius.circular(20.0.scale),
          ),
          child: CustomScrollView(
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
                        bool isPreviousExpanded = false;

                        if (index > 0) {
                          final previousCategory = level1Cats[index - 1];
                          isPreviousExpanded = controller.isCategoryExpanded(previousCategory);
                        }

                        return Column(
                          children: [
                            if (!isExpanded && index != 0 && !isPreviousExpanded)
                              Divider(
                                height: 1.0.scale,
                                thickness: 1.0.scale,
                                color: EnumColor.lineDividerLight.color,
                              ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              margin: EdgeInsets.only(
                                top: (isExpanded && isPreviousExpanded) ? 20.0.scale : 0.0.scale,
                              ),
                              padding: EdgeInsets.only(
                                left: 32.0.scale,
                                right: controller.rowRightGap,
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
                  childCount: isLoading ? 3 : level1Cats.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MajorHeader extends SliverPersistentHeaderDelegate {
  static double get _headerHeight => (78.0.scale).clamp(48.0, double.infinity);

  @override
  double get minExtent => _headerHeight;

  @override
  double get maxExtent => _headerHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final controller = Get.find<WarehouseCategoryPageController>();
    return Container(
      width: double.infinity,
      height: _headerHeight,
      padding: EdgeInsets.only(
        left: 32.0.scale,
        right: controller.rowRightGap,
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
            child: CustTextWidget(
              EnumLocale.warehouseNameLabel.tr,
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
          SizedBox(width: 44.0.scale),
          SizedBox(
            width: controller.rowCountWidth,
            child: CustTextWidget(
              EnumLocale.warehouseSubCategoryCount.tr,
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
          SizedBox(width: 44.0.scale),
          SizedBox(
            width: controller.rowActionWidth,
            child: CustTextWidget(
              EnumLocale.warehouseAlarmOperation.tr,
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
          SizedBox(width: controller.rowRightGap * 2), // 為了跟子類別 Column 切齊
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
                          children: category.children ?? [],
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
          child: CustTextWidget(
            category.name ?? '',
            weightType: EnumFontWeightType.bold,
          ),
        ),
        SizedBox(width: 44.0.scale),
        SizedBox(
          width: controller.rowCountWidth,
          child: CustTextWidget(
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
        SizedBox(width: controller.rowRightGap * 2), // 為了跟子類別 Column 切齊
      ],
    );
  }
}

class _MajorRowShimmer extends StatelessWidget {
  const _MajorRowShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      separatorBuilder: (context, index) {
        return SizedBox(height: 16.0.scale);
      },
      itemBuilder: (context, index) {
        return ShimmerWidget(height: 112.0.scale);
      },
    );
  }
}
