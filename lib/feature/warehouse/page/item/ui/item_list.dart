import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseItemPageController>(
      builder: (controller) {
        return Obx(
          () {
            final items = controller.visibleItemsRx.value;

            if (items.isEmpty) {
              return const SizedBox.shrink();
            }

            return GridView.builder(
              padding: EdgeInsets.all(32.0.scale),
              physics: const ClampingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 32.0.scale,
                mainAxisSpacing: 32.0.scale,
                childAspectRatio: 524 / 664,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _ItemCard(
                  item: item,
                );
              },
            );
          },
        );
      },
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0.scale),
        color: EnumColor.backgroundPrimary.color,
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            blurRadius: 16.0.scale,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ItemPhotoWidget(item: item),
          _ItemInfo(item: item),
          SizedBox(height: 10.0.scale),
          const _ItemTools(),
        ],
      ),
    );
  }
}

class _ItemPhotoWidget extends StatelessWidget {
  final Item item;

  const _ItemPhotoWidget({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseItemPageController>();
    final hasWarning = controller.isShowStockWarningTag(item);

    return SizedBox(
      height: 335.0.scale,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(24.0.scale),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.0.scale),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28.0.scale),
              child: Image.network(
                item.photo?.toString() ?? '',
                width: double.infinity,
                height: 335.0.scale,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 335.0.scale,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
          ),
          // leftTopWarningTagWidget
          if (hasWarning)
            Positioned(
              top: 40.0.scale,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0.scale,
                  vertical: 8.0.scale,
                ),
                decoration: BoxDecoration(
                  color: EnumColor.accentRed.color,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0.scale),
                    bottomRight: Radius.circular(30.0.scale),
                  ),
                ),
                child: WidgetUtil.textWidget(
                  '庫存不足',
                  size: 22.0.scale,
                  color: EnumColor.textWhite.color,
                ),
              ),
            ),
          // rightBottomQuantityTagWidget
          Positioned(
            bottom: 39.0.scale,
            right: 39.0.scale,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0.scale,
                vertical: 8.0.scale,
              ),
              decoration: BoxDecoration(
                color: EnumColor.backgroundPrimary.color,
                borderRadius: BorderRadius.circular(30.0.scale),
              ),
              child: WidgetUtil.textWidget(
                '數量: ${item.quantity ?? 0}',
                size: 22.0.scale,
                color: EnumColor.textPrimary.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemInfo extends StatelessWidget {
  final Item item;

  const _ItemInfo({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseItemPageController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: WidgetUtil.textWidget(
                  item.name ?? '',
                  weightType: EnumFontWeightType.bold,
                  color: EnumColor.textPrimary.color,
                ),
              ),
              SizedBox(width: 16.0.scale),
              EnumImage.cInfo.image(size: Size.square(40.0.scale)),
            ],
          ),
          SizedBox(height: 16.0.scale),
          WidgetUtil.textWidget(
            item.description ?? '',
            size: 22.0.scale,
            color: EnumColor.textSecondary.color,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16.0.scale),
          WidgetUtil.textWidget(
            controller.getItemCategoriesName(item),
            size: 26.0.scale,
            color: EnumColor.textLink.color,
          ),
        ],
      ),
    );
  }
}

class _ItemTools extends StatelessWidget {
  const _ItemTools();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.scale),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final spacing = 8.0.scale;
          const iconCount = 4;
          final availableWidth = constraints.maxWidth;
          final totalSpacing = spacing * (iconCount - 1);
          final iconWidth = (availableWidth - totalSpacing) / iconCount;
          final iconSize = Size(iconWidth, 64.0.scale);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EnumImage.cEdit.image(size: iconSize),
              EnumImage.cQuantity.image(size: iconSize),
              EnumImage.cMove.image(size: iconSize),
              EnumImage.cHistory.image(size: iconSize),
            ],
          );
        },
      ),
    );
  }
}
