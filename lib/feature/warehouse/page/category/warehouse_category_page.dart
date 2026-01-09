import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/major_list.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/top_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/warehouse_category_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/second_background_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:get/get.dart';

class WarehouseCategoryPage extends StatelessWidget {
  const WarehouseCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseCategoryPageController>(
      init: Get.isRegistered<WarehouseCategoryPageController>()
          ? null
          : WarehouseCategoryPageController(),
      builder: (controller) {
        return SecondBackgroundCard(
          child: Column(
            children: [
              const TopInfo(),
              SizedBox(height: 32.0.scale),
              const Expanded(
                child: MajorListWidget(),
              ),
            ],
          ),
        );
      },
    );
  }
}
