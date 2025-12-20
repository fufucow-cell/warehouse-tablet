import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_cabinet_request_model/warehouse_cabinet_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/warehouse_item_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/api_util.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'warehouse_cabinet_page_controller.dart';
part 'warehouse_cabinet_page_interactive.dart';
part 'warehouse_cabinet_page_model.dart';
part 'warehouse_cabinet_page_route.dart';

class WarehouseCabinetPage extends GetView<WarehouseCabinetPageController> {
  const WarehouseCabinetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseCabinetPageController>(
      init: WarehouseCabinetPageController(),
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
    return GetBuilder<WarehouseCabinetPageController>(
      builder: (controller) {
        final cabinets = controller.cabinets;

        if (cabinets?.isEmpty ?? true) {
          return Center(
            child: Text(EnumLocale.warehouseNoCabinet.tr),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: cabinets!.length,
          itemBuilder: (context, index) {
            final cabinet = cabinets[index];
            return _CabinetItem(cabinet: cabinet);
          },
        );
      },
    );
  }
}

class _CabinetItem extends StatelessWidget {
  final Cabinet cabinet;

  const _CabinetItem({
    required this.cabinet,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCabinetPageController>();

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.warehouse_outlined,
              size: 48,
              color: Colors.blue[700],
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cabinet.name ?? EnumLocale.warehouseUnnamedCabinet.tr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    '1',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  // if (cabinet.description != null) ...[
                  //   const SizedBox(height: 4.0),
                  //   Text(
                  //     '${EnumLocale.warehouseDescriptionLabel.tr}${cabinet.description}',
                  //     style: const TextStyle(
                  //       fontSize: 14,
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // ],
                ],
              ),
            ),
            // 编辑模式下显示删除按钮
            Obx(
              () {
                final isEditMode = controller.isEditModeRx.value;
                if (isEditMode) {
                  return IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      controller.deleteCabinet(cabinet);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
