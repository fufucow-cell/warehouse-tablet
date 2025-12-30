import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
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
            final isLoading = controller.allItemsRx.value == null;

            if (items.isEmpty) {
              return WidgetUtil.emptyWidget();
            }

            return GridView.builder(
              padding: EdgeInsets.only(
                left: 16.0.scale, // blurRadius for shadow
                right: 16.0.scale, // blurRadius for shadow
                top: 16.0.scale, // blurRadius for shadow
                bottom: 40.0.scale,
              ),
              physics: const ClampingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 32.0.scale,
                mainAxisSpacing: 32.0.scale,
                childAspectRatio: 524 / 724,
              ),
              itemCount: isLoading ? 3 : items.length,
              itemBuilder: (context, index) {
                if (isLoading) {
                  return WidgetUtil.shimmerWidget();
                }

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
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(24.0.scale),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0.scale),
          color: EnumColor.backgroundDropdown.color,
          boxShadow: [
            BoxShadow(
              color: EnumColor.shadowCard.color,
              blurRadius: 16.0.scale,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ItemPhotoWidget(item: item),
            SizedBox(height: 24.0.scale),
            _ItemInfo(item: item),
            SizedBox(height: 24.0.scale),
            _ItemTools(item: item),
          ],
        ),
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
    final photoHeight = 348.0.scale;
    return SizedBox(
      height: 335.0.scale,
      child: Stack(
        children: [
          WidgetUtil.networkImage(
            url: item.photo?.toString() ?? '',
            width: double.infinity,
            height: photoHeight,
            fit: BoxFit.cover,
          ),
          // leftTopWarningTagWidget
          if (hasWarning)
            Positioned(
              top: 16.0.scale,
              left: 11.0.scale,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0.scale,
                  vertical: 11.0.scale,
                ),
                decoration: BoxDecoration(
                  color: EnumColor.accentRed.color,
                  borderRadius: BorderRadius.circular(100.0.scale),
                ),
                child: WidgetUtil.textWidget(
                  EnumLocale.warehouseItemStockInsufficient.tr,
                  size: 22.0.scale,
                  color: EnumColor.textWhite.color,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: WidgetUtil.textWidget(
                item.name ?? '',
                weightType: EnumFontWeightType.bold,
                color: EnumColor.textPrimary.color,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 16.0.scale),
            quantityWidget,
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
    );
  }

  Widget get quantityWidget {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0.scale,
        vertical: 8.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundAccentBlue.color,
        borderRadius: BorderRadius.circular(30.0.scale),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WidgetUtil.textWidget(
            '${EnumLocale.warehouseQuantityLabel.tr}：',
            size: 22.0.scale,
            color: EnumColor.accentBlue.color,
          ),
          SizedBox(width: 12.0.scale),
          WidgetUtil.textWidget(
            item.quantity?.toString() ?? '',
            size: 28.0.scale,
            weightType: EnumFontWeightType.bold,
            color: EnumColor.accentBlue.color,
          ),
        ],
      ),
    );
  }
}

class _ItemTools extends StatelessWidget {
  const _ItemTools({required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseItemPageController>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _toolWidget(
            EnumImage.cEditNormal,
            EnumLocale.warehouseItemEdit.tr,
            onTap: () {
              controller.interactive(
                EnumWarehouseItemPageInteractive.tapItemNormalEdit,
                data: item,
              );
            },
          ),
        ),
        SizedBox(width: 12.0.scale),
        Expanded(
          child: _toolWidget(
            EnumImage.cEditQuantity,
            EnumLocale.warehouseQuantityLabel.tr,
            onTap: () {
              controller.interactive(
                EnumWarehouseItemPageInteractive.tapItemQuantityEdit,
                data: item,
              );
            },
          ),
        ),
        SizedBox(width: 12.0.scale),
        Expanded(
          child: _toolWidget(
            EnumImage.cEditPosition,
            EnumLocale.warehouseEntityTypePosition.tr,
            onTap: () {
              controller.interactive(
                EnumWarehouseItemPageInteractive.tapItemPositionEdit,
                data: item,
              );
            },
          ),
        ),
        SizedBox(width: 12.0.scale),
        Expanded(
          child: _toolWidget(
            EnumImage.cInfo,
            EnumLocale.warehouseItemInfo.tr,
            onTap: () {
              controller.interactive(
                EnumWarehouseItemPageInteractive.tapItemInfo,
                data: item,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _toolWidget(
    EnumImage eImg,
    String title, {
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.0.scale),
        child: Container(
          decoration: BoxDecoration(
            color: EnumColor.backgroundSecondary.color,
            borderRadius: BorderRadius.circular(20.0.scale),
          ),
          padding: EdgeInsets.all(16.0.scale),
          child: Column(
            children: [
              eImg.image(
                size: Size.square(40.0.scale),
                color: EnumColor.iconSecondary.color,
              ),
              SizedBox(height: 8.0.scale),
              WidgetUtil.textWidget(
                title,
                size: 18.0.scale,
                color: EnumColor.textSecondary.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
