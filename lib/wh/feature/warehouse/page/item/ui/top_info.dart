import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/warehouse_item_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_grid_view.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_shimmer_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/util/category_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopInfo extends StatelessWidget {
  const TopInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseItemPageController>(
      builder: (controller) {
        return Obx(() {
          final allItems = controller.allItemsRx.value;
          final allCabinets = controller.allCabinetsRx.value;
          final allCategories = controller.allCategoriesRx.value;
          final items = [
            TopInfoItem(
              eImage: EnumImage.cItem,
              title: EnumLocale.warehouseItemTotal.tr,
              count: '${controller.getTotalItemCount()}',
              isLoading: allItems == null,
            ),
            TopInfoItem(
              eImage: EnumImage.cRoom,
              title: EnumLocale.warehouseCabinetTotal.tr,
              count: '${controller.getTotalCabinetCount()}',
              isLoading: allCabinets == null,
            ),
            TopInfoItem(
              eImage: EnumImage.cMember,
              title: EnumLocale.warehouseCategoryTotal.tr,
              count: '${CategoryUtil.getTotalCategoryCount()}',
              isLoading: allCategories == null,
            ),
            TopInfoItem(
              eImage: EnumImage.cStockItem,
              title: EnumLocale.warehouseItemLowStock.tr,
              count: '${controller.getTotalLowStockCount}',
              isLoading: allItems == null,
            ),
          ];

          return CustGridView(
            itemCount: items.length,
            itemBuilder: (context, index) => items[index],
            crossAxisCount: 4,
            padding: EdgeInsets.zero,
            crossAxisSpacing: 32.0.scale,
            mainAxisSpacing: 0,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          );
        });
      },
    );
  }
}

class TopInfoItem extends StatelessWidget {
  final EnumImage eImage;
  final String title;
  final String count;
  final bool isLoading;

  const TopInfoItem({
    super.key,
    required this.eImage,
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
            SizedBox(
              width: 64.0.scale,
              height: 64.0.scale,
              child: eImage.image(),
            ),
            SizedBox(width: 32.0.scale),
            CustTextWidget(
              title,
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
            SizedBox(width: 16.0.scale),
            if (isLoading)
              ShimmerWidget(width: 34.0.scale, height: 34.0.scale)
            else
              CustTextWidget(
                count,
                weightType: EnumFontWeightType.bold,
              ),
          ],
        ),
      ),
    );
  }
}
