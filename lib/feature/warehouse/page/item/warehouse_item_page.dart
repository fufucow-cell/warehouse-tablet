import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/bottom_content.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/top_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
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
    return GetBuilder<WarehouseItemPageController>(
      init: WarehouseItemPageController(),
      builder: (controller) {
        return ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0.scale),
            topRight: Radius.circular(24.0.scale),
          ),
          child: _Body(),
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
        return Container(
          decoration: BoxDecoration(
            image: EnumImage.tBgContent.decorationImage,
          ),
          child: const Column(
            children: [
              TopInfo(),
              Expanded(child: BottomContent()),
            ],
          ),
        );
      },
    );
  }
}
