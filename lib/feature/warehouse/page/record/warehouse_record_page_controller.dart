part of 'warehouse_record_page.dart';

class WarehouseRecordPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseRecordPageModel();
  final _service = WarehouseService.instance;
  final scrollController = ScrollController();
  List<int> get columnRatioRx => _model.columnRatio;
  String get avatarUrl => _model.avatarUrl;
  RxReadonly<List<Log>?> get allLogsRx => _model.allLogs.readonly;
  RxReadonly<List<Log>> get visibleLogsRx => _model.visibleLogs.readonly;
  RxReadonly<bool> get isShowFilterMenuRx => _model.isShowFilterMenu.readonly;
  RxReadonly<EnumFilterType> get filterTypeRx => _model.filterType.readonly;
  RxReadonly<EnumRecordType?> get selectedLogTypeRx => _model.selectedLogType.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[WarehouseRecordPageController] onInit - $hashCode');
    _checkData();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[WarehouseRecordPageController] onClose - $hashCode');
    scrollController.dispose();
    super.onClose();
  }

  // MARK: - Public Method

  EnumTagType genTagType(Log log) {
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

  String genContent(Log log) {
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

  // MARK: - Private Method

  void _checkData() {
    final allLogs = _service.getAllLogs;

    if (allLogs == null) {
      _queryApiData();
    } else {
      _model.allLogs.value = allLogs;
      _genVisibleLogs();
    }
  }

  Future<void> _queryApiData() async {
    final response = await _service.apiReqFetchLogs(WarehouseLogRequestModel());
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

  String _genItemQuantityContent(Log log) {
    String result = '';

    if (log.itemQuantity != null) {
      final quantity = log.itemQuantity!;
      final oldCount = quantity.totalCount?.firstOrNull ?? '-';
      final newCount = quantity.totalCount?.lastOrNull ?? '-';
      final itemName = (log.itemName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.firstOrNull!;
      final strTotalCount = EnumLocale.warehouseItemTotalQuantityChange.tr
          .replaceAll('{itemName}', itemName)
          .replaceAll('{oldCount}', oldCount.toString())
          .replaceAll('{newCount}', newCount.toString());
      result += strTotalCount;

      for (ItemQuantityCabinet cabinet in quantity.cabinets ?? []) {
        final oldCount = cabinet.count?.firstOrNull ?? '-';
        final newCount = cabinet.count?.lastOrNull ?? '-';
        final cabinetName = cabinet.cabinetName ?? '-';
        final strCabinet = EnumLocale.warehouseCabinetQuantityChange.tr
            .replaceAll('{cabinetName}', cabinetName)
            .replaceAll('{oldCount}', oldCount.toString())
            .replaceAll('{newCount}', newCount.toString());
        result += '\n$strCabinet';
      }
    }

    return result;
  }

  String _genItemPositionContent(Log log) {
    final position = log.itemPosition;
    String result = '';

    if (log.itemName?.length == 1) {
      final oldValue = (log.itemName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.firstOrNull!;
      result += oldValue;
    }

    if (position != null) {
      for (ItemPositionCabinet cabinet in position.cabinets ?? []) {
        final oldName = (cabinet.cabinetName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : cabinet.cabinetName!.firstOrNull!;
        final newName = (cabinet.cabinetName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : cabinet.cabinetName!.lastOrNull!;
        final count = cabinet.count ?? '-';
        final strCabinet = EnumLocale.warehouseMoveFromTo.tr
            .replaceAll('{oldName}', oldName)
            .replaceAll('{newName}', newName)
            .replaceAll('{count}', count.toString());
        result += '\n$strCabinet';
      }
    }

    return result;
  }

  String _genItemNormalContent(Log log) {
    String result = '';

    if (log.itemName?.length == 1) {
      final oldValue = (log.itemName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.firstOrNull!;
      result += oldValue;
    } else if (log.itemName?.length == 2) {
      final oldValue = (log.itemName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.firstOrNull!;
      final newValue = (log.itemName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.itemName!.lastOrNull!;
      final str = EnumLocale.warehouseNameUpdate.tr.replaceAll('{oldValue}', oldValue).replaceAll('{newValue}', newValue);
      result += str;
    }

    if (log.itemDescription?.length == 2) {
      final oldValue = (log.itemDescription?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUndescribed.tr : log.itemDescription!.firstOrNull!;
      final newValue = (log.itemDescription?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUndescribed.tr : log.itemDescription!.lastOrNull!;
      result += '\n${EnumLocale.warehouseDescriptionUpdate.tr.replaceAll('{oldValue}', oldValue).replaceAll('{newValue}', newValue)}';
    }

    if (log.categoryName?.length == 2) {
      final oldValue = (log.categoryName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.categoryName!.firstOrNull!;
      final newValue = (log.categoryName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.categoryName!.lastOrNull!;
      result += '\n${EnumLocale.warehouseCategoryUpdate.tr.replaceAll('{oldValue}', oldValue).replaceAll('{newValue}', newValue)}';
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
        result +=
            '\n${EnumLocale.warehouseMinStockUpdate.tr.replaceAll('{oldValue}', oldValue.toString()).replaceAll('{newValue}', newValue.toString())}';
      }
    }

    return result;
  }

  String _genCabinetContent(Log log) {
    String result = '';

    if (log.cabinetName?.length == 1) {
      final oldValue = (log.cabinetName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.cabinetName!.firstOrNull!;
      result += oldValue;
    } else if (log.cabinetName?.length == 2) {
      final oldValue = (log.cabinetName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.cabinetName!.firstOrNull!;
      final newValue = (log.cabinetName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUnnamed.tr : log.cabinetName!.lastOrNull!;
      result += EnumLocale.warehouseNameUpdate.tr.replaceAll('{oldValue}', oldValue).replaceAll('{newValue}', newValue);
    }

    if (log.cabinetRoomName?.length == 2) {
      final oldValue = (log.cabinetRoomName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.cabinetRoomName!.firstOrNull!;
      final newValue = (log.cabinetRoomName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.cabinetRoomName!.lastOrNull!;
      result += '\n${EnumLocale.warehouseRoomUpdate.tr.replaceAll('{oldValue}', oldValue).replaceAll('{newValue}', newValue)}';
    }

    return result;
  }

  String _genCategoryContent(Log log) {
    String result = '';

    if (log.categoryName?.length == 2) {
      final oldValue = (log.categoryName?.firstOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.categoryName!.firstOrNull!;
      final newValue = (log.categoryName?.lastOrNull?.isEmpty ?? true) ? EnumLocale.warehouseUncategorized.tr : log.categoryName!.lastOrNull!;
      result += EnumLocale.warehouseCategoryUpdate.tr.replaceAll('{oldValue}', oldValue).replaceAll('{newValue}', newValue);
    }

    return result;
  }
}
