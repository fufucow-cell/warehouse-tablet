import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/filter_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/item_list.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BottomContent extends StatelessWidget {
  const BottomContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseItemPageController>(
      builder: (controller) {
        return Obx(() {
          final isLoading = controller.allItemsRx.value == null;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0.scale),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.0.scale),
              decoration: BoxDecoration(
                color: EnumColor.backgroundPrimary.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0.scale),
                  topRight: Radius.circular(24.0.scale),
                ),
              ),
              child: Column(
                children: [
                  Skeletonizer(
                    enabled: isLoading,
                    child: const FilterInfo(),
                  ),
                  const Expanded(child: ItemList()),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
