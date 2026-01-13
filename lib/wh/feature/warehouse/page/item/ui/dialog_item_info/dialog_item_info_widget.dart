import 'package:engo_terminal_app3/wh/feature/warehouse/page/item/ui/dialog_item_info/dialog_item_info_widget_controller.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_network_image.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/dialog/ui/frame.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/dialog/ui/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogItemInfoWidget extends StatelessWidget {
  final String itemId;

  const DialogItemInfoWidget({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogItemInfoWidgetController>(
      init: DialogItemInfoWidgetController(itemId),
      builder: (controller) {
        return DialogFrame(
          width: 962.0.scale,
          header: DialogHeader(title: EnumLocale.warehouseItemInfo.tr),
          child: const _Body(),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PhotoCard(),
        SizedBox(height: 24.0.scale),
        _InfoCard(),
      ],
    );
  }
}

class _PhotoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemInfoWidgetController>();
    return CustNetworkImage(
      url: controller.getPhoto,
      width: 320.0.scale,
      height: 225.0.scale,
      fit: BoxFit.cover,
    );
  }
}

class _InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemInfoWidgetController>();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 32.0.scale,
        vertical: 44.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundSecondary.color,
        borderRadius: BorderRadius.circular(20.0.scale),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            label: EnumLocale.createItemName.tr,
            value: controller.getTitle,
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: '${EnumLocale.warehouseDescriptionLabel.tr}：',
            value: controller.getDescription,
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: EnumLocale.warehouseCurrentQuantityLabel.tr,
            value: controller.combineItem?.quantity.toString() ?? '0',
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: EnumLocale.warehouseAlertQuantityLabel.tr,
            value: controller.getMinStockAlert,
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: EnumLocale.category.tr,
            value: controller.getCategoryName,
          ),
          SizedBox(height: 24.0.scale),
          _PositionsInfo(rooms: controller.getPositions),
          SizedBox(height: 24.0.scale),
          _RecordButton(),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 112.0.scale),
            child: CustTextWidget(
              label,
              size: 28.0.scale,
              color: EnumColor.textSecondary.color,
            ),
          ),
        ),
        SizedBox(width: 24.0.scale),
        Expanded(
          flex: 3,
          child: CustTextWidget(
            value,
            size: 28.0.scale,
          ),
        ),
      ],
    );
  }
}

class _PositionsInfo extends StatelessWidget {
  final List<ItemPositionModel> rooms;

  const _PositionsInfo({required this.rooms});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 112.0.scale,
          child: CustTextWidget(
            EnumLocale.warehouseLocationsLabel.tr,
            size: 28.0.scale,
            color: EnumColor.textSecondary.color,
          ),
        ),
        SizedBox(width: 24.0.scale),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int roomIdx = 0; roomIdx < rooms.length; roomIdx++)
                for (int cabinetIdx = 0; cabinetIdx < rooms[roomIdx].cabinets.length; cabinetIdx++)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _PositionItem(
                        roomName: rooms[roomIdx].roomName,
                        cabinetName: rooms[roomIdx].cabinets[cabinetIdx].name,
                        quantity: rooms[roomIdx].cabinets[cabinetIdx].quantity,
                        showRoomName: cabinetIdx == 0,
                      ),
                      if (!(roomIdx == rooms.length - 1 && cabinetIdx == rooms[roomIdx].cabinets.length - 1)) SizedBox(height: 16.0.scale),
                    ],
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PositionItem extends StatelessWidget {
  final String roomName;
  final String cabinetName;
  final int quantity;
  final bool showRoomName;

  const _PositionItem({
    required this.roomName,
    required this.cabinetName,
    required this.quantity,
    required this.showRoomName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: showRoomName,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: CustTextWidget(
            '$roomName → ',
            size: 28.0.scale,
          ),
        ),
        CustTextWidget(
          cabinetName,
          size: 28.0.scale,
        ),
        SizedBox(width: 24.0.scale),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.scale),
          decoration: BoxDecoration(
            color: EnumColor.accentBlue.color,
            borderRadius: BorderRadius.circular(12.0.scale),
          ),
          child: CustTextWidget(
            '$quantity',
            size: 28.0.scale,
            color: EnumColor.textWhite.color,
          ),
        ),
      ],
    );
  }
}

class _RecordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DialogItemInfoWidgetController>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 112.0.scale,
          child: CustTextWidget(
            EnumLocale.record.tr,
            size: 28.0.scale,
            color: EnumColor.textSecondary.color,
          ),
        ),
        SizedBox(width: 24.0.scale),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => controller.interactive(
              EnumDialogItemInfoWidgetInteractive.tapRecordButton,
              data: context,
            ),
            child: Row(
              children: [
                EnumImage.cHistory.image(
                  size: Size.square(40.0.scale),
                  color: EnumColor.textLink.color,
                ),
                SizedBox(width: 10.0.scale),
                CustTextWidget(
                  EnumLocale.warehouseItemClickToViewRecord.tr,
                  size: 28.0.scale,
                  color: EnumColor.textLink.color,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
