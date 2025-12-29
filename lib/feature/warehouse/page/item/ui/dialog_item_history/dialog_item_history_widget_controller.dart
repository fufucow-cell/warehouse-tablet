import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_history/dialog_item_history_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/ui/dialog_item_info/dialog_item_info_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_log_request_model/warehouse_log_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_position.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_record.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'dialog_item_history_widget_interactive.dart';
part 'dialog_item_history_widget_route.dart';

class DialogItemHistoryWidgetController extends GetxController {
  // MARK: - Properties

  final DialogItemHistoryWidgetModel _model = DialogItemHistoryWidgetModel();
  final _service = WarehouseService.instance;
  RxReadonly<List<ItemRecord>?> get recordsRx => _model.records.readonly;
  String get getItemName => _model.combineItem?.name ?? '';

  // MARK: - Init

  DialogItemHistoryWidgetController(Item item) {
    _model.combineItem = item;
  }

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug,
        '[DialogItemHistoryWidgetController] onInit - $hashCode');
    _loadData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug,
        '[DialogItemHistoryWidgetController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Private Methods

  Future<void> _loadData() async {
    String errMsg = '';
    final records = _service.allRecordsRx.value;

    if (records == null) {
      final response = await _service.apiReqFetchLogs(
        WarehouseRecordRequestModel(),
        onError: (error) {
          errMsg = '[${error.code}] ${error.message ?? ''}';
          _service.showSnackBar(title: 'GG', message: errMsg);
        },
      );

      if (response != null) {
        _filterItemRecords(response);
      }
    } else {
      _filterItemRecords(records);
    }
  }

  void _filterItemRecords(List<ItemRecord> records) {
    _model.records.value = records
        .where((record) => record.itemId == _model.combineItem?.id)
        .toList()
      ..sort((a, b) {
        final aTime = a.createdAt ?? 0;
        final bTime = b.createdAt ?? 0;
        return bTime.compareTo(aTime); // 降序：最新的在前
      });
  }

  // MARK: - Public Methods

  String formatDate(int? timestamp) {
    if (timestamp == null) {
      return '-';
    }
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String genTag(ItemRecord log) {
    final operateType = EnumOperateType.fromInt(log.operateType);
    final entityType = EnumEntityType.fromInt(log.entityType);

    EnumTagType tagType;
    switch (operateType) {
      case EnumOperateType.create:
        tagType = switch (entityType) {
          EnumEntityType.item => EnumTagType.createItem,
          EnumEntityType.cabinet => EnumTagType.createCabinet,
          EnumEntityType.category => EnumTagType.createCategory,
          _ => EnumTagType.unknown,
        };
      case EnumOperateType.update:
        if (entityType == EnumEntityType.item) {
          if (log.itemQuantity != null) {
            tagType = EnumTagType.updateQuantity;
          } else if (log.itemPosition != null) {
            tagType = EnumTagType.updatePosition;
          } else {
            tagType = EnumTagType.updateItem;
          }
        } else {
          tagType = switch (entityType) {
            EnumEntityType.item => EnumTagType.updateItem,
            EnumEntityType.cabinet => EnumTagType.updateCabinet,
            EnumEntityType.category => EnumTagType.updateCategory,
            _ => EnumTagType.unknown,
          };
        }
      case EnumOperateType.delete:
        tagType = switch (entityType) {
          EnumEntityType.item => EnumTagType.deleteItem,
          EnumEntityType.cabinet => EnumTagType.deleteCabinet,
          EnumEntityType.category => EnumTagType.deleteCategory,
          _ => EnumTagType.unknown,
        };
      default:
        tagType = EnumTagType.unknown;
    }
    return tagType.title;
  }

  String genContent(ItemRecord log) {
    final operateType = EnumOperateType.fromInt(log.operateType);
    final entityType = EnumEntityType.fromInt(log.entityType);

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

  String _genItemQuantityContent(ItemRecord log) {
    String result = '';

    if (log.itemQuantity != null) {
      final quantity = log.itemQuantity!;
      final oldCount = quantity.totalCount?.firstOrNull ?? '-';
      final newCount = quantity.totalCount?.lastOrNull ?? '-';
      final itemName = (log.itemName?.firstOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUnnamed.tr
          : log.itemName!.firstOrNull!;
      final strTotalCount = EnumLocale.warehouseItemTotalQuantityChange.trArgs([
        itemName,
        oldCount.toString(),
        newCount.toString(),
      ]);
      result += strTotalCount;

      for (Cabinet cabinet in quantity.cabinets ?? []) {
        final oldCount = cabinet.count?.firstOrNull ?? '-';
        final newCount = cabinet.count?.lastOrNull ?? '-';
        final cabinetName = cabinet.cabinetName ?? '-';
        final strCabinet = EnumLocale.warehouseCabinetQuantityChange.trArgs([
          cabinetName,
          oldCount.toString(),
          newCount.toString(),
        ]);
        result += '\n$strCabinet';
      }
    }

    return result;
  }

  String _genItemPositionContent(ItemRecord log) {
    String result = '';

    if (log.itemName?.length == 1) {
      final oldValue = (log.itemName?.firstOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUnnamed.tr
          : log.itemName!.firstOrNull!;
      result += oldValue;
    }

    if (log.itemPosition != null) {
      for (ItemPosition position in log.itemPosition ?? []) {
        final oldName = (position.cabinetName?.firstOrNull?.isEmpty ?? true)
            ? EnumLocale.warehouseUnnamed.tr
            : position.cabinetName!.firstOrNull!;
        final newName = (position.cabinetName?.lastOrNull?.isEmpty ?? true)
            ? EnumLocale.warehouseUnnamed.tr
            : position.cabinetName!.lastOrNull!;
        final count = position.count ?? '-';
        final strCabinet = EnumLocale.warehouseMoveFromTo
            .trArgs([oldName, newName, count.toString()]);
        result += '\n$strCabinet';
      }
    }

    return result;
  }

  String _genItemNormalContent(ItemRecord log) {
    String result = '';

    if (log.itemName?.length == 1) {
      final oldValue = (log.itemName?.firstOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUnnamed.tr
          : log.itemName!.firstOrNull!;
      result += oldValue;
    } else if (log.itemName?.length == 2) {
      final oldValue = (log.itemName?.firstOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUnnamed.tr
          : log.itemName!.firstOrNull!;
      final newValue = (log.itemName?.lastOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUnnamed.tr
          : log.itemName!.lastOrNull!;
      final str = EnumLocale.warehouseNameUpdate.trArgs([oldValue, newValue]);
      result += str;
    }

    if (log.itemDescription?.length == 2) {
      final oldValue = (log.itemDescription?.firstOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUndescribed.tr
          : log.itemDescription!.firstOrNull!;
      final newValue = (log.itemDescription?.lastOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUndescribed.tr
          : log.itemDescription!.lastOrNull!;
      result += '\n${EnumLocale.warehouseDescriptionUpdate.trArgs([
            oldValue,
            newValue
          ])}';
    }

    if (log.categoryName?.length == 2) {
      final oldValue = (log.categoryName?.firstOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUncategorized.tr
          : log.categoryName!.firstOrNull!;
      final newValue = (log.categoryName?.lastOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUncategorized.tr
          : log.categoryName!.lastOrNull!;
      result += '\n${EnumLocale.warehouseCategoryUpdate.trArgs([
            oldValue,
            newValue
          ])}';
    }

    return result;
  }

  String _genCabinetContent(ItemRecord log) {
    String result = '';

    if (log.cabinetName?.length == 1) {
      final oldValue = (log.cabinetName?.firstOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUnnamed.tr
          : log.cabinetName!.firstOrNull!;
      result += oldValue;
    } else if (log.cabinetName?.length == 2) {
      final oldValue = (log.cabinetName?.firstOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUnnamed.tr
          : log.cabinetName!.firstOrNull!;
      final newValue = (log.cabinetName?.lastOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUnnamed.tr
          : log.cabinetName!.lastOrNull!;
      final str = EnumLocale.warehouseNameUpdate.trArgs([oldValue, newValue]);
      result += str;
    }

    if (log.cabinetRoomName?.length == 2) {
      final oldValue = (log.cabinetRoomName?.firstOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUnnamed.tr
          : log.cabinetRoomName!.firstOrNull!;
      final newValue = (log.cabinetRoomName?.lastOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUnnamed.tr
          : log.cabinetRoomName!.lastOrNull!;
      result +=
          '\n${EnumLocale.warehouseRoomUpdate.trArgs([oldValue, newValue])}';
    }

    return result;
  }

  String _genCategoryContent(ItemRecord log) {
    String result = '';

    if (log.categoryName?.length == 1) {
      final oldValue = (log.categoryName?.firstOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUncategorized.tr
          : log.categoryName!.firstOrNull!;
      result += oldValue;
    } else if (log.categoryName?.length == 2) {
      final oldValue = (log.categoryName?.firstOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUncategorized.tr
          : log.categoryName!.firstOrNull!;
      final newValue = (log.categoryName?.lastOrNull?.isEmpty ?? true)
          ? EnumLocale.warehouseUncategorized.tr
          : log.categoryName!.lastOrNull!;
      final str = EnumLocale.warehouseNameUpdate.trArgs([oldValue, newValue]);
      result += str;
    }

    return result;
  }
}
