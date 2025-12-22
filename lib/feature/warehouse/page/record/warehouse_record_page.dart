import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/ui/filter_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/ui/record_list.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_log_request_model/warehouse_log_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_log_response_model/log.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_record_page_controller.dart';
part 'warehouse_record_page_interactive.dart';
part 'warehouse_record_page_model.dart';
part 'warehouse_record_page_route.dart';

class WarehouseRecordPage extends GetView<WarehouseRecordPageController> {
  const WarehouseRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<WarehouseRecordPageController>()) {
      Get.put(WarehouseRecordPageController(), permanent: false);
    }

    return Column(
      children: [
        const FilterInfo(),
        SizedBox(height: 16.0.scale),
        const Expanded(child: RecordList()),
      ],
    );
  }
}
