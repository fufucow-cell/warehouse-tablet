import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/children.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/warehouse_item_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_util.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'warehouse_item_page_controller.dart';
part 'warehouse_item_page_interactive.dart';
part 'warehouse_item_page_model.dart';
part 'warehouse_item_page_route.dart';

class WarehouseItemPage
    extends GetView<WarehouseItemPageController> {
  const WarehouseItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseItemPageController>(
      init: WarehouseItemPageController(),
      builder: (controller) {
        return Obx(
          () {
            return Skeletonizer(
              enabled: controller.isLoadingRx.value,
              child: _Body(),
            );
          },
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseItemPageController>(
      builder: (controller) {
        if (controller.items?.isEmpty ?? true) {
          return Center(
            child: Text(EnumLocale.warehouseNoItem.tr),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.75,
          ),
          itemCount: controller.items?.length ?? 0,
          itemBuilder: (context, index) {
            final item = controller.items![index];
            return _ItemCard(item: item);
          },
        );
      },
    );
  }
}

class _ItemCard extends StatelessWidget {
  final Item item;

  const _ItemCard({required this.item});

  /// 构建分类路径字符串: level1 name > level2 name > level3 name
  String _buildCategoryPath(Category? category) {
    if (category == null) return '';

    final List<String> parts = [];

    // Level 1
    if (category.name != null &&
        category.name!.isNotEmpty) {
      parts.add(category.name!);
    }

    // Level 2
    final level2 = category.children;
    if (level2 != null &&
        level2.name != null &&
        level2.name!.isNotEmpty) {
      parts.add(level2.name!);

      // Level 3
      final level3 = level2.children;
      if (level3 != null && level3 is Children) {
        if (level3.name != null &&
            level3.name!.isNotEmpty) {
          parts.add(level3.name!);
        }
      }
    }

    return parts.join(' > ');
  }

  /// 构建位置列表: room name > cabinet name
  List<String> _buildLocations() {
    final List<String> locations = [];

    if (item.rooms == null || item.rooms!.isEmpty) {
      return locations;
    }

    for (final room in item.rooms!) {
      if (room.cabinets == null || room.cabinets!.isEmpty) {
        continue;
      }

      for (final cabinet in room.cabinets!) {
        if (cabinet.name == null || cabinet.name!.isEmpty) {
          continue;
        }

        final quantity = cabinet.quantity ?? 0;
        final cabinetText = '${cabinet.name} ($quantity)';

        // 如果有 room name，显示 room name > cabinet name (数量)
        // 如果没有 room name，直接显示 cabinet name (数量)
        if (room.roomName != null &&
            room.roomName!.isNotEmpty) {
          locations.add('${room.roomName} > $cabinetText');
        } else {
          locations.add(cabinetText);
        }
      }
    }

    return locations;
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.find<WarehouseItemPageController>();
    final categoryPath = _buildCategoryPath(item.category);
    final locations = _buildLocations();

    return Card(
      elevation: 2,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 图片区域
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                    child: EnumImage.cCow.image(),
                  ),
                ),
                const SizedBox(height: 8),
                // 名称
                Text(
                  item.name ??
                      EnumLocale.warehouseUnnamedItem.tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // 数量
                Row(
                  children: [
                    Text(
                      EnumLocale.warehouseQuantityLabel.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall,
                    ),
                    Text(
                      '${item.quantity ?? 0}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: (item.quantity ?? 0) <=
                                    (item.minStockAlert ??
                                        0)
                                ? Colors.red
                                : null,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Category: level1 name > level2 name > level3 name
                Text(
                  categoryPath.isNotEmpty
                      ? '${EnumLocale.warehouseCategoryLabel.tr}$categoryPath'
                      : '${EnumLocale.warehouseCategoryLabel.tr}${EnumLocale.warehouseNoCategoryText.tr}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        color: Colors.grey[600],
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // Locations: room name > cabinet name
                if (locations.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    EnumLocale.warehouseLocationsLabel.tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  ...locations.take(3).map(
                        (location) => Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            top: 2.0,
                          ),
                          child: Text(
                            location,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Colors.grey[600],
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                  if (locations.length > 3)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 2.0,
                      ),
                      child: Text(
                        EnumLocale.warehouseMoreLocations.tr
                            .replaceAll(
                          '{count}',
                          '${locations.length - 3}',
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ],
            ),
          ),
          // 编辑模式下显示删除按钮
          Obx(
            () {
              final isEditMode =
                  controller.isEditModeRx.value;
              if (isEditMode) {
                return Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      controller.deleteItem(item);
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
