part of 'warehouse_item_page.dart';

class WarehouseItemPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseItemPageModel();
  final _service = WarehouseService.instance;
  List<WarehouseNameIdModel> get getfilterRuleForRooms => _model.filterRuleForRooms;
  String getItemCategoriesName(Item item) => _service.convertCategoriesName(item);
  RxReadonly<List<Item>> get visibleItemsRx => _model.visibleItems.readonly;
  RxReadonly<List<Room>?> get allItemsRx => _model.allRoomCabinetItems.readonly;
  RxReadonly<bool> get isFilterExpandedRx => _model.isFilterExpanded.readonly;
  RxReadonly<int> get filterIndexForRoomsRx => _model.filterIndexForRooms.readonly;
  RxReadonly<int> get cabinetFilterSelectedIndexRx => _model.filterIndexForCabinets.readonly;
  RxReadonly<Set<int>> get categoryFilterSelectedIndicesRx => _model.filterIndexForCategories.readonly;
  RxReadonly<DialogItemSearchOutputModel?> get searchConditionRx => _model.searchCondition.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[WarehouseItemPageController] onInit - $hashCode');
    _genFilterRuleForRoom();
    _queryApiData();
    _listen();
  }

  @override
  void onClose() {
    LogUtil.i(EnumLogType.debug, '[WarehouseItemPageController] onClose - $hashCode');
    super.onClose();
  }

  // MARK: - Public Methods

  int getTotalItemCount() {
    return _model.allRoomCabinetItems.value?.fold<int>(0, (sum, room) => sum + (room.quantity ?? 0)) ?? 0;
  }

  int getTotalCategoryCount() {
    final allItems = _service.getAllCombineItems;
    final Set<String> allCategoryIds = {};

    void extractCategory(Category? category) {
      if (category?.id?.isEmpty ?? true) {
        return;
      }

      allCategoryIds.add(category!.id!);
      extractCategory(category.children);
    }

    for (var item in allItems) {
      extractCategory(item.category);
    }

    return allCategoryIds.length;
  }

  List<String> getFilterRoomNameList() {
    return _model.filterRuleForRooms.map((r) => r.name ?? '').toList();
  }

  List<String> getFilterCabinetNameList() {
    return _model.filterRuleForCabinets.value.map((c) => c.name ?? '').toList();
  }

  List<String> getFilterCategoryNameList() {
    return _model.filterRuleForCategories.value.map((c) => c.name ?? '').toList();
  }

  bool isShowStockWarningTag(Item item) {
    final minStockAlert = item.minStockAlert ?? 0;
    final quantity = item.quantity ?? 0;

    if (minStockAlert > 0) {
      return quantity < minStockAlert;
    }

    return false;
  }

  int get getTotalLowStockCount {
    return _service.getAllCombineItems.where(isShowStockWarningTag).length;
  }

  // MARK: - Private Methods

  Future<void> _queryApiData() async {
    final response = await _service.apiReqFetchItems(WarehouseItemRequestModel());

    if (response == null) {
      return;
    }

    _model.allRoomCabinetItems.value = response;

    // 恢復所有篩選條件索引值
    _model.filterIndexForRooms.value = 0;
    _model.filterIndexForCabinets.value = 0;
    _model.filterIndexForCategories.value = {};

    // 生成篩選條件
    _genFilterRuleForCabinet();
    _genAllFilterRuleAndItemForCategory();
    _genVisibleItems();
  }

  Future<bool> _updateItemNormal(Item item, DialogItemNormalEditOutputModel model) async {
    String errMsg = '';

    final requestModel = WarehouseItemRequestModel(
      itemId: item.id,
      categoryId: model.categoryId,
    );

    final response = await _service.apiReqModifyItem(
      requestModel,
      onError: (error) {
        errMsg = '[${error.code}] ${error.message ?? ''}';
      },
    );

    final isSuccess = response != null;

    if (isSuccess) {
      _service.showSnackBar(title: '更新物品成功');
      _service.apiReqFetchItems(WarehouseItemRequestModel());
      return true;
    } else {
      _service.showSnackBar(title: '更新物品失敗', message: errMsg);
      return false;
    }
  }

  // 設定分類篩選條件為全部
  void _setFilterIndexForCategoryToAll() {
    _model.filterIndexForCategories.value = {for (int i = 0; i < _model.filterRuleForCategories.value.length; i++) i};
  }

  // 扁平化所有物品
  List<Item> _flattenAllItems() {
    return _model.allRoomCabinetItems.value?.expand<Cabinet>((room) => room.cabinets ?? []).expand<Item>((cabinet) => cabinet.items ?? []).toList() ??
        [];
  }

  // 扁平化所有櫥櫃
  List<Cabinet> _flattenAllCabinets() {
    return _model.allRoomCabinetItems.value?.expand<Cabinet>((room) => room.cabinets ?? []).toList() ?? [];
  }

  // 取得第一階分類
  List<WarehouseNameIdModel> _genFirstLevelCategory(List<Item> items) {
    final Set<String> matchCategoryIds = {};
    final List<WarehouseNameIdModel> resultCategory = [];

    for (var item in items) {
      if ((item.category?.id?.isNotEmpty ?? false) && !matchCategoryIds.contains(item.category!.id)) {
        matchCategoryIds.add(item.category!.id!);
        resultCategory.add(WarehouseNameIdModel(id: item.category!.id, name: item.category!.name ?? ''));
      }
    }

    return resultCategory;
  }

  // 生成房間篩選列表
  void _genFilterRuleForRoom() {
    _model.filterRuleForRooms.clear();
    _model.filterRuleForRooms.addAll([
      WarehouseNameIdModel(id: 'all', name: EnumLocale.optionAll.tr),
      ..._service.rooms,
    ]);
  }

  // 生成櫥櫃篩選列表
  void _genFilterRuleForCabinet() {
    final allRoomsCabinets = _model.allRoomCabinetItems.value ?? [];
    final roomIdx = _model.filterIndexForRooms.value;
    final List<WarehouseNameIdModel> resultRules = [WarehouseNameIdModel(id: 'all', name: EnumLocale.optionAll.tr)];

    if (roomIdx == 0) {
      final allCabinets = _flattenAllCabinets();
      resultRules.addAll(allCabinets.map((cabinet) => WarehouseNameIdModel(id: cabinet.id ?? '', name: cabinet.name ?? '')));
    } else {
      final roomId = _model.filterRuleForRooms[roomIdx].id;
      final room = allRoomsCabinets.firstWhereOrNull((room) => room.roomId == roomId);
      final cabinets = room?.cabinets ?? <Cabinet>[];
      resultRules.addAll(cabinets.map((cabinet) => WarehouseNameIdModel(id: cabinet.id ?? '', name: cabinet.name ?? '')));
    }

    _model.filterRuleForCabinets.value = resultRules;
  }

  // 生成所有分類篩選和物品列表
  void _genAllFilterRuleAndItemForCategory() {
    List<Item> allItems = [];
    final roomIndex = _model.filterIndexForRooms.value;
    final cabinetIndex = _model.filterIndexForCabinets.value;
    final roomId = _model.filterRuleForRooms[roomIndex].id;
    final cabinetId = _model.filterRuleForCabinets.value[cabinetIndex].id;
    final List<WarehouseNameIdModel> resultRules = [WarehouseNameIdModel(id: 'all', name: EnumLocale.optionAll.tr)];

    if (roomIndex == 0 && cabinetIndex == 0) {
      allItems = _flattenAllItems();
    } else if (roomIndex != 0 && cabinetIndex == 0) {
      allItems = _model.allRoomCabinetItems.value
              ?.where((room) => room.roomId == roomId)
              .expand<Cabinet>((room) => room.cabinets ?? [])
              .expand<Item>((cabinet) => cabinet.items ?? [])
              .toList() ??
          [];
    } else {
      final allCabinets = _flattenAllCabinets();
      final matchCabinet = allCabinets.firstWhereOrNull((cabinet) => cabinet.id == cabinetId);
      allItems = matchCabinet?.items ?? [];
    }

    allItems = _service.combineItems(allItems);
    resultRules.addAll(_genFirstLevelCategory(allItems));
    _model.filterRuleForCategories.value = resultRules;
    _model.allItemsForCategory.clear();
    _model.allItemsForCategory.addAll(allItems);
    _setFilterIndexForCategoryToAll();
    _genVisibleItems();
  }

  // 生成篩選條件下可顯示的物品列表
  void _genVisibleItems() {
    final selectedIndexes = _model.filterIndexForCategories.value;
    final List<Item> resultItems = [];

    if (selectedIndexes.contains(0)) {
      resultItems.addAll(_model.allItemsForCategory);
    } else {
      // 從選中的索引中取得對應的分類 ID
      final categoryIds =
          selectedIndexes.map((index) => _model.filterRuleForCategories.value[index].id).where((id) => id != null && id.isNotEmpty).toSet();
      // 篩選出分類 ID 在選中列表中的物品
      resultItems.addAll(_model.allItemsForCategory.where((item) => categoryIds.contains(item.category?.id ?? '')).toList());
    }

    _model.visibleItems.value = resultItems;
  }

  void _genVisibleItemsBySearchCondition() {
    List<Item> matchItems = [..._service.getAllCombineItems];
    final model = _model.searchCondition.value;
    final lv1Id = model?.categoryLevel1?.id ?? '';
    final lv2Id = model?.categoryLevel2?.id ?? '';
    final lv3Id = model?.categoryLevel3?.id ?? '';
    final str = model?.searchText ?? '';

    if (lv1Id.isEmpty && lv2Id.isEmpty && lv3Id.isEmpty && str.isEmpty) {
      _model.searchCondition.value = null;
      _service.clearSearchCondition();
      return;
    }

    if (lv1Id.isNotEmpty) {
      matchItems.removeWhere((item) => item.category?.id != lv1Id);

      if (lv2Id.isNotEmpty) {
        matchItems.removeWhere((item) => item.category?.children?.id != lv2Id);

        if (lv3Id.isNotEmpty) {
          matchItems.removeWhere((item) => item.category?.children?.children?.id != lv3Id);
        }
      }
    }

    if (str.isNotEmpty) {
      final searchText = str.toLowerCase();
      matchItems.removeWhere((item) {
        final name = (item.name ?? '').toLowerCase();
        final description = (item.description ?? '').toLowerCase();
        return !name.contains(searchText) && !description.contains(searchText);
      });
    }

    _model.visibleItems.value = matchItems;
  }

  /// 递归收集分类及其所有子分类的 ID
  // void _collectCategoryIds(dynamic category, Set<String> categoryIds) {
  //   if (category == null) return;

  //   final categoryId = category.id;
  //   if (categoryId != null && categoryId is String && categoryId.isNotEmpty) {
  //     categoryIds.add(categoryId);
  //   }

  //   // 处理子分类（getAllCategories 返回的是 List<Category>，每个 Category 的 children 是 List<Category>）
  //   final children = category.children;
  //   if (children != null) {
  //     if (children is List) {
  //       for (var child in children) {
  //         _collectCategoryIds(child, categoryIds);
  //       }
  //     } else {
  //       // 如果是单个 Category（Item 的 category.children 是单个 Category）
  //       _collectCategoryIds(children, categoryIds);
  //     }
  //   }
  // }

  // 用戶選擇分類多選框時，重新計算全選狀態
  void _changeCategoryMultiCheckbox(int index) {
    final currentSelectedIndices = Set<int>.from(_model.filterIndexForCategories.value);

    if (index == 0) {
      if (currentSelectedIndices.contains(index)) {
        _model.filterIndexForCategories.value = {};
      } else {
        _setFilterIndexForCategoryToAll();
      }
    } else {
      if (currentSelectedIndices.contains(index)) {
        currentSelectedIndices.remove(index);
      } else {
        currentSelectedIndices.add(index);
      }

      final totalCount = _model.filterRuleForCategories.value.length;
      final allOthersSelected = currentSelectedIndices.where((i) => i != 0).length == totalCount - 1;

      if (allOthersSelected && !currentSelectedIndices.contains(0)) {
        currentSelectedIndices.add(0);
      } else if (!allOthersSelected && currentSelectedIndices.contains(0)) {
        currentSelectedIndices.remove(0);
      }

      _model.filterIndexForCategories.value = Set<int>.from(currentSelectedIndices);
    }
  }

  // 監聽
  void _listen() {
    ever(_service.searchConditionRx.rx, (model) {
      if (model != null) {
        _model.searchCondition.value = model;
        _genVisibleItemsBySearchCondition();
      }
    });
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
