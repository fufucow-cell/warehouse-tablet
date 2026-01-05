import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
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
          return GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 4,
            crossAxisSpacing: 32.0.scale,
            mainAxisSpacing: 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 393 / 112,
            children: [
              TopInfoItem(
                eImage: EnumImage.cItem,
                title: EnumLocale.warehouseItemTotal.tr,
                count: '${controller.getTotalItemCount()}',
                isLoading: allItems == null,
              ),
              TopInfoItem(
                eImage: EnumImage.cRoom,
                title: EnumLocale.warehouseCabinetTotal.tr,
                count: '${controller.getTotalCabinetCount}',
                isLoading: allCabinets == null,
              ),
              TopInfoItem(
                eImage: EnumImage.cMember,
                title: EnumLocale.warehouseItemCategory.tr,
                count: '${controller.getTotalCategoryCount()}',
              ),
              TopInfoItem(
                eImage: EnumImage.cStockItem,
                title: EnumLocale.warehouseItemLowStock.tr,
                count: '${controller.getTotalLowStockCount}',
                isLoading: allItems == null,
              ),
            ],
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
            SizedBox(width: 64.0.scale, height: 64.0.scale, child: eImage.image()),
            SizedBox(width: 32.0.scale),
            WidgetUtil.textWidget(
              title,
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
            SizedBox(width: 16.0.scale),
            if (isLoading)
              WidgetUtil.shimmerWidget(width: 52.0.scale, height: 34.0.scale)
            else
              WidgetUtil.textWidget(
                count,
                weightType: EnumFontWeightType.bold,
              ),
          ],
        ),
      ),
    );
  }
}
