import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/filter_text_list_multi.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/filter_text_list_single.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:get/get.dart';

class FilterInfo extends StatelessWidget {
  const FilterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseItemPageController>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: _FilterLists()),
        SizedBox(width: 16.0.scale),
        Obx(
          () => _ExpandButton(
            isExpanded: controller.isFilterExpandedRx.value,
            onPressed: () => controller
                .interactive(EnumWarehouseItemPageInteractive.tapFilterExpand),
          ),
        ),
      ],
    );
  }
}

class _FilterLists extends StatelessWidget {
  const _FilterLists();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseItemPageController>(
      builder: (controller) {
        final roomFilter = Obx(
          () {
            return FilterTextListSingle(
              items: controller.getFilterRoomNameList(),
              selectedIndex: controller.filterIndexForRoomsRx.value,
              onTap: (index) => controller.interactive(
                EnumWarehouseItemPageInteractive.tapRoomFilter,
                data: index,
              ),
            );
          },
        );
        final cabinetFilter = Obx(
          () {
            return FilterTextListSingle(
              items: controller.getFilterCabinetNameList(),
              selectedIndex: controller.cabinetFilterSelectedIndexRx.value,
              onTap: (index) => controller.interactive(
                EnumWarehouseItemPageInteractive.tapCabinetFilter,
                data: index,
              ),
            );
          },
        );
        final categoryFilter = Obx(
          () {
            return FilterTextListMulti(
              items: controller.getFilterCategoryNameList(),
              selectedIndices: controller.categoryFilterSelectedIndicesRx.value,
              onTap: (index) => controller.interactive(
                EnumWarehouseItemPageInteractive.tapCategoryFilter,
                data: index,
              ),
            );
          },
        );

        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.topLeft,
          child: Obx(
            () {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  roomFilter,
                  if (controller.isFilterExpandedRx.value) ...[
                    SizedBox(height: 16.0.scale),
                    cabinetFilter,
                    SizedBox(height: 16.0.scale),
                    categoryFilter,
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _ExpandButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onPressed;

  const _ExpandButton({
    required this.isExpanded,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: EnumColor.backgroundSecondary.color,
        padding: EdgeInsets.symmetric(horizontal: 32.0.scale),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0.scale),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isExpanded
                ? EnumLocale.warehouseItemCollapse.tr
                : EnumLocale.warehouseItemMoreOptions.tr,
            style: TextStyle(
              color: EnumColor.textSecondary.color,
            ),
          ),
          SizedBox(width: 6.0.scale),
          SizedBox(
            width: 40.0.scale,
            height: 40.0.scale,
            child: isExpanded
                ? EnumImage.cArrowUp.image(color: EnumColor.textSecondary.color)
                : EnumImage.cArrowDown
                    .image(color: EnumColor.textSecondary.color),
          ),
        ],
      ),
    );
  }
}
