import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/filter_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/item_list.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/search_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/top_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/second_background_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:get/get.dart';

class WarehouseItemPage extends GetView<WarehouseItemPageController> {
  const WarehouseItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<WarehouseItemPageController>()) {
      Get.put(WarehouseItemPageController(), permanent: false);
    }

    return Column(
      children: [
        const TopInfo(),
        SizedBox(height: 32.0.scale),
        Expanded(
          child: SecondBackgroundCard(
            child: Column(
              children: [
                Obx(() {
                  if (controller.searchConditionRx.value == null) {
                    return const FilterInfo();
                  } else {
                    return const SearchInfo();
                  }
                }),
                const Expanded(child: ItemList()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
