import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/filter_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/item_list.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/search_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/top_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/ui/dialog_item_search/dialog_item_search_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/dialog_item_edit_normal.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/dialog_item_edit_quantity.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/dialog_item_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/dialog_item_record.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/second_background_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_record.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_item_page_controller.dart';
part 'warehouse_item_page_interactive.dart';
part 'warehouse_item_page_model.dart';
part 'warehouse_item_page_route.dart';

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
