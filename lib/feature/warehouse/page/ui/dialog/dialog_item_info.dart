import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

class DialogItemInfo extends StatelessWidget {
  final DialogItemInfoModel dataModel;

  const DialogItemInfo(this.dataModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return DialogFrame(
      header: DialogHeader(title: EnumLocale.warehouseItemInfo.tr),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PhotoCard(photo: dataModel.photo),
          SizedBox(height: 24.0.scale),
          _InfoCard(dataModel: dataModel),
        ],
      ),
    );
  }
}

class DialogItemInfoModel {
  final String? title;
  final String? description;
  final String? photo;
  final int? lowStockAlert;
  final String? category;
  final List<DialogItemInfoRoomModel>? rooms;

  DialogItemInfoModel({
    this.title,
    this.description,
    this.photo,
    this.lowStockAlert,
    this.category,
    this.rooms,
  });

  int get totalQuantity {
    if (rooms == null) {
      return 0;
    }

    return rooms!.fold<int>(
      0,
      (total, room) =>
          total +
          (room.cabinets).fold<int>(
            0,
            (cabinetSum, cabinet) => cabinetSum + cabinet.quantity,
          ),
    );
  }
}

class DialogItemInfoRoomModel {
  final String roomId;
  final String roomName;
  final List<DialogItemInfoCabinetModel> cabinets;

  DialogItemInfoRoomModel({
    required this.roomId,
    required this.roomName,
    required this.cabinets,
  });
}

class DialogItemInfoCabinetModel {
  final String cabinetId;
  final String cabinetName;
  final int quantity;

  DialogItemInfoCabinetModel({
    required this.cabinetId,
    required this.cabinetName,
    required this.quantity,
  });
}

class _PhotoCard extends StatelessWidget {
  final String? photo;

  const _PhotoCard({required this.photo});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(11.0.scale),
      child: Image.network(
        photo ?? 'https://via.placeholder.com',
        width: 320.0.scale,
        height: 225.0.scale,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 320.0.scale,
            height: 225.0.scale,
            color: EnumColor.backgroundSecondary.color,
            child: Icon(
              Icons.image_not_supported,
              size: 48.0.scale,
              color: EnumColor.iconSecondary.color,
            ),
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final DialogItemInfoModel dataModel;

  const _InfoCard({
    required this.dataModel,
  });

  @override
  Widget build(BuildContext context) {
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
            value: dataModel.title ?? '',
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: '${EnumLocale.warehouseDescriptionLabel.tr}：',
            value: dataModel.description ?? '',
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: EnumLocale.warehouseCurrentQuantityLabel.tr,
            value: dataModel.totalQuantity.toString(),
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: EnumLocale.warehouseAlertQuantityLabel.tr,
            value: dataModel.lowStockAlert?.toString() ?? '0',
          ),
          SizedBox(height: 24.0.scale),
          _InfoRow(
            label: EnumLocale.warehouseCategory.tr,
            value: dataModel.category ?? EnumLocale.warehouseUncategorized.tr,
          ),
          SizedBox(height: 24.0.scale),
          _PositionsInfo(rooms: dataModel.rooms ?? []),
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
        SizedBox(
          width: 112.0.scale,
          child: WidgetUtil.textWidget(
            label,
            size: 28.0.scale,
            color: EnumColor.textSecondary.color,
          ),
        ),
        SizedBox(width: 24.0.scale),
        Expanded(
          child: WidgetUtil.textWidget(
            value,
            size: 28.0.scale,
          ),
        ),
      ],
    );
  }
}

class _PositionsInfo extends StatelessWidget {
  final List<DialogItemInfoRoomModel> rooms;

  const _PositionsInfo({required this.rooms});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 112.0.scale,
          child: WidgetUtil.textWidget(
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
                        cabinetName: rooms[roomIdx].cabinets[cabinetIdx].cabinetName,
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
          child: WidgetUtil.textWidget(
            '$roomName → ',
            size: 28.0.scale,
          ),
        ),
        WidgetUtil.textWidget(
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
          child: WidgetUtil.textWidget(
            '$quantity',
            size: 28.0.scale,
            color: EnumColor.textWhite.color,
          ),
        ),
      ],
    );
  }
}
