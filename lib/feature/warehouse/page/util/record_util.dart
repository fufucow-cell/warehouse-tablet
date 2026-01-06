import 'package:collection/collection.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_record.dart';

class CombineRecord {
  EnumTagType tagType;
  String entityName;
  String userName;
  String content;
  int epoch;

  CombineRecord({
    required this.tagType,
    required this.entityName,
    required this.userName,
    required this.content,
    required this.epoch,
  });

  String get date {
    final date = DateTime.fromMillisecondsSinceEpoch(epoch);
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class RecordUtil {
  static List<CombineRecord> combineItemRecords(List<ItemRecord> records, {bool isItemLog = false}) {
    final result = <CombineRecord>[];
    final groupRecords = _groupRecords(records);

    for (final mapRecrod in groupRecords.entries) {
      final epoch = mapRecrod.key;
      final tagType = _genTagType(mapRecrod.value.first);
      final userName = mapRecrod.value.first.userName ?? '';
      String entityName = '';
      String content = '';

      for (final record in mapRecrod.value) {
        final entityType = EnumEntityType.fromInt(record.entityType);
        final operateType = EnumOperateType.fromInt(record.operateType);

        switch (operateType) {
          case EnumOperateType.create:
          case EnumOperateType.delete:
            switch (entityType) {
              case EnumEntityType.itemNormal:
                content = _genItemNormalContent(record);
                entityName = record.itemName?.lastOrNull ?? '';
              case EnumEntityType.cabinet:
                content += _genCabinetContent(record, operateType);
                entityName = record.cabinetName?.lastOrNull ?? '';
              case EnumEntityType.category:
                content = _genCategoryContent(record, operateType);
                entityName = record.categoryName?.lastOrNull ?? '';
              default:
                break;
            }
            break;
          case EnumOperateType.update:
            switch (entityType) {
              case EnumEntityType.itemNormal:
                content = _genItemNormalContent(record);
                entityName = record.itemName?.lastOrNull ?? '';
              case EnumEntityType.itemQuantity:
                content += _genItemQuantityContent(record);
                entityName = record.itemName?.lastOrNull ?? '';
              case EnumEntityType.itemPosition:
                content += _genItemPositionContent(record);
                entityName = record.itemName?.lastOrNull ?? '';
              case EnumEntityType.cabinet:
                content += _genCabinetContent(record, operateType);
                entityName = record.cabinetName?.lastOrNull ?? '';
              case EnumEntityType.category:
                content = _genCategoryContent(record, operateType);
                entityName = record.categoryName?.lastOrNull ?? '';
              default:
                break;
            }
          default:
            break;
        }
      }

      // 把 content 開頭為 \n 去掉

      if (content.startsWith('\n')) {
        content = content.substring(1);
      }

      if (!isItemLog && (tagType == EnumTagType.updateItem || tagType == EnumTagType.updatePosition || tagType == EnumTagType.updateQuantity)) {
        content = '$entityName\n$content';
      }

      result.add(
        CombineRecord(
          tagType: tagType,
          entityName: entityName,
          userName: userName,
          content: content,
          epoch: epoch,
        ),
      );
    }

    return result;
  }

  static Map<int, List<ItemRecord>> _groupRecords(List<ItemRecord> records) {
    final groupedMap = <int, List<ItemRecord>>{};

    // 依照時間分組；若同一個 createdAt 內出現不同 operateType，則用 createdAt + 1 (若仍衝突再 +1...) 拆成不同組別
    for (final record in records) {
      final createdAt = record.createdAt ?? 0;
      final operateType = record.operateType ?? -1;

      int key = createdAt;
      while (groupedMap.containsKey(key)) {
        final existingOperateType = groupedMap[key]!.first.operateType ?? -1;
        if (existingOperateType == operateType) {
          break;
        }
        key++;
      }

      if (groupedMap.containsKey(key)) {
        groupedMap[key]!.add(record);
      } else {
        groupedMap[key] = [record];
      }
    }

    return groupedMap;
  }

  static EnumTagType _genTagType(ItemRecord record) {
    final operateType = EnumOperateType.fromInt(record.operateType);
    final entityType = EnumEntityType.fromInt(record.entityType);

    switch (operateType) {
      case EnumOperateType.create:
        return switch (entityType) {
          EnumEntityType.itemNormal => EnumTagType.createItem,
          EnumEntityType.cabinet => EnumTagType.createCabinet,
          EnumEntityType.category => EnumTagType.createCategory,
          _ => EnumTagType.unknown,
        };
      case EnumOperateType.update:
        return switch (entityType) {
          EnumEntityType.itemNormal => EnumTagType.updateItem,
          EnumEntityType.cabinet => EnumTagType.updateCabinet,
          EnumEntityType.category => EnumTagType.updateCategory,
          EnumEntityType.itemQuantity => EnumTagType.updateQuantity,
          EnumEntityType.itemPosition => EnumTagType.updatePosition,
          _ => EnumTagType.unknown,
        };
      case EnumOperateType.delete:
        return switch (entityType) {
          EnumEntityType.itemNormal => EnumTagType.deleteItem,
          EnumEntityType.cabinet => EnumTagType.deleteCabinet,
          EnumEntityType.category => EnumTagType.deleteCategory,
          _ => EnumTagType.unknown,
        };
      default:
        return EnumTagType.unknown;
    }
  }

  static String _genItemNormalContent(ItemRecord record) {
    String result = '';

    if (record.itemName?.length == 1) {
      result = (record.itemName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : record.itemName!.firstOrNull!;
      return result;
    } else if (record.itemName?.length == 2) {
      final oldValue = (record.itemName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : record.itemName!.firstOrNull!;
      final newValue = (record.itemName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : record.itemName!.lastOrNull!;
      final str = '\n${EnumLocale.warehouseNameUpdate.trArgs([oldValue, newValue])}';
      result += str;
    }

    // 處理物品描述
    if (record.itemDescription?.length == 1) {
      final newValue =
          (record.itemDescription?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUndescribed.tr : record.itemDescription!.firstOrNull!;
      result += '\n${EnumLocale.warehouseDescriptionAdd.tr}: $newValue';
    } else if (record.itemDescription?.length == 2) {
      final oldValue =
          (record.itemDescription?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUndescribed.tr : record.itemDescription!.firstOrNull!;
      final lastValue = record.itemDescription?.lastOrNull;

      if (lastValue?.isEmpty ?? true) {
        result += '\n${EnumLocale.warehouseDescriptionRemove.tr}: $oldValue';
      } else {
        final newValue = lastValue!;
        result += '\n${EnumLocale.warehouseDescriptionUpdate.trArgs([oldValue, newValue])}';
      }
    }

    // 處理分類
    if (record.categoryName?.length == 1) {
      final newValue = (record.categoryName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : record.categoryName!.firstOrNull!;
      result += '\n${EnumLocale.createCategory.tr}: $newValue';
    } else if (record.categoryName?.length == 2) {
      final oldValue = (record.categoryName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : record.categoryName!.firstOrNull!;
      final lastValue = record.categoryName?.lastOrNull;

      if (lastValue?.isEmpty ?? true) {
        result += '\n${EnumLocale.warehouseCategoryRemove.tr}: $oldValue';
      } else {
        final newValue = lastValue!;
        result += '\n${EnumLocale.warehouseCategoryUpdate.trArgs([oldValue, newValue])}';
      }
    }

    // 處理照片
    if (record.itemPhoto?.length == 1) {
      result += '\n${EnumLocale.warehousePhotoAdd.tr}';
    } else if (record.itemPhoto?.length == 2) {
      final lastPhoto = record.itemPhoto?.lastOrNull;

      if (lastPhoto?.isEmpty ?? true) {
        result += '\n${EnumLocale.warehousePhotoDelete.tr}';
      } else {
        result += '\n${EnumLocale.warehousePhotoUpdate.tr}';
      }
    }

    // 處理最低庫存數量
    if (record.itemMinStockCount?.length == 2) {
      final oldValue = record.itemMinStockCount?.firstOrNull;
      final newValue = record.itemMinStockCount?.lastOrNull;
      result += '\n${EnumLocale.warehouseMinStockUpdate.trArgs([
            oldValue?.toString() ?? '-',
            newValue?.toString() ?? '-',
          ])}';
    }

    return result;
  }

  static String _genItemQuantityContent(ItemRecord record) {
    final cabinetName = record.cabinetName?.firstOrNull ?? '-';
    final oldQuantity = record.quantityCount?.firstOrNull ?? 0;
    final newQuantity = record.quantityCount?.lastOrNull ?? 0;

    return '\n$cabinetName ${EnumLocale.warehouseAdjustQuantity.tr}: ${oldQuantity.toString()} -> ${newQuantity.toString()}';
  }

  static String _genItemPositionContent(ItemRecord record) {
    if (record.cabinetName?.length == 1) {
      final itemName = record.itemName?.firstOrNull ?? '-';
      final cabinetName = record.cabinetName?.firstOrNull ?? '-';
      final str = EnumLocale.warehouseRemoveItemFromCabinet.trArgs([cabinetName, itemName]);
      return '\n$str';
    } else {
      final oldCabinetName = record.cabinetName?.firstOrNull ?? '-';
      final newCabinetName = record.cabinetName?.lastOrNull ?? '-';
      final quantity = record.quantityCount?.firstOrNull ?? 0;
      final str = EnumLocale.warehouseMoveQuantity.tr;
      return '\n$oldCabinetName -> $newCabinetName $str: ${quantity.toString()}';
    }
  }

  static String _genCabinetContent(ItemRecord record, EnumOperateType eOpType) {
    String result = '';

    if (record.cabinetName?.length == 1) {
      final roomName = record.cabinetRoomName?.firstOrNull ?? EnumLocale.warehouseUnboundRoom.tr;
      final cabinetName = (record.cabinetName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : record.cabinetName!.firstOrNull!;
      result +=
          '\n${(eOpType == EnumOperateType.create) ? EnumLocale.warehouseTagTypeCreateCabinet.tr : EnumLocale.warehouseTagTypeDeleteCabinet.tr}: $roomName > $cabinetName';
    } else if (record.cabinetName?.length == 2) {
      final oldRoomName = record.cabinetRoomName?.firstOrNull ?? EnumLocale.warehouseUnboundRoom.tr;
      final newRoomName = record.cabinetRoomName?.lastOrNull ?? EnumLocale.warehouseUnboundRoom.tr;
      final oldCabinetName = (record.cabinetName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : record.cabinetName!.firstOrNull!;
      final newCabinetName = (record.cabinetName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : record.cabinetName!.lastOrNull!;
      final oldValue = '$oldRoomName > $oldCabinetName';
      final newValue = '$newRoomName > $newCabinetName';
      result += '\n${EnumLocale.warehouseNameUpdate.trArgs([oldValue, newValue])}';
    }

    if (record.cabinetRoomName?.length == 2) {
      final oldValue =
          (record.cabinetRoomName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : record.cabinetRoomName!.firstOrNull!;
      final newValue =
          (record.cabinetRoomName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : record.cabinetRoomName!.lastOrNull!;
      result += '\n${EnumLocale.warehouseRoomUpdate.trArgs([oldValue, newValue])}';
    }

    return result;
  }

  static String _genCategoryContent(ItemRecord record, EnumOperateType eOpType) {
    String result = '';

    if (record.categoryName?.length == 1) {
      final newValue = (record.categoryName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : record.categoryName!.firstOrNull!;
      result += '\n${(eOpType == EnumOperateType.create) ? EnumLocale.createCategory.tr : EnumLocale.deleteCategory.tr}: $newValue';
    } else if (record.categoryName?.length == 2) {
      final oldValue = (record.categoryName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : record.categoryName!.firstOrNull!;
      final newValue = (record.categoryName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : record.categoryName!.lastOrNull!;
      result += EnumLocale.warehouseCategoryUpdate.trArgs([oldValue, newValue]);
    }

    return result;
  }
}
