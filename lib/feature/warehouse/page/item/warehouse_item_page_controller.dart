part of 'warehouse_item_page.dart';

class WarehouseItemPageController extends GetxController {
  // MARK: - Properties

  final _model = WarehouseItemPageModel();
  final _service = WarehouseService.instance;
  List<WarehouseNameIdModel> get getfilterRuleForRooms => _model.filterRuleForRooms;
  RxReadonly<List<Item>> get visibleItemsRx => _model.visibleItems.readonly;
  RxReadonly<List<Room>?> get allItemsRx => _model.allRoomCabinetItems.readonly;
  RxReadonly<bool> get isFilterExpandedRx => _model.isFilterExpanded.readonly;
  RxReadonly<int> get filterIndexForRoomsRx => _model.filterIndexForRooms.readonly;
  RxReadonly<int> get cabinetFilterSelectedIndexRx => _model.filterIndexForCabinets.readonly;
  RxReadonly<Set<int>> get categoryFilterSelectedIndicesRx => _model.filterIndexForCategories.readonly;

  // MARK: - Init

  @override
  void onInit() {
    super.onInit();
    LogUtil.i(EnumLogType.debug, '[WarehouseItemPageController] onInit - $hashCode');
    _genFilterRuleForRoom();
    _queryApiData();
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
    final allItems = _flattenAllItems();
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

  int getTotalLowStockCount() {
    final allItems = _flattenAllItems();
    return allItems.where((item) => item.minStockAlert != null && item.quantity != null && item.quantity! <= item.minStockAlert!).length;
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
    if (item.minStockAlert != null && item.minStockAlert! > 0 && item.quantity != null) {
      return item.quantity! <= item.minStockAlert!;
    }

    return false;
  }

  String getItemCategoriesName(Item item) {
    List<String> names = [];

    void extractCategories(dynamic category) {
      if (category != null) {
        final categoryName = category.name;
        if (categoryName != null && categoryName is String) {
          names.add(categoryName);
        } else if (categoryName != null) {
          names.add(categoryName.toString());
        }
        extractCategories(category.children);
      }
    }

    extractCategories(item.category);
    return names.join(' > ');
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

  // 扁平化所有物品
  List<Item> _flattenAllItems() {
    return _model.allRoomCabinetItems.value?.expand<Cabinet>((room) => room.cabinets ?? []).expand<Item>((cabinet) => cabinet.items ?? []).toList() ??
        [];
  }

  // 生成房間篩選列表
  void _genFilterRuleForRoom() {
    _model.filterRuleForRooms.clear();
    _model.filterRuleForRooms.addAll([
      WarehouseNameIdModel(id: 'all', name: '全部'),
      ..._service.rooms,
    ]);
  }

  // 生成櫥櫃篩選列表
  void _genFilterRuleForCabinet() {
    final allRoomsCabinets = _model.allRoomCabinetItems.value ?? [];
    final roomIdx = _model.filterIndexForRooms.value;
    final List<WarehouseNameIdModel> resultRules = [WarehouseNameIdModel(id: 'all', name: '全部')];

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
    final List<WarehouseNameIdModel> resultRules = [WarehouseNameIdModel(id: 'all', name: '全部')];

    if (roomIndex == 0 && cabinetIndex == 0) {
      allItems = _flattenAllItems();
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
}
