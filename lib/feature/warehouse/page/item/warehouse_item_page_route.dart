part of 'warehouse_item_page.dart';

enum EnumWarehouseItemPageRoute {
  showEditDialog,
  showChangeDialog,
  showInfoDialog,
  showRecordDialog,
}

extension WarehouseItemPageRouteExtension on WarehouseItemPageController {
  void routerHandle(EnumWarehouseItemPageRoute type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseItemPageRoute.showEditDialog:
        if (data is Item) {
          _service.showAlert(const DialogItemEditNormal());
        }
        break;
      case EnumWarehouseItemPageRoute.showChangeDialog:
        if (data is Item) {
          final rooms = _service.filterItemFromRooms(data);
          final locations = rooms
              .expand((room) => room.cabinets)
              .map((cabinet) => DialogItemEditQuantityLocationModel(
                    locationId: cabinet.cabinetId,
                    locationName: cabinet.cabinetName,
                    quantity: cabinet.quantity,
                  ))
              .toList();

          _service.showAlert(
            DialogItemEditQuantity(
              DialogItemEditQuantityModel(
                itemName: data.name,
                currentQuantity: rooms.expand((room) => room.cabinets).fold<int>(0, (sum, cabinet) => sum + cabinet.quantity),
                locations: locations,
              ),
            ),
          );
        }
        break;
      case EnumWarehouseItemPageRoute.showInfoDialog:
        if (data is Item) {
          _service.showAlert(
            DialogItemInfo(
              DialogItemInfoModel(
                title: data.name,
                description: data.description,
                lowStockAlert: data.minStockAlert,
                category: _service.convertCategoriesName(data),
                rooms: _service.filterItemFromRooms(data),
              ),
            ),
          );
        }
        break;
      case EnumWarehouseItemPageRoute.showRecordDialog:
        if (data is Item) {
          final allRecords = _service.getAllRecords;
          final itemRecords = allRecords?.where((record) => record.itemName?.contains(data.name ?? '') ?? false).toList() ?? [];

          final recordItems = itemRecords.map((record) {
            final operateType = EnumOperateType.fromInt(record.operateType);
            final entityType = EnumEntityType.fromInt(record.entityType);
            final tagType = _genTagType(record, operateType, entityType);
            final content = _genContent(record, operateType, entityType);
            final date = _formatDate(record.createdAt);

            return DialogItemRecordItemModel(
              tag: tagType.title,
              content: content,
              date: date,
            );
          }).toList();

          final rooms = _service.filterItemFromRooms(data);
          final currentQuantity = rooms.expand((room) => room.cabinets).fold<int>(0, (sum, cabinet) => sum + cabinet.quantity);

          _service.showAlert(
            DialogItemRecord(
              DialogItemRecordModel(
                itemName: data.name,
                currentQuantity: currentQuantity,
                records: recordItems,
              ),
            ),
          );
        }
        break;
    }
  }

  EnumTagType _genTagType(
    ItemRecord log,
    EnumOperateType operateType,
    EnumEntityType entityType,
  ) {
    switch (operateType) {
      case EnumOperateType.create:
        return switch (entityType) {
          EnumEntityType.item => EnumTagType.createItem,
          EnumEntityType.cabinet => EnumTagType.createCabinet,
          EnumEntityType.category => EnumTagType.createCategory,
          _ => EnumTagType.unknown,
        };
      case EnumOperateType.update:
        if (entityType == EnumEntityType.item) {
          if (log.itemQuantity != null) {
            return EnumTagType.updateQuantity;
          } else if (log.itemPosition != null) {
            return EnumTagType.updatePosition;
          }
        }

        return switch (entityType) {
          EnumEntityType.item => EnumTagType.updateItem,
          EnumEntityType.cabinet => EnumTagType.updateCabinet,
          EnumEntityType.category => EnumTagType.updateCategory,
          _ => EnumTagType.unknown,
        };
      case EnumOperateType.delete:
        return switch (entityType) {
          EnumEntityType.item => EnumTagType.deleteItem,
          EnumEntityType.cabinet => EnumTagType.deleteCabinet,
          EnumEntityType.category => EnumTagType.deleteCategory,
          _ => EnumTagType.unknown,
        };
      default:
        return EnumTagType.unknown;
    }
  }

  String _genContent(
    ItemRecord log,
    EnumOperateType operateType,
    EnumEntityType entityType,
  ) {
    switch (operateType) {
      case EnumOperateType.create:
        return switch (entityType) {
          EnumEntityType.item => log.itemName?.lastOrNull ?? '',
          EnumEntityType.cabinet => log.cabinetName?.lastOrNull ?? '',
          EnumEntityType.category => log.categoryName?.lastOrNull ?? '',
          _ => '',
        };
      case EnumOperateType.update:
        if (entityType == EnumEntityType.item) {
          if (log.itemQuantity != null) {
            return _genItemQuantityContent(log);
          } else if (log.itemPosition != null) {
            return _genItemPositionContent(log);
          }
        }

        return switch (entityType) {
          EnumEntityType.item => _genItemNormalContent(log),
          EnumEntityType.cabinet => _genCabinetContent(log),
          EnumEntityType.category => _genCategoryContent(log),
          _ => '',
        };
      case EnumOperateType.delete:
        return switch (entityType) {
          EnumEntityType.item => log.itemName?.firstOrNull ?? '',
          EnumEntityType.cabinet => log.cabinetName?.firstOrNull ?? '',
          EnumEntityType.category => log.categoryName?.firstOrNull ?? '',
          _ => '',
        };
      default:
        return '';
    }
  }

  String _formatDate(int? timestamp) {
    if (timestamp == null) {
      return '-';
    }

    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _genItemQuantityContent(ItemRecord log) {
    final itemQuantity = log.itemQuantity;
    if (itemQuantity == null) {
      return '';
    }

    final totalCount = itemQuantity.totalCount?.firstOrNull ?? 0;
    final cabinets = itemQuantity.cabinets ?? [];

    if (cabinets.isEmpty) {
      return EnumLocale.warehouseItemTotalQuantityChange.trArgs([
        log.itemName?.firstOrNull ?? '',
        '0',
        totalCount.toString(),
      ]);
    }

    return EnumLocale.warehouseItemTotalQuantityChange.trArgs([
      log.itemName?.firstOrNull ?? '',
      '0',
      totalCount.toString(),
    ]);
  }

  String _genItemPositionContent(ItemRecord log) {
    final positions = log.itemPosition ?? [];
    if (positions.isEmpty) {
      return '';
    }

    final positionStrings = positions.map((pos) => pos.cabinetName?.firstOrNull ?? '').where((str) => str.isNotEmpty).join(', ');

    return positionStrings;
  }

  String _genItemNormalContent(ItemRecord log) {
    return log.itemName?.lastOrNull ?? '';
  }

  String _genCabinetContent(ItemRecord log) {
    return log.cabinetName?.lastOrNull ?? '';
  }

  String _genCategoryContent(ItemRecord log) {
    return log.categoryName?.lastOrNull ?? '';
  }
}
