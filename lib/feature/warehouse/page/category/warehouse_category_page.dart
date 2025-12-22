import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/second_background_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_category_request_model/warehouse_category_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_category_page_controller.dart';
part 'warehouse_category_page_interactive.dart';
part 'warehouse_category_page_model.dart';
part 'warehouse_category_page_route.dart';

class WarehouseCategoryPage extends GetView<WarehouseCategoryPageController> {
  const WarehouseCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<WarehouseCategoryPageController>()) {
      Get.put(WarehouseCategoryPageController(), permanent: false);
    }

    return SecondBackgroundCard(
      child: Center(
        child: Text(EnumLocale.warehouseNoCategory.tr),
      ),
    );
  }
}
