import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/cabinet_row_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/top_info.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/warehouse_cabinet_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/warehouse_cabinet_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/second_background_card.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class WarehouseCabinetPage extends StatelessWidget {
  const WarehouseCabinetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WarehouseCabinetPageController>(
      init: Get.isRegistered<WarehouseCabinetPageController>() ? null : WarehouseCabinetPageController(),
      builder: (controller) {
        final rooms = controller.getRoomsInfo();

        return SecondBackgroundCard(
          child: Column(
            children: [
              const TopInfo(),
              if (rooms.isEmpty)
                Expanded(child: WidgetUtil.emptyWidget())
              else
                Expanded(
                  child: Obx(
                    () {
                      if (controller.allCabinetsRx.value == null) {
                        return const _RoomCardShimmer();
                      }

                      final visibleCabinets = controller.allVisibleCabinetsRx.value;

                      return Column(
                        children: [
                          SizedBox(height: 32.0.scale),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return GridView.builder(
                                  padding: EdgeInsets.all(
                                    12.0.scale,
                                  ), // Add padding for shadow (blurRadius + spreadRadius)
                                  physics: const ClampingScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 32.0.scale,
                                    mainAxisSpacing: 32.0.scale,
                                    childAspectRatio: 514.0 / 420.0,
                                  ),
                                  itemCount: visibleCabinets.length,
                                  itemBuilder: (context, index) {
                                    return _RoomCard(
                                      roomCabinetInfo: visibleCabinets[index],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _RoomCard extends StatelessWidget {
  final RoomCabinetInfo roomCabinetInfo;

  const _RoomCard({
    required this.roomCabinetInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 32.0.scale,
        right: 32.0.scale,
        top: 32.0.scale,
        bottom: 32.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundDropdown.color,
        borderRadius: BorderRadius.circular(32.0.scale),
        boxShadow: [
          BoxShadow(
            color: EnumColor.shadowCard.color,
            blurRadius: 8.0.scale,
            offset: Offset(0, 2.0.scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _RoomTitleInfo(roomCabinetInfo: roomCabinetInfo),
          SizedBox(height: 16.0.scale),
          _RoomItemCountInfo(roomCabinetInfo: roomCabinetInfo),
          SizedBox(height: 32.0.scale),
          _RoomCabinetInfo(roomCabinetInfo: roomCabinetInfo),
        ],
      ),
    );
  }
}

class _RoomTitleInfo extends StatelessWidget {
  final RoomCabinetInfo roomCabinetInfo;

  const _RoomTitleInfo({
    required this.roomCabinetInfo,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WarehouseCabinetPageController>();

    return Row(
      children: [
        Expanded(
          child: WidgetUtil.textWidget(
            roomCabinetInfo.roomName,
            weightType: EnumFontWeightType.bold,
          ),
        ),
        Material(
          color: EnumColor.backgroundDropdown.color,
          borderRadius: BorderRadius.circular(20.0.scale),
          child: InkWell(
            onTap: () {
              controller.interactive(
                EnumWarehouseCabinetPageInteractive.tapEditCabinet,
                data: roomCabinetInfo,
              );
            },
            borderRadius: BorderRadius.circular(20.0.scale),
            splashColor: EnumColor.accentBlue.color.withOpacity(0.2),
            highlightColor: EnumColor.accentBlue.color.withOpacity(0.1),
            child: Ink(
              padding: EdgeInsets.all(4.0.scale),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0.scale),
              ),
              child: EnumImage.cEditNormal.image(size: Size.square(32.0.scale), color: EnumColor.iconSecondary.color),
            ),
          ),
        ),
      ],
    );
  }
}

class _RoomItemCountInfo extends StatelessWidget {
  final RoomCabinetInfo roomCabinetInfo;

  const _RoomItemCountInfo({
    required this.roomCabinetInfo,
  });

  @override
  Widget build(BuildContext context) {
    final roomQuantity = roomCabinetInfo.cabinets.fold(0, (sum, cabinet) => sum + (cabinet.quantity));
    final cabinetsCount = roomCabinetInfo.cabinets.length;
    return WidgetUtil.textWidget(
      EnumLocale.warehouseTotalCabinetAndItem.trArgs(['$cabinetsCount', '$roomQuantity']),
      size: 22.0.scale,
    );
  }
}

class _RoomCabinetInfo extends StatelessWidget {
  final RoomCabinetInfo roomCabinetInfo;

  const _RoomCabinetInfo({
    required this.roomCabinetInfo,
  });

  @override
  Widget build(BuildContext context) {
    final cabinets = roomCabinetInfo.cabinets;
    return CabinetRowCard(cabinets: cabinets);
  }
}

class _RoomCardShimmer extends StatelessWidget {
  const _RoomCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32.0.scale),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                padding: EdgeInsets.all(
                  12.0.scale,
                ), // Add padding for shadow (blurRadius + spreadRadius)
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 32.0.scale,
                  mainAxisSpacing: 32.0.scale,
                  childAspectRatio: 514.0 / 420.0,
                ),
                itemCount: 3,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.only(
                    left: 32.0.scale,
                    right: 32.0.scale,
                    top: 32.0.scale,
                    bottom: 32.0.scale,
                  ),
                  decoration: BoxDecoration(
                    color: EnumColor.backgroundDropdown.color,
                    borderRadius: BorderRadius.circular(32.0.scale),
                    boxShadow: [
                      BoxShadow(
                        color: EnumColor.shadowCard.color,
                        blurRadius: 8.0.scale,
                        offset: Offset(0, 2.0.scale),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      WidgetUtil.shimmerWidget(height: 38.0.scale),
                      SizedBox(height: 16.0.scale),
                      WidgetUtil.shimmerWidget(height: 26.0.scale),
                      SizedBox(height: 32.0.scale),
                      WidgetUtil.shimmerWidget(height: 156.0.scale),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
