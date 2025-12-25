part of 'warehouse_item_page.dart';

class WarehouseItemPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseItemPageModel();
  final _service = WarehouseService.instance;
  List<WarehouseNameIdModel> get getfilterRuleForRooms => _model.filterRuleForRooms;
  String getItemCategoriesName(Item item) => _service.convertCategoriesName(item);
  int get getTotalLowStockCount => _service.getAllLowStockItems.length;
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
    final allItems = _service.getAllItems;
    final Set<String> allCategoryIds = {};

    void extractCategories(dynamic category) {
      if (category == null) {
        return;
      }

      final categoryId = category.id;
      if (categoryId is String && categoryId.isNotEmpty) {
        allCategoryIds.add(categoryId);
      }

      if (category.children != null) {
        extractCategories(category.children);
      }
    }

    for (var item in allItems) {
      extractCategories(item.category);
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
    final lowStockItemIds = _service.getAllLowStockItems.map((item) => item.id).toList();
    return lowStockItemIds.contains(item.id);
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

  // 設定分類篩選條件為全部
  void _setFilterIndexForCategoryToAll() {
    _model.filterIndexForCategories.value = {for (int i = 0; i < _model.filterRuleForCategories.value.length; i++) i};
  }

  // 扁平化所有櫥櫃
  List<Cabinet> _flattenAllCabinets() {
    return _model.allRoomCabinetItems.value?.expand<Cabinet>((room) => room.cabinets ?? []).toList() ?? [];
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
      allItems = _service.getAllItems;
    } else if (cabinetIndex == 0) {
      allItems = _model.allRoomCabinetItems.value
              ?.where((room) => room.roomId == roomId)
              .expand<Cabinet>((room) => room.cabinets ?? [])
              .expand<Item>((cabinet) => cabinet.items ?? [])
              .toList() ??
          [];
    } else {
      final matchedRoom = _model.allRoomCabinetItems.value?.firstWhereOrNull((room) => room.roomId == roomId);
      final matchedCabinet = matchedRoom?.cabinets?.firstWhereOrNull((cabinet) => cabinet.id == cabinetId);
      allItems = matchedCabinet?.items ?? [];
    }

    final Set<String> matchCategoryIds = {};

    for (var item in allItems) {
      if ((item.category?.id?.isNotEmpty ?? false) && !matchCategoryIds.contains(item.category!.id)) {
        matchCategoryIds.add(item.category!.id!);
        resultRules.add(WarehouseNameIdModel(id: item.category!.id, name: item.category!.name ?? ''));
      }
    }

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
    List<Item> matchItems = [..._service.getAllItems];
    List<Item> combineItems = [];
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

    if (matchItems.isNotEmpty) {
      final Map<String, List<Item>> groupedItems = {};
      for (var item in matchItems) {
        final itemId = item.id ?? '';
        if (itemId.isNotEmpty) {
          groupedItems.putIfAbsent(itemId, () => []).add(item);
        }
      }

      for (var entry in groupedItems.entries) {
        final items = entry.value;

        if (items.isEmpty) {
          continue;
        }

        final baseItem = items.first;
        final totalQuantity = items.fold<int>(
          0,
          (sum, item) => sum + (item.quantity ?? 0),
        );

        final combinedItem = baseItem.copyWith(quantity: totalQuantity);
        combineItems.add(combinedItem);
      }
    }

    _model.visibleItems.value = combineItems;
  }

  /// 递归收集分类及其所有子分类的 ID
  void _collectCategoryIds(dynamic category, Set<String> categoryIds) {
    if (category == null) return;

    final categoryId = category.id;
    if (categoryId != null && categoryId is String && categoryId.isNotEmpty) {
      categoryIds.add(categoryId);
    }

    // 处理子分类（getAllCategories 返回的是 List<Category>，每个 Category 的 children 是 List<Category>）
    final children = category.children;
    if (children != null) {
      if (children is List) {
        for (var child in children) {
          _collectCategoryIds(child, categoryIds);
        }
      } else {
        // 如果是单个 Category（Item 的 category.children 是单个 Category）
        _collectCategoryIds(children, categoryIds);
      }
    }
  }

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
}
