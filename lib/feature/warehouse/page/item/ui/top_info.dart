import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TopInfo extends StatelessWidget {
  const TopInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseItemPageController>(
      builder: (controller) {
        return Obx(() {
          final isLoading = controller.allItemsRx.value == null;
          return Padding(
            padding: EdgeInsets.all(32.0.scale),
            child: GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              crossAxisSpacing: 32.0.scale,
              mainAxisSpacing: 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 393 / 112,
              children: [
                TopInfoItem(
                  icon: EnumImage.cItem.image(),
                  title: '總物品數',
                  count: '${controller.getTotalItemCount()}',
                  isLoading: isLoading,
                ),
                TopInfoItem(
                  icon: EnumImage.cMember.image(),
                  title: '物品分類',
                  count: '${controller.getTotalCategoryCount()}',
                ),
                TopInfoItem(
                  icon: EnumImage.cRoom.image(),
                  title: '房間',
                  count: '${controller.getfilterRuleForRooms.length - 1}',
                ),
                TopInfoItem(
                  icon: EnumImage.cStockItem.image(),
                  title: '低庫存',
                  count: '${controller.getTotalLowStockCount()}',
                  isLoading: isLoading,
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

class TopInfoItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String count;
  final bool isLoading;

  const TopInfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: EnumColor.backgroundPrimary.color,
        borderRadius: BorderRadius.circular(24.0.scale),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0.scale),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 32.0.scale),
            SizedBox(width: 64.0.scale, height: 64.0.scale, child: icon),
            SizedBox(width: 32.0.scale),
            WidgetUtil.textWidget(title, size: 28.0.scale, color: EnumColor.textSecondary.color),
            SizedBox(width: 16.0.scale),
            Skeletonizer(
              enabled: isLoading,
              child: WidgetUtil.textWidget(
                isLoading ? '00' : count,
                weightType: EnumFontWeightType.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
