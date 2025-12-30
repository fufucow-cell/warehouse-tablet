import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/log_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/warehouse_log_request_model/warehouse_log_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_position.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_record.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/log_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

part 'warehouse_record_page_interactive.dart';
part 'warehouse_record_page_route.dart';

class WarehouseRecordPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseRecordPageModel();
  final _service = WarehouseService.instance;
  final scrollController = ScrollController();
  List<int> get columnRatioRx => _model.columnRatio;
  String get avatarUrl => _model.avatarUrl;
  RxReadonly<List<ItemRecord>?> get allLogsRx => _model.allLogs.readonly;
  RxReadonly<List<ItemRecord>> get visibleLogsRx => _model.visibleLogs.readonly;
  RxReadonly<bool> get isShowFilterMenuRx => _model.isShowFilterMenu.readonly;
  RxReadonly<EnumFilterType> get filterTypeRx => _model.filterType.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseRecordPageController] onInit - $hashCode',
    );
    _checkData();
  }

  @override
  void onClose() {
    LogUtil.i(
      EnumLogType.debug,
      '[WarehouseRecordPageController] onClose - $hashCode',
    );
    scrollController.dispose();
    super.onClose();
  }

  // MARK: - Public Method

  EnumTagType genTagType(ItemRecord log) {
    final operateType = EnumOperateType.fromInt(log.operateType);
    final entityType = EnumEntityType.fromInt(log.entityType);

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

  String formatDate(int? timestamp) {
    if (timestamp == null) {
      return '-';
    }

    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  List<String> get getFilterNames {
    return EnumFilterType.values.map((type) => type.title).toList();
  }

  // MARK: - Private Method

  void _checkData() {
    final allLogs = _service.allRecordsRx.value;

    if (allLogs == null) {
      _queryApiData();
    } else {
      _model.allLogs.value = allLogs;
      _genVisibleLogs();
    }
  }

  Future<void> _queryApiData() async {
    final response = await _service.apiReqFetchLogs(WarehouseRecordRequestModel());
    _model.allLogs.value = response;
    _genVisibleLogs();
  }

  void _genVisibleLogs() {
    final allLogs = _model.allLogs.value;

    if (allLogs == null) {
      return;
    }

    final startDate = _model.filterType.value.startDate;

    if (startDate == null) {
      _model.visibleLogs.value = allLogs.where((log) => log.createdAt != null).toList();
      return;
    }

    final startTimestamp = startDate.millisecondsSinceEpoch ~/ 1000;

    final visibleLogs = allLogs.where((log) {
      if (log.createdAt == null) {
        return false;
      }
      return log.createdAt! >= startTimestamp;
    }).toList();

    _model.visibleLogs.value = visibleLogs;
  }

  String _genItemQuantityContent(ItemRecord log) {
    String result = '';

    if (log.itemQuantity != null) {
      final quantity = log.itemQuantity!;
      final oldCount = quantity.totalCount?.firstOrNull ?? '-';
      final newCount = quantity.totalCount?.lastOrNull ?? '-';
      final itemName = (log.itemName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.firstOrNull!;
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
      final oldValue = (log.itemName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.firstOrNull!;
      result += oldValue;
    }

    if (log.itemPosition != null) {
      for (ItemPosition position in log.itemPosition ?? []) {
        final oldName = (position.cabinetName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : position.cabinetName!.firstOrNull!;
        final newName = (position.cabinetName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : position.cabinetName!.lastOrNull!;
        final count = position.count ?? '-';
        final strCabinet = EnumLocale.warehouseMoveFromTo.trArgs([oldName, newName, count.toString()]);
        result += '\n$strCabinet';
      }
    }

    return result;
  }

  String _genItemNormalContent(ItemRecord log) {
    String result = '';

    if (log.itemName?.length == 1) {
      final oldValue = (log.itemName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.firstOrNull!;
      result += oldValue;
    } else if (log.itemName?.length == 2) {
      final oldValue = (log.itemName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.firstOrNull!;
      final newValue = (log.itemName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.lastOrNull!;
      final str = EnumLocale.warehouseNameUpdate.trArgs([oldValue, newValue]);
      result += str;
    }

    if (log.itemDescription?.length == 2) {
      final oldValue = (log.itemDescription?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUndescribed.tr : log.itemDescription!.firstOrNull!;
      final newValue = (log.itemDescription?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUndescribed.tr : log.itemDescription!.lastOrNull!;
      result += '\n${EnumLocale.warehouseDescriptionUpdate.trArgs([
            oldValue,
            newValue,
          ])}';
    }

    if (log.categoryName?.length == 2) {
      final oldValue = (log.categoryName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.categoryName!.firstOrNull!;
      final newValue = (log.categoryName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.categoryName!.lastOrNull!;
      result += '\n${EnumLocale.warehouseCategoryUpdate.trArgs([
            oldValue,
            newValue,
          ])}';
    }

    if (log.itemPhoto?.length == 2) {
      final oldPhoto = (log.itemPhoto?.firstOrNull?.isEmpty ?? true);
      final newPhoto = (log.itemPhoto?.lastOrNull?.isEmpty ?? true);

      if (!oldPhoto && !newPhoto) {
        result += '\n${EnumLocale.warehousePhotoUpdate.tr}';
      } else if (oldPhoto && !newPhoto) {
        result += '\n${EnumLocale.warehousePhotoAdd.tr}';
      } else if (!oldPhoto && newPhoto) {
        result += '\n${EnumLocale.warehousePhotoDelete.tr}';
      }
    }

    if (log.itemMinStockCount?.length == 2) {
      final oldValue = log.itemMinStockCount?.firstOrNull ?? -1;
      final newValue = log.itemMinStockCount?.lastOrNull ?? -1;

      if (oldValue >= 0 && newValue >= 0 && oldValue != newValue) {
        result += '\n${EnumLocale.warehouseMinStockUpdate.trArgs([
              oldValue.toString(),
              newValue.toString(),
            ])}';
      }
    }

    return result;
  }

  String _genCabinetContent(ItemRecord log) {
    String result = '';

    if (log.cabinetName?.length == 1) {
      final oldValue = (log.cabinetName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.cabinetName!.firstOrNull!;
      result += oldValue;
    } else if (log.cabinetName?.length == 2) {
      final oldValue = (log.cabinetName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.cabinetName!.firstOrNull!;
      final newValue = (log.cabinetName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.cabinetName!.lastOrNull!;
      result += EnumLocale.warehouseNameUpdate.trArgs([oldValue, newValue]);
    }

    if (log.cabinetRoomName?.length == 2) {
      final oldValue = (log.cabinetRoomName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.cabinetRoomName!.firstOrNull!;
      final newValue = (log.cabinetRoomName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.cabinetRoomName!.lastOrNull!;
      result += '\n${EnumLocale.warehouseRoomUpdate.trArgs([oldValue, newValue])}';
    }

    return result;
  }

  String _genCategoryContent(ItemRecord log) {
    String result = '';

    if (log.categoryName?.length == 2) {
      final oldValue = (log.categoryName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.categoryName!.firstOrNull!;
      final newValue = (log.categoryName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.categoryName!.lastOrNull!;
      result += EnumLocale.warehouseCategoryUpdate.trArgs([oldValue, newValue]);
    }

    return result;
  }
}
