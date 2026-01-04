import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/ui/filter_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/ui/record_list.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/second_background_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:get/get.dart';

class WarehouseRecordPage extends StatelessWidget {
  const WarehouseRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseRecordPageController>(
      init: Get.isRegistered<WarehouseRecordPageController>() ? null : WarehouseRecordPageController(),
      builder: (controller) {
        return SecondBackgroundCard(
          child: Column(
            children: [
              const FilterInfo(),
              SizedBox(height: 16.0.scale),
              const Expanded(child: RecordList()),
            ],
          ),
        );
      },
    );
  }
}
