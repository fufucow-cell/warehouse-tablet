import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/cabinet_mix_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/cabinet_row_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_item_request_model/warehouse_item_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

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
        final rooms = controller.getRoomsInfo;

        return LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              padding: EdgeInsets.all(12.0.scale), // Add padding for shadow (blurRadius + spreadRadius)
              physics: const ClampingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 32.0.scale,
                mainAxisSpacing: 32.0.scale,
                childAspectRatio: 514.0 / 420.0,
              ),
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                return _RoomCard(
                  roomNameId: rooms[index],
                );
              },
            );
          },
        );
      },
    );
  }
}

class _RoomCard extends StatelessWidget {
  final WarehouseNameIdModel roomNameId;

  const _RoomCard({
    required this.roomNameId,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(left: 32.0.scale, right: 32.0.scale, top: 32.0.scale, bottom: 32.0.scale),
        decoration: BoxDecoration(
          color: EnumColor.backgroundPrimary.color,
          borderRadius: BorderRadius.circular(32.0.scale),
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              blurRadius: 8.0.scale,
              offset: Offset(0, 2.0.scale),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _RoomTitleInfo(roomNameId: roomNameId),
            SizedBox(height: 16.0.scale),
            _RoomItemCountInfo(roomNameId: roomNameId),
            SizedBox(height: 32.0.scale),
            _RoomCabinetInfo(roomNameId: roomNameId),
          ],
        ),
      ),
    );
  }
}

class _RoomTitleInfo extends StatelessWidget {
  final WarehouseNameIdModel roomNameId;

  const _RoomTitleInfo({
    required this.roomNameId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: WidgetUtil.textWidget(
            roomNameId.name ?? '',
            weightType: EnumFontWeightType.bold,
          ),
        ),
        EnumImage.cEdit.image(size: Size.square(32.0.scale)),
      ],
    );
  }
}

class _RoomItemCountInfo extends StatelessWidget {
  final WarehouseNameIdModel roomNameId;

  const _RoomItemCountInfo({
    required this.roomNameId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCabinetPageController>();

    if (controller.allItemsRx.value == null) {
      return const SizedBox.shrink();
    }

    final room = controller.getRoom(roomNameId);
    final roomItemQuantity = room?.quantity ?? 0;

    return WidgetUtil.textWidget(
      '總共 $roomItemQuantity 項物品',
      size: 22.0.scale,
    );
  }
}

class _RoomCabinetInfo extends StatelessWidget {
  final WarehouseNameIdModel roomNameId;

  const _RoomCabinetInfo({
    required this.roomNameId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCabinetPageController>();
    final cabinets = controller.getCabinets(roomNameId);
    Widget card;

    if (cabinets.isEmpty) {
      card = const SizedBox.shrink();
    } else if (cabinets.length > 2) {
      card = CabinetMixCard(cabinets: cabinets);
    } else {
      card = CabinetRowCard(cabinets: cabinets);
    }

    return Expanded(child: card);
  }
}
