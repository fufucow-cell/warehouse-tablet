part of 'warehouse_item_page.dart';

enum EnumWarehouseItemPageRoute {
  showDialogItemNormalEdit,
  showDialogItemQuantityEdit,
  showDialogItemPositionEdit,
  showDialogItemInfo,
}

extension WarehouseItemPageRouteExtension on WarehouseItemPageController {
  void routerHandle(EnumWarehouseItemPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseItemPageRoute.showDialogItemNormalEdit:
        if (data is Item) {
          _service.showAlert(
            DialogItemNormalEditWidget(
              itemId: data.id!,
              onConfirm: (outputModel) async {
                return await _updateItemNormal(data, outputModel);
              },
            ),
          );
        }
      case EnumWarehouseItemPageRoute.showDialogItemQuantityEdit:
        if (data is Item) {
          // final rooms = _service.filterItemFromRooms(data);
          // final locations = rooms
          //     .expand<DialogItemInfoCabinetModel>((DialogItemInfoRoomModel room) => room.cabinets)
          //     .map(
          //       (cabinet) => DialogItemEditQuantityLocationModel(
          //         locationId: cabinet.cabinetId,
          //         locationName: cabinet.cabinetName,
          //         quantity: cabinet.quantity,
          //       ),
          //     )
          //     .toList();

          // _service.showAlert(
          //   DialogItemEditQuantity(
          //     DialogItemEditQuantityModel(
          //       itemName: data.name,
          //       currentQuantity: rooms
          //           .expand<DialogItemInfoCabinetModel>((DialogItemInfoRoomModel room) => room.cabinets)
          //           .fold<int>(0, (sum, cabinet) => sum + (cabinet.quantity)),
          //       locations: locations,
          //     ),
          //   ),
          // );
        }
      case EnumWarehouseItemPageRoute.showDialogItemPositionEdit:
        if (data is Item) {
          // final allRecords = _service.getAllRecords;
          // final itemRecords = allRecords?.where((record) => record.itemName?.contains(data.name ?? '') ?? false).toList() ?? [];

          // final recordItems = itemRecords.map((record) {
          //   final operateType = EnumOperateType.fromInt(record.operateType);
          //   final entityType = EnumEntityType.fromInt(record.entityType);
          //   final tagType = _genTagType(record, operateType, entityType);
          //   final content = _genContent(record, operateType, entityType);
          //   final date = _formatDate(record.createdAt);

          //   return DialogItemRecordItemModel(
          //     tag: tagType.title,
          //     content: content,
          //     date: date,
          //   );
          // }).toList();

          // final rooms = _service.filterItemFromRooms(data);
          // final currentQuantity = rooms
          //     .expand<DialogItemInfoCabinetModel>((DialogItemInfoRoomModel room) => room.cabinets)
          //     .fold<int>(0, (sum, cabinet) => sum + cabinet.quantity);

          // _service.showAlert(
          //   DialogItemRecord(
          //     DialogItemRecordModel(
          //       itemName: data.name,
          //       currentQuantity: currentQuantity,
          //       records: recordItems,
          //     ),
          //   ),
          // );
        }
      case EnumWarehouseItemPageRoute.showDialogItemInfo:
        if (data is Item && (data.id?.isNotEmpty ?? false)) {
          _service.showAlert(
            DialogItemInfoWidget(data.id!),
          );
        }
    }
  }
}
